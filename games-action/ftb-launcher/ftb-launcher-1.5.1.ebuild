# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7

inherit desktop java-pkg-2 xdg

DESCRIPTION="Feed The Beast Minecraft launcher for community-made modpacks"
HOMEPAGE="https://www.feed-the-beast.com/"
SRC_URI="http://webly3d.net/static/edgets-overlay/games-action/ftb-launcher/${P}.jar
	http://webly3d.net/static/edgets-overlay/games-action/ftb-launcher/${PN}.png
	http://webly3d.net/static/edgets-overlay/games-action/ftb-launcher/${PN}-numix-circle.png"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="numix-circle-icon"

RESTRICT="bindist mirror"

RDEPEND="virtual/jre:1.8"

S="${WORKDIR}"

src_unpack() {
	# do not unpack jar file
	if use numix-circle-icon ; then
		cp "${DISTDIR}/${PN}-numix-circle.png" "${S}/${PN}.png" || die
	else
		cp "${DISTDIR}/${PN}.png" "${S}" || die
	fi
}

src_install() {
	java-pkg_newjar "${DISTDIR}/${P}.jar" ${P}.jar
	java-pkg_dolauncher ${PN} --jar ${P}.jar --java_args "\${JAVA_OPTS}"

	doicon ${PN}.png  || die

	make_desktop_entry ${PN} "FTB Launcher" ${PN} Game "StartupWMClass=net-ftb-main-Bootstrap"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
