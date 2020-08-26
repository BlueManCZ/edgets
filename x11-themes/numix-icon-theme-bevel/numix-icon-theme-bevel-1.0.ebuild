# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7

DESCRIPTION="The archived and no longer maintained version of Numix Circle"
HOMEPAGE="https://github.com/numixproject/numix-core/"
SRC_URI="${HOMEPAGE}/archive/v1.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
IUSE=""

S="${WORKDIR}/numix-core-1/Numix-Circle"

src_prepare() {
  sed -i "s/Circle/Bevel/g" "index.theme"
  rm "48x48/apps/nxclient-wizard.svg"
  default
}

src_install() {
  insinto "/usr/share/icons/Numix-Bevel"
  doins -r *
}
