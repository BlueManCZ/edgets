# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop qmake-utils xdg

DESCRIPTION="Automatic normal map generator for sprites!"
HOMEPAGE="https://github.com/azagaya/laigter"

if [[ ${PV} == 9999 ]]; then
  EGIT_REPO_URI="https://github.com/azagaya/${PN}.git"
  inherit git-r3
else
  SRC_URI="https://github.com/azagaya/laigter/archive/${PV}.tar.gz -> ${P}.tar.gz"
  KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""
RESTRICT="mirror"
RDEPEND="dev-qt/qtcore"

src_compile() {
  mkdir "build"
  cd "build"
  eqmake5 "../"
  make -j$(nproc)
  rm "Makefile"
}

src_install() {
  insinto "/usr/share/${PN}"
  doins -r "${S}/build/"*

  exeinto "/usr/share/${PN}"
  doexe "${S}/build/laigter"

  dosym "/usr/share/${PN}/laigter" "/usr/bin/${PN}"

  newicon "images/laigter_icon.png" "laigter.png"

  make_desktop_entry ${PN} "Laigter" ${PN} "Development;Graphics" "StartupWMClass=${PN}"
}
