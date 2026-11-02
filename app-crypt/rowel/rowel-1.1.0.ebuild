# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit unpacker xdg

DESCRIPTION="Local-first secrets manager, formerly known as Swifty"
HOMEPAGE="
	https://rowel.app
	https://github.com/fwdai/rowel
"
SRC_URI="https://github.com/fwdai/rowel/releases/download/v${PV}/Rowel_${PV}_amd64.deb -> ${P}.deb"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror"

# The tray icon is created unconditionally on startup and loads appindicator at runtime
RDEPEND="
	dev-libs/libayatana-appindicator
	net-libs/webkit-gtk:4.1
	>=sys-libs/glibc-2.39
	x11-libs/gtk+:3
	x11-misc/xdg-utils
"

QA_PREBUILT="*"

S=${WORKDIR}

src_install() {
	cp -a . "${ED}" || die "cp failed"

	# Only holds the license text, which LICENSE already covers
	rm -r "${ED}/usr/share/doc/${PN}" || die "rm failed"
}

pkg_postinst() {
	xdg_pkg_postinst

	if has_version app-crypt/swifty; then
		ewarn "Rowel is the successor to Swifty, with a new application and storage layout."
		ewarn "Back up your Swifty vault before migrating; this package does not migrate it."
	fi
}
