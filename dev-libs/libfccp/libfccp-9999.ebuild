# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=8
inherit git-r3

DESCRIPTION="Small, easy-to-use and fast header-only library for reading comma separated value (CSV) files."
HOMEPAGE="https://github.com/ben-strasser/fast-cpp-csv-parser"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="BSD-3"
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
