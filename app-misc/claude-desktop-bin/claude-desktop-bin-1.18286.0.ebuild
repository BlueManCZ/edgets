# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit optfeature unpacker xdg

# Upstream deb package name (without the Gentoo -bin suffix)
MY_PN="${PN%-bin}"

DESCRIPTION="Official Claude desktop app for Linux"
HOMEPAGE="
	https://claude.com/download
	https://code.claude.com/docs/en/desktop-linux
"
SRC_URI="
	amd64? (
		https://downloads.claude.ai/claude-desktop/apt/stable/pool/main/c/claude-desktop/${MY_PN}_${PV}_amd64.deb
	)
	arm64? (
		https://downloads.claude.ai/claude-desktop/apt/stable/pool/main/c/claude-desktop/${MY_PN}_${PV}_arm64.deb
	)
"

S=${WORKDIR}

# Claude Desktop: proprietary (Anthropic Consumer Terms);
# bundled Electron/Chromium and virtiofsd: open source
LICENSE="Anthropic-Consumer-Terms Apache-2.0 BSD MIT"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"
RESTRICT="bindist mirror strip"

RDEPEND="
	app-accessibility/at-spi2-core
	app-crypt/libsecret
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/mesa
	sys-apps/dbus
	sys-apps/util-linux
	sys-apps/xdg-desktop-portal
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libdrm
	x11-libs/libnotify
	x11-libs/libX11
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libxkbcommon
	x11-libs/libXrandr
	x11-libs/libXtst
	x11-libs/pango
	x11-misc/xdg-utils
"

QA_PREBUILT="
	usr/lib/claude-desktop/*
"

src_install() {
	cp -a . "${ED}" || die "cp failed"

	# Debian-specific packaging files
	rm -r "${ED}/usr/share/doc" "${ED}/usr/share/lintian" || die "rm failed"

	# chrome-sandbox needs suid for the Chromium sandbox fallback on
	# kernels without unprivileged user namespaces
	fperms 4755 /usr/lib/claude-desktop/chrome-sandbox
}

pkg_postinst() {
	xdg_pkg_postinst

	optfeature "system tray icon support" \
		dev-libs/libayatana-appindicator
	optfeature "storing credentials in a keyring" \
		gnome-base/gnome-keyring kde-frameworks/kwallet
	optfeature "Cowork virtual machine sandboxing" \
		"app-emulation/qemu[qemu_softmmu_targets_x86_64]"

	elog "MCP configuration: ~/.config/Claude/claude_desktop_config.json"
}
