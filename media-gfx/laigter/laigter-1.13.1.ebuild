# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils xdg

DESCRIPTION="Automatic normal map generator for sprites"
HOMEPAGE="https://github.com/azagaya/laigter"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}.git"
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"
fi

LICENSE="GPL-3+"
SLOT="0"
RESTRICT="mirror"

RDEPEND="
	dev-qt/qtbase:6[gui,network,opengl,widgets]
"
DEPEND="${RDEPEND}"
BDEPEND="dev-qt/qttools:6"

src_configure() {
	eqmake6 laigter.pro PREFIX="${EPREFIX}/usr"
}

src_install() {
	emake install INSTALL_ROOT="${D}"
	dodoc README.md ACKNOWLEDGEMENTS
}
