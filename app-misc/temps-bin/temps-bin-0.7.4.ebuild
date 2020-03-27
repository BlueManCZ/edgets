# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

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

S="${WORKDIR}/${DEF_PN}"

QA_PREBUILT="/opt/${MY_PN}/Temps
	/opt/${MY_PN}/libnode.so
	/opt/${MY_PN}/libffmpeg.so"

src_install() {
	insinto /opt/${MY_PN}
	doins -r *

	exeinto /opt/${MY_PN}
	doexe Temps libnode.so

	dosym /opt/${MY_PN}/${UP_PN} /usr/bin/${MY_PN}
	dosym /opt/${MY_PN}/ /usr/share/${MY_PN}

	make_desktop_entry ${MY_PN} ${UP_PN} ${MY_PN} "Utility" "StartupWMClass=${UP_PN}"
}

pkg_postinst() {
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
