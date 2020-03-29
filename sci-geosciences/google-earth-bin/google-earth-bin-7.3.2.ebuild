# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop unpacker xdg-utils

MY_PN="${PN/-bin/}"
UP_PN="Google Earth Pro"

DESCRIPTION="Explore, search and discover the planet."
HOMEPAGE="https://www.google.com/earth/"
SRC_URI="https://dl.google.com/dl/linux/direct/${MY_PN}-pro-stable_${PV}_amd64.deb -> ${P}.deb
	https://upload.wikimedia.org/wikipedia/commons/e/e4/Google_Earth_icon.svg -> ${MY_PN}.svg"

LICENSE="google-earth" # Available here: https://earth.google.com/intl/en/licensepro.html
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-libs/glib
	dev-libs/libxml2
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/glu
	media-libs/gstreamer
	net-libs/libproxy
	net-print/cups
	sys-apps/dbus
	sys-devel/gcc
	sys-libs/libstdc++-v3
	virtual/libc
	x11-libs/libSM
	x11-libs/libxcb
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender
	x11-libs/libXtst"

S="${WORKDIR}"

QA_PREBUILT="*"

DIR_PATH="google/earth/pro"

src_install() {
	insinto /opt/${DIR_PATH}
	doins -r opt/${DIR_PATH}/*

	exeinto /opt/${DIR_PATH}
	doexe opt/${DIR_PATH}/googleearth{,-bin} opt/${DIR_PATH}/*.so opt/${DIR_PATH}/*.so.*
	doexe opt/${DIR_PATH}/{gpsbabel,repair_tool,xdg-mime,xdg-settings}

	dosym /opt/${DIR_PATH}/googleearth /usr/bin/${MY_PN}
	dosym /opt/${DIR_PATH}/ /usr/share/${MY_PN}

	doicon ${DISTDIR}/${MY_PN}.svg

	make_desktop_entry ${MY_PN} "${UP_PN}" ${MY_PN} "Education;Network;Science" "GenericName=3D planet viewer\n\
StartupWMClass=${UP_PN}\nMimeType=application/vnd.google-earth.kml+xml;\
application/vnd.google-earth.kmz;application/earthviewer;application/keyhole"
}

pkg_postinst() {
	elog "\nGoogle Earth is licensed under its own license available here: https://earth.google.com/intl/en/licensepro.html\n"
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}
