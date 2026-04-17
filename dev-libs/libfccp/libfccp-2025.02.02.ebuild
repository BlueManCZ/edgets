# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Fast header-only CSV parser library for C++"
HOMEPAGE="https://github.com/ben-strasser/fast-cpp-csv-parser"

COMMIT="574a9fe4d323ba63416877a4a5fe59088d37aa34"
SRC_URI="https://github.com/ben-strasser/fast-cpp-csv-parser/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/fast-cpp-csv-parser-${COMMIT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
RESTRICT="mirror"

src_prepare() {
	default
	mkdir "libfccp" || die
	mv "csv.h" "libfccp" || die
}

src_install() {
	doheader -r "libfccp"

	if use doc ; then
		dodoc "LICENSE" "README.md"
	fi
}
