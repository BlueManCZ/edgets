# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop xdg-utils

MY_PN="${PN/-bin/}"
UP_PN="${MY_PN^}"

DESCRIPTION="Open-Source project to support Soundcloud for desktop"
HOMEPAGE="https://www.soundnodeapp.com/"
SRC_URI="https://github.com/Soundnode/soundnode-app/releases/download/${PV}-RC2/Soundnode-linux-x64.tar.xz -> ${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="xscreensaver xtest"

RDEPEND="dev-libs/nss
	gnome-base/gconf
	media-libs/libglvnd
	media-video/ffmpeg[chromium]
	xscreensaver? ( x11-libs/libXScrnSaver )
	xtest? ( x11-libs/libXtst )"

S="${WORKDIR}/Soundnode-linux-x64"

QA_PREBUILT="*"

src_prepare() {
	rm *".so"
	rm -r "swiftshader"
	default
}

src_install() {
	insinto "/opt/${MY_PN}"
	doins -r *

	exeinto "/opt/${MY_PN}"
	doexe "${UP_PN}" "chrome-sandbox" "crashpad_handler"

	dosym "/usr/"$(get_libdir)"/chromium/libffmpeg.so" "/opt/${MY_PN}/libffmpeg.so"

	dosym "/opt/${MY_PN}/${UP_PN}" "/usr/bin/${MY_PN}"
	dosym "/opt/${MY_PN}/" "/usr/share/${MY_PN}"

	doicon "resources/app/app/${MY_PN}.png"

	make_desktop_entry ${MY_PN} ${UP_PN} ${MY_PN} "Audio;AudioVideo;Player;Utility;" "StartupWMClass=${MY_PN}"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
