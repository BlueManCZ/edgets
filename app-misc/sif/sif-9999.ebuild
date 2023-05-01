# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=8

inherit git-r3

DESCRIPTION="Fix runtime icons of Steam games"
HOMEPAGE="https://github.com/BlueManCZ/SIF"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"
IUSE="doc"

RDEPEND="dev-lang/python
	dev-python/pygobject
	dev-python/requests
	dev-python/vdf
	x11-libs/gtk+
	x11-misc/xdotool"

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
