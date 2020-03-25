# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit desktop unpacker xdg-utils

MY_PN="${PN/-bin/}"
UP_PN="${MY_PN^}"

DEF_PN="${UP_PN}-linux-x64"

DESCRIPTION="A simple but smart weather app"
HOMEPAGE="https://github.com/musicpro/temps"
SRC_URI="https://github.com/musicpro/temps/releases/download/${PV}/${DEF_PN}.zip -> ${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND=""
BDEPEND=""

S="${WORKDIR}"

QA_PREBUILT="/opt/${PN}/Temps
	/opt/${PN}/libnode.so
	/opt/${PN}/libffmpeg.so"

src_install() {
	insinto /opt/${PN}
	doins -r ${DEF_PN}/*

	exeinto /opt/${PN}
	doexe ${DEF_PN}/Temps ${DEF_PN}/libnode.so

	dosym /opt/${PN}/${UP_PN} /usr/bin/${MY_PN}
	dosym /opt/${PN}/ /usr/share/${MY_PN}

	make_desktop_entry ${MY_PN} ${UP_PN} ${MY_PN} "Utility" "StartupWMClass=${UP_PN}"
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
