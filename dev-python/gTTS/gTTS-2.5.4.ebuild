# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="gTTS (Google Text-to-Speech), a Python library and CLI tool to interface with Google Translate's text-to-speech API"
HOMEPAGE="https://pypi.org/project/gTTS"
SRC_URI="https://files.pythonhosted.org/packages/source/${PN:0:1}/${PN}/${P,,}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~riscv ~sparc ~x86"
RESTRICT="mirror"

S="${WORKDIR}/${P,,}"

python_test() {
	distutils_enable_tests
}
