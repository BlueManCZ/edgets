# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop java-pkg-2 xdg

MY_PV=$(ver_cut 3-)

DESCRIPTION="A sandbox tower defense game"
HOMEPAGE="
	https://mindustrygame.github.io/
	https://github.com/Anuken/Mindustry/
"
SRC_URI="https://github.com/Anuken/Mindustry/releases/download/v${MY_PV}/Mindustry.jar -> ${P}.jar"
S="${WORKDIR}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=virtual/jre-1.8:*"
BDEPEND="app-arch/unzip"

src_unpack() {
	unzip -jq "${DISTDIR}/${A}" icons/icon_64.png || die
}

src_compile() { :; }

src_install() {
	java-pkg_newjar "${DISTDIR}/${A}" "${PN}.jar"
	newicon -s 64 icon_64.png "${PN}.png"

	echo "export SDL_VIDEO_X11_WMCLASS=${PN}" > environment.txt || die
	java-pkg_dolauncher "${PN}" \
		--jar "${PN}.jar" \
		--java_args "\${JAVA_OPTS}" \
		-pre environment.txt

	make_desktop_entry --eapi9 \
		"${PN}" \
		--name "${PN^}" \
		--icon "${PN}" \
		--categories "Game;StrategyGame;" \
		--entry "StartupWMClass=${PN}" \
		--entry "GenericName=Tower Defense Sandbox" \
		--entry "Keywords=game;strategy;tower;defense;factory;automation;"
}
