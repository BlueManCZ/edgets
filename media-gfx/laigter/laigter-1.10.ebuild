# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit desktop qmake-utils xdg-utils

DESCRIPTION="Automatic normal map generator for sprites!"
HOMEPAGE="https://github.com/azagaya/laigter"
SRC_URI="https://github.com/azagaya/laigter/archive/${PV}.tar.gz"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtcore"
DEPEND="${RDEPEND}"

src_compile() {
  mkdir build
  cd build
  eqmake5 ../
  make -j$(nproc)
  rm Makefile
}

src_install() {
  insinto /usr/share/${PN}
  doins -r ${S}/build/*

  exeinto /usr/share/${PN}
	doexe ${S}/build/laigter

  dosym /usr/share/${PN}/laigter /usr/bin/${PN}

  newicon images/laigter_icon.png laigter.png

  make_desktop_entry ${PN} "Laigter" ${PN} "Development;Graphics" "StartupWMClass=${PN}"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
