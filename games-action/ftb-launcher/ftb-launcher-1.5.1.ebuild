# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7

inherit desktop java-pkg-2 xdg

DESCRIPTION="Feed The Beast Minecraft launcher for community-made modpacks"
HOMEPAGE="https://www.feed-the-beast.com/"
SRC_URI="http://webly3d.net/static/edgets-overlay/games-action/ftb-launcher/${P}.jar
	https://images2.wikia.nocookie.net/__cb20121118001346/feedthebeastmodpack/images/5/5f/Ftb_logo.png -> ${PN}.png"

KEYWORDS="~amd64 ~x86"
LICENSE="Apache-2.0"
SLOT="0"

RESTRICT="bindist mirror"

RDEPEND="virtual/jre:1.8"

S="${WORKDIR}"

src_unpack() {
	# do not unpack jar file
	cp "${DISTDIR}/${PN}.png" "${S}" || die
}

src_install() {
	java-pkg_newjar "${DISTDIR}/${P}.jar" ${P}.jar
	java-pkg_dolauncher ${PN} --jar ${P}.jar --java_args "\${JAVA_OPTS}"

	doicon ${PN}.png

	make_desktop_entry ${PN} "FTB Launcher" ${PN} Game
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
