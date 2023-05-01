# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=8

PYTHON_COMPAT=( python3_{8..11} )

inherit distutils-r1

DESCRIPTION="Fix runtime icons of Steam games"
HOMEPAGE="https://github.com/BlueManCZ/SIF"

if [[ ${PV} == 9999 ]]; then
    inherit git-r3
    EGIT_REPO_URI="${HOMEPAGE}"
else
    SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
    KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"
	S="${WORKDIR}/SIF-${PV}"
fi

LICENSE="Apache-2.0"
SLOT="0"
IUSE="doc"

RDEPEND="dev-python/pygobject[$PYTHON_USEDEP]
	dev-python/requests[$PYTHON_USEDEP]
	dev-python/vdf[$PYTHON_USEDEP]
	x11-libs/gtk+
	x11-misc/xdotool"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

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
