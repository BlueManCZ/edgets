# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit python-single-r1

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

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	$(python_gen_cond_dep '
		dev-python/pygobject[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/vdf[${PYTHON_USEDEP}]
	')
	gui-libs/gtk:4
	x11-misc/xdotool
"

src_install() {
	insinto "/usr/share/${PN}"
	doins database.json

	exeinto "/usr/share/${PN}"
	doexe fix-wm-class.sh sif.py

	dosym "/usr/share/${PN}/sif.py" "/usr/bin/${PN}"

	dodoc README.md
}
