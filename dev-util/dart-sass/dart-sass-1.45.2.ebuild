# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=8

DESCRIPTION="The reference implementation of Sass, written in Dart."
HOMEPAGE="https://sass-lang.com/dart-sass"

LICENSE="MIT"
RESTRICT="mirror"
SLOT="0"

SRC_URI="https://github.com/sass/dart-sass/releases/download/${PV}/${P}-linux-x64.tar.gz"
KEYWORDS="-* ~amd64"

QA_PREBUILT="*"

RDEPEND="!dev-ruby/sass"

S="${WORKDIR}/${PN}"

src_install() {
	exeinto "/usr/bin"
	doexe "sass"
}
