# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop unpacker xdg-utils

MY_PN="${PN/-bin/}"
UP_PN="${MY_PN^}"

DESCRIPTION="A simple, clean and cross-platform music player, written with Node.js, Electron and React.js"
HOMEPAGE="https://github.com/martpie/museeks"
SRC_URI="amd64? ( https://github.com/martpie/museeks/releases/download/${PV}/${MY_PN}-amd64.deb -> ${P}-amd64.deb )
	i386? ( https://github.com/martpie/museeks/releases/download/${PV}/${MY_PN}-i386.deb -> ${P}-i386.deb )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~i386"
IUSE=""

RDEPEND="dev-libs/glib
	media-libs/libglvnd
	<media-video/ffmpeg-4.3.1[chromium]
	sys-apps/dbus"

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
	doexe "opt/${UP_PN}/museeks" "opt/${UP_PN}/crashpad_handler" "opt/${UP_PN}/chrome-sandbox"

	dosym "/usr/"$(get_libdir)"/chromium/libffmpeg.so" "/opt/${MY_PN}/libffmpeg.so"

	dosym "/opt/${MY_PN}/${MY_PN}" "/usr/bin/${MY_PN}"
	dosym "/opt/${MY_PN}/" "/usr/share/${MY_PN}"

	doicon "usr/share/icons/hicolor/512x512/apps/${MY_PN}.png"

	make_desktop_entry ${MY_PN} ${UP_PN} ${MY_PN} "Audio;AudioVideo;Player;Utility;" "StartupWMClass=${UP_PN}"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
