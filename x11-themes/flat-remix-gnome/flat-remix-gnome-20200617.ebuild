# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7

DESCRIPTION="Pretty simple Gnome shell theme inspired by material design"
HOMEPAGE="https://github.com/daniruiz/flat-remix"
SRC_URI="https://github.com/daniruiz/flat-remix-gnome/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC-BY-SA-4.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
IUSE=""

S="${WORKDIR}/${P}"

src_compile() {
  # Skip compilation
  echo
}

src_install() {
	insinto /usr/share/themes/
	doins -r Flat-Remix-Blue*
	doins -r Flat-Remix-Green*
	doins -r Flat-Remix-Red*
	doins -r Flat-Remix-Yellow*
  doins -r Flat-Remix-Miami*
}
