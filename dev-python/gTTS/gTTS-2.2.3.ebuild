# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{7..10} )

inherit distutils-r1

DESCRIPTION="gTTS (Google Text-to-Speech), a Python library and CLI tool to interface with Google Translate's text-to-speech API"
HOMEPAGE="https://pypi.org/project/gTTS"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~riscv ~sparc ~x86"
RESTRICT="mirror"

S="${WORKDIR}/${P}"

python_test() {
	distutils_enable_tests
}
