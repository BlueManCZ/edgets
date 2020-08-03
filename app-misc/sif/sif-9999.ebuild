# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7

PYTHON_COMPAT=( python3_{6,7} )

inherit git-r3 distutils-r1

DESCRIPTION="Fix runtime icons of Steam games"
HOMEPAGE="https://github.com/BlueManCZ/SIF"
EGIT_REPO_URI="${HOMEPAGE}.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"
IUSE="doc"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND=""
RDEPEND="dev-python/pygobject
  dev-python/urllib3
  dev-python/vdf"
BDEPEND=""

src_prepare() {
  rm -r images
  default
}

src_compile() {
  echo
}

src_install() {
  insinto /usr/share/${PN}
  doins *

  exeinto /usr/share/${PN}
	doexe "fix-wm-class.sh" "sif.py"

  dodoc LICENSE README.md

  dosym /usr/share/${PN}/sif.py /usr/bin/${PN}
}
