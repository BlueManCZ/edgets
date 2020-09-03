# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop unpacker xdg-utils

MY_PN="${PN/-bin/}"
UP_PN="${MY_PN^}"

DESCRIPTION="Modern, lightweight, fast and free password manager"
HOMEPAGE="https://getswifty.pro/"
SRC_URI="https://github.com/swiftyapp/swifty/releases/download/v${PV}/${UP_PN}_${PV}_amd64.deb -> ${P}-amd64.deb"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="libnotify xscreensaver xtest"

RDEPEND="app-accessibility/at-spi2-core
	app-crypt/libsecret
	dev-libs/libappindicator
	dev-libs/nss
	libnotify? ( x11-libs/libnotify )
	media-libs/libglvnd
	media-libs/vulkan-loader
	media-video/ffmpeg[chromium]
	sys-apps/util-linux
	x11-libs/gtk+
	xscreensaver? ( x11-libs/libXScrnSaver )
	xtest? ( x11-libs/libXtst )
	x11-misc/xdg-utils"

S="${WORKDIR}"

QA_PREBUILT="*"

src_prepare() {
	rm "opt/${UP_PN}/"*".so"
	rm -r "opt/${UP_PN}/swiftshader"
	default
}

src_install() {
	insinto "/opt/${MY_PN}"
	doins -r "opt/${UP_PN}/"*

	exeinto "/opt/${MY_PN}"
	doexe "opt/${UP_PN}/swifty" "opt/${UP_PN}/chrome-sandbox"

	insinto "/usr/share"
	doins -r "usr/share/icons" "usr/share/mime"

	dosym "/usr/"$(get_libdir)"/chromium/libffmpeg.so" "/opt/${MY_PN}/libffmpeg.so"

	dosym "/opt/${MY_PN}/${MY_PN}" "/usr/bin/${MY_PN}"
	dosym "/opt/${MY_PN}" "/usr/share/${MY_PN}"

	make_desktop_entry ${MY_PN} ${UP_PN} ${MY_PN} "Utility;" "StartupWMClass=${MY_PN}"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
