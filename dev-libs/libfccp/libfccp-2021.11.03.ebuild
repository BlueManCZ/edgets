# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=8

DESCRIPTION="Small, easy-to-use and fast header-only library for reading comma separated value (CSV) files."
HOMEPAGE="https://github.com/ben-strasser/fast-cpp-csv-parser"

COMMIT="5a417973b4cea674a5e4a3b88a23098a2ab75479"
SRC_URI="https://github.com/ben-strasser/fast-cpp-csv-parser/archive/${COMMIT}.zip -> ${P}.zip"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
S="${WORKDIR}/fast-cpp-csv-parser-${COMMIT}"

LICENSE="BSD-3"
RESTRICT="mirror"
SLOT="0"
IUSE="doc"

src_prepare() {
	default
	mkdir "libfccp"
	mv "csv.h" "libfccp"
}

src_install() {
	doheader -r "libfccp"

	if use doc ; then
		dodoc "LICENSE" "README.md"
	fi
}
