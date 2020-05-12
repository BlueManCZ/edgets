# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2 flag-o-matic

DESCRIPTION="Radar Software Library"
HOMEPAGE="http://trmm-fc.gsfc.nasa.gov/trmm_gv/software/rsl/index.html"
SRC_URI="https://github.com/adokter/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPLv2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="net-libs/libtirpc
         sci-libs/hdf
         virtual/jpeg"
DEPEND="${RDEPEND}"

src_configure() {
  append-cflags $(pkg-config --cflags --libs libtirpc)
  default
}

src_install() {
  insinto /usr/include
  doins {rsl.h,toolkit_1BC-51_appl.h}
  insinto /usr/$(get_libdir)
  doins wsr88d_locations.dat
  doins -r colors
  doins .libs/librsl.so*
  exeinto /usr/bin
  doexe {wsr88d_decode_ar2v/wsr88d_decode_ar2v,examples/{any_to_gif,any_to_uf,qlook}}
  if use doc ; then
    insinto /usr/share/${P}
    doins -r doc/.
  fi
}
