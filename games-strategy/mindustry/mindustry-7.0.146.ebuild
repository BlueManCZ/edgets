# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit java-pkg-2 desktop xdg

BUILD_VERSION=$(ver_cut 3-)

DESCRIPTION="A sandbox tower defense game"
HOMEPAGE="https://mindustrygame.github.io/"
SRC_URI="https://github.com/Anuken/Mindustry/releases/download/v${BUILD_VERSION/pre/}/Mindustry.jar -> ${P}.jar"

LICENSE="GPL-3"
SLOT="$(ver_cut 1)"
RESTRICT="mirror"
KEYWORDS="~amd64 ~x86"

RDEPEND="|| (
	>=virtual/jre-1.8
	>=virtual/jdk-1.8
)"

S="${WORKDIR}"

src_unpack() {
	cp "${DISTDIR}/"* "${S}" || die
	cp "${FILESDIR}/"* "${S}" || die
}

src_compile() {
	not
}

src_install() {
	EXEC="${PN}-"$(ver_cut 1)

	if [ ! -f "/usr/share/pixmaps/mindustry.png" ]; then
		doicon "mindustry.png" || die "doicon failed"
	fi

	java-pkg_newjar "${P}.jar" "${EXEC}.jar"
	echo "export SDL_VIDEO_X11_WMCLASS=${EXEC}" > "environment.txt"
	java-pkg_dolauncher "${EXEC}" --jar "${EXEC}.jar" --java_args "\${JAVA_OPTS}" -pre "environment.txt"

	if [[ $BUILD_VERSION == *"pre"* ]]; then
		STATUS="Pre-Alpha"
	fi

	make_desktop_entry "${EXEC}" "${PN^} "$(ver_cut 1-2)" ${STATUS}" "${PN}" "Game" "StartupWMClass=${EXEC}"
}
