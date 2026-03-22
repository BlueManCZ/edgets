# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )
DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Basic building blocks for Python applications"
HOMEPAGE="https://github.com/AGProjects/python3-application"
SRC_URI="${HOMEPAGE}/archive/refs/tags/release-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~riscv ~sparc ~x86"
RESTRICT="mirror"

S="${WORKDIR}/${PN}-release-${PV}"
