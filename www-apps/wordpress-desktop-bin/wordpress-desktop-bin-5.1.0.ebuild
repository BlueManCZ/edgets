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
SRC_URI="https://github.com/Automattic/wp-desktop/releases/download/v${PV}/${NAME}-linux-deb-${PV}.deb -> ${P}.deb"

LICENSE="GPLv2+"
SLOT="0"
KEYWORDS="~amd64"
IUSE="libnotify"

RDEPEND="dev-libs/nss
	gnome-base/gconf
	libnotify? ( x11-libs/libnotify )
	x11-libs/libXtst"

S="${WORKDIR}"

QA_PREBUILT="/opt/${MY_PN}/*.so
	/opt/${MY_PN}/swiftshader/*.so
	/opt/${MY_PN}/wpcom"

src_install() {
	insinto /opt/${MY_PN}
	doins -r opt/${NAME}/*

	exeinto /opt/${MY_PN}
	doexe opt/${NAME}/wpcom opt/${NAME}/*.so

	exeinto /opt/${MY_PN}/swiftshader
	doexe opt/${NAME}/swiftshader/*.so

	dosym /opt/${MY_PN}/wpcom /usr/bin/${MY_PN}
	dosym /opt/${MY_PN}/ /usr/share/${MY_PN}

	doicon usr/share/icons/hicolor/512x512/apps/${ICON}.png

	make_desktop_entry ${MY_PN} ${NAME} ${ICON} "Development" "StartupWMClass=${UP_PN}\nStartupNotify=true"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
