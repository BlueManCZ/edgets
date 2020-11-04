# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop unpacker xdg-utils

MY_PN="${PN/-bin/}"
UP_PN="Gmail Desktop"

DESCRIPTION="Nifty Gmail desktop app"
HOMEPAGE="https://github.com/timche/gmail-desktop"
SRC_URI="${HOMEPAGE}/releases/download/${PV}/${MY_PN}-${PV}-linux.deb -> ${P}.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+libnotify doc"

RDEPEND="app-accessibility/at-spi2-core
	app-crypt/libsecret
	dev-libs/libappindicator
	dev-libs/nss
	media-libs/libglvnd
	media-libs/mesa
	media-video/ffmpeg[chromium]
	sys-apps/util-linux
	x11-libs/gtk+
	libnotify? ( x11-libs/libnotify )
	x11-libs/libXScrnSaver
	x11-libs/libXtst
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

	insinto "/usr/share"
	doins -r "usr/share/icons"

	exeinto "/opt/${MY_PN}"
	doexe "opt/${UP_PN}/"{${MY_PN},"chrome-sandbox"}

	dosym "/usr/"$(get_libdir)"/chromium/libffmpeg.so" "/opt/${MY_PN}/libffmpeg.so"

	dosym "/opt/${MY_PN}/${MY_PN}" "/usr/bin/${MY_PN}"
	dosym "/opt/${MY_PN}/" "/usr/share/${MY_PN}"

	make_desktop_entry ${MY_PN} "${UP_PN}" ${MY_PN} "Network;Office" "StartupWMClass=${UP_PN}"
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
