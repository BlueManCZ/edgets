# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop unpacker xdg-utils

MY_PN="${PN/-bin/}"
UP_PN="GanttProject"

DESCRIPTION="A tool for creating a project schedule by means of Gantt chart and resource load chart"
HOMEPAGE="https://www.ganttproject.biz"
SRC_URI="https://www.ganttproject.biz/dl/${PV}/lin -> ${P}.deb"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="|| ( virtual/jre virtual/jdk )"

S="${WORKDIR}"

QA_PREBUILT=""

src_install() {
	dodoc -r usr/share/doc/*

	insinto /opt/${MY_PN}
	doins -r usr/share/${MY_PN}/*

	insinto /usr/share
	doins -r usr/share/pixmaps usr/share/mime

	exeinto /opt/${MY_PN}
	doexe usr/share/${MY_PN}/${MY_PN}

	dosym /opt/${MY_PN}/${MY_PN} /usr/bin/${MY_PN}
	dosym /opt/${MY_PN}/ /usr/share/${MY_PN}

	doicon usr/share/pixmaps/${MY_PN}.png

	make_desktop_entry ${MY_PN} ${UP_PN} ${MY_PN} "Office" "MimeType=application/x-ganttproject;\nStartupWMClass=org-bardsoftware-impl-eclipsito-BootImpl\$2"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}
