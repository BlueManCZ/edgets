# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop unpacker xdg-utils

MY_PN="SportsTracker"

DESCRIPTION="Application for people who want to record and analyze their sporting activities"
HOMEPAGE="https://github.com/ssaring/sportstracker"
SRC_URI="https://sourceforge.net/projects/sportstracker/files/SportsTracker/SportsTracker%20${PV}/Ubuntu/sportstracker-${PV}.deb"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
IUSE=""

RDEPEND=">=dev-java/openjdk-jre-bin-11.0.8_p10
	media-libs/freetype"

S="${WORKDIR}/opt/SportsTracker"

src_install() {
	insinto "/opt/sportstracker"
	doins -r "app/"*

	newicon "SportsTracker.png" "sportstracker.png"

	make_desktop_entry "/opt/openjdk-jre-bin-11/bin/java -jar /opt/sportstracker/sportstracker-${PV}.jar" ${MY_PN} ${PN} "Sports;Utility" "StartupWMClass=de.saring.sportstracker.gui.STApplication"
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
