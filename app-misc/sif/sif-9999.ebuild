# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7

PYTHON_COMPAT=( python3_{7,8,9} )

inherit git-r3 distutils-r1

DESCRIPTION="Fix runtime icons of Steam games"
HOMEPAGE="https://github.com/BlueManCZ/SIF"
EGIT_REPO_URI="${HOMEPAGE}.git"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"
IUSE="doc"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="dev-python/pygobject[${PYTHON_USEDEP}]
  dev-python/urllib3[${PYTHON_USEDEP}]
  dev-python/vdf[${PYTHON_USEDEP}]
  x11-apps/xprop"

src_prepare() {
  rm -r "images"
  default
}

src_compile() {
  not
}

src_install() {
  insinto "/usr/share/${PN}"
  doins "database.json"

  exeinto "/usr/share/${PN}"
  doexe "fix-wm-class.sh" "sif.py"

  if use doc; then
    dodoc "LICENSE" "README.md"
  fi

  dosym "/usr/share/${PN}/sif.py" "/usr/bin/${PN}"
}
