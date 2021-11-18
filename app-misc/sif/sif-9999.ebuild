# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=8

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
	dev-python/requests[${PYTHON_USEDEP}]
	dev-python/vdf[${PYTHON_USEDEP}]
	x11-libs/gtk+
	x11-misc/xdotool"

DISTUTILS_USE_SETUPTOOLS="no"

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
