# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop unpacker xdg

MY_PN="${PN/-bin/}"

DESCRIPTION="Free desktop project scheduling and management app with Gantt chart"
HOMEPAGE="https://www.ganttproject.biz https://github.com/bardsoftware/ganttproject"
SRC_URI="https://dl.ganttproject.biz/${MY_PN}-${PV}/${MY_PN}_${PV}-1_all.deb"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="mirror"

# GanttProject 3.3 requires Java 17+ (JavaFX libs are bundled in the .deb)
RDEPEND="virtual/jre:17"

S="${WORKDIR}"

QA_PREBUILT="usr/share/ganttproject/*"

PATCHES=( "${FILESDIR}/${P}-desktop-file.patch" )

src_install() {
	insinto "/usr/share/${MY_PN}"
	doins -r "usr/share/${MY_PN}/"*
	fperms +x "/usr/share/${MY_PN}/${MY_PN}"

	domenu "usr/share/applications/${MY_PN}.desktop"
	doicon "usr/share/pixmaps/${MY_PN}.png"

	insinto /usr/share/icons
	doins -r "usr/share/icons/"*

	insinto /usr/share/mime
	doins -r "usr/share/mime/"*

	dosym "../share/${MY_PN}/${MY_PN}" "/usr/bin/${MY_PN}"
}
