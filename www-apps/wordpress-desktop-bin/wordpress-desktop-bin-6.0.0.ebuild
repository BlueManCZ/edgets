# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop unpacker xdg-utils

MY_PN="${PN/-bin/}"
UP_PN="WordPressDesktop"
ICON="wpcom"
NAME="WordPress.com"

DESCRIPTION="WordPress.com Desktop Client"
HOMEPAGE="https://github.com/Automattic/wp-desktop"
SRC_URI="${HOMEPAGE}/releases/download/v${PV}/${NAME}-linux-deb-${PV}.deb -> ${P}.deb"

LICENSE="GPLv2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="libnotify"

RDEPEND="dev-libs/nss
	gnome-base/gconf
	libnotify? ( x11-libs/libnotify )
	media-libs/libglvnd
	media-libs/vulkan-loader
	media-video/ffmpeg
	x11-libs/libXtst"

S="${WORKDIR}"

QA_PREBUILT="*"

src_prepare() {
	rm "opt/${NAME}/"*".so"
	rm -r "opt/${NAME}/swiftshader"
	default
}

src_install() {
	insinto "/opt/${MY_PN}"
	doins -r "opt/${NAME}/"*

	exeinto "/opt/${MY_PN}"
	doexe "opt/${NAME}/wpcom"

	dosym "/usr/lib64/chromium/libffmpeg.so" "/opt/${MY_PN}/libffmpeg.so"

	dosym "/opt/${MY_PN}/wpcom" "/usr/bin/${MY_PN}"
	dosym "/opt/${MY_PN}/" "/usr/share/${MY_PN}"

	doicon "usr/share/icons/hicolor/512x512/apps/${ICON}.png"

	make_desktop_entry ${MY_PN} ${NAME} ${ICON} "Development" "StartupWMClass=${UP_PN}\nStartupNotify=true"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
