# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop unpacker xdg-utils

MY_PN="${PN/-bin/}"
UP_PN="gSubs"

DESCRIPTION="A desktop app that finds you the perfect subtitle match for your videos"
HOMEPAGE="https://cholaware.com/gsubs/"
SRC_URI="https://github.com/sanjevirau/gsubs/releases/download/v${PV}/${MY_PN}_${PV}_amd64.deb -> ${P}.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="-libnotify xscreensaver xtest"

RDEPEND="dev-libs/libappindicator
	dev-libs/nss
	gnome-base/gconf
	libnotify? ( x11-libs/libnotify )
	media-libs/libglvnd
	media-libs/vulkan-loader
	media-video/ffmpeg[chromium]
	xscreensaver? ( x11-libs/libXScrnSaver )
	xtest? ( x11-libs/libXtst )"

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
	doexe "opt/${UP_PN}/gsubs"

	dosym "/usr/lib64/chromium/libffmpeg.so" "/opt/${MY_PN}/libffmpeg.so"

	dosym "/opt/${MY_PN}/${MY_PN}" "/usr/bin/${MY_PN}"
	dosym "/opt/${MY_PN}/" "/usr/share/${MY_PN}"

	doicon "usr/share/icons/hicolor/0x0/apps/${MY_PN}.png"

	make_desktop_entry ${MY_PN} ${UP_PN} ${MY_PN} "Utility;" "StartupWMClass=${MY_PN}"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
