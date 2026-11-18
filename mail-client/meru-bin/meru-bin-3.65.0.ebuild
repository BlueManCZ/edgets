# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg

MY_PN="${PN/-bin/}"

DESCRIPTION="Desktop app for Gmail — the Gmail experience you deserve"
HOMEPAGE="
	https://meru.so
	https://github.com/zoidsh/meru
"
SRC_URI="https://github.com/zoidsh/meru/releases/download/v${PV}/${MY_PN}_${PV}_amd64.deb -> ${P}.deb"
S="${WORKDIR}"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="appindicator libnotify"
RESTRICT="bindist mirror strip"

RDEPEND="
	app-accessibility/at-spi2-core
	app-crypt/libsecret
	dev-libs/nss
	sys-apps/util-linux
	x11-libs/gtk+:3
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-misc/xdg-utils
	appindicator? ( dev-libs/libayatana-appindicator )
	libnotify? ( x11-libs/libnotify )
"

QA_PREBUILT="*"

src_install() {
	cp -a . "${ED}" || die "cp failed"

	# Remove upstream doc directory, let portage handle it
	rm -r "${ED}/usr/share/doc/${MY_PN}" || die "rm failed"

	# Install a wrapper that redirects stdout/stderr to /dev/null to
	# suppress the "A JavaScript error occurred in the main process" EIO
	# error thrown by Meru's internal logger (console.info ->
	# SyncWriteStream) when launched from a desktop environment where the
	# inherited stdout fd returns EIO on write.
	dodir /usr/bin
	cat > "${ED}/usr/bin/${MY_PN}" <<-EOF || die "wrapper write failed"
		#!/bin/sh
		exec /opt/Meru/${MY_PN} "\$@" >/dev/null 2>&1
	EOF
	fperms 0755 "/usr/bin/${MY_PN}"

	# Point the desktop entry at the wrapper so GUI launches use it too.
	sed -i "s|^Exec=.*|Exec=${MY_PN} %U|" \
		"${ED}/usr/share/applications/${MY_PN}.desktop" || die "sed failed"
}
