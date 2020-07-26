# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop unpacker xdg-utils

MY_PN="${PN/-bin/}"
UP_PN="${MY_PN^}"

DESCRIPTION="Simple program to pause games & applications"
HOMEPAGE="https://github.com/Merrit/nyrna"
SRC_URI="${HOMEPAGE}/releases/download/v${PV}/${MY_PN} -> ${P}
	https://raw.githubusercontent.com/Merrit/nyrna/master/icons/${MY_PN}.png"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="appindicator"

RDEPEND="appindicator? ( dev-libs/libappindicator )"

S="${WORKDIR}"

QA_PREBUILT="/usr/bin/${MY_PN}"

src_unpack() {
	cp "${DISTDIR}/${P}" "${S}/${MY_PN}"
	cp "${DISTDIR}/${MY_PN}.png" "${S}"
}

src_install() {
	exeinto /usr/bin
	doexe ${MY_PN}

	doicon ${MY_PN}.png

	make_desktop_entry ${MY_PN} ${UP_PN} ${MY_PN} "Utility;" "StartupWMClass=${MY_PN}"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
