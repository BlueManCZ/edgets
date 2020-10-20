# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop unpacker xdg-utils

MY_PN="${PN/-bin/}"
UP_PN="${MY_PN^}"

DESCRIPTION="The simplest way to keep notes"
HOMEPAGE="https://simplenote.com"
GITHUB="https://github.com/Automattic/simplenote-electron"
SRC_URI="amd64? ( ${GITHUB}/releases/download/v${PV}/${UP_PN}-linux-${PV}-amd64.deb -> ${P}-amd64.deb )
	x86? ( ${GITHUB}/releases/download/v${PV}/${UP_PN}-linux-${PV}-i386.deb -> ${P}-i386.deb )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-libs/nss
	gnome-base/gconf
	media-libs/libglvnd
	media-libs/vulkan-loader
	media-video/ffmpeg[chromium]
	net-print/cups
	x11-libs/libXScrnSaver"

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
	doexe "opt/${UP_PN}/simplenote" "opt/${UP_PN}/chrome-sandbox"

	dosym "/usr/"$(get_libdir)"/chromium/libffmpeg.so" "/opt/${MY_PN}/libffmpeg.so"

	dosym "/opt/${MY_PN}/${MY_PN}" "/usr/bin/${MY_PN}"
	dosym "/opt/${MY_PN}/" "/usr/share/${MY_PN}"

	doicon "usr/share/icons/hicolor/512x512/apps/${MY_PN}.png"

	make_desktop_entry ${MY_PN} ${UP_PN} ${MY_PN} "Office" "GenericName=Note Taking Application\nStartupNotify=true\nStartupWMClass=${UP_PN}"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
