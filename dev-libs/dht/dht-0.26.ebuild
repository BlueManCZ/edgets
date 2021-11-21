# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="BitTorrent DHT library"
HOMEPAGE="https://github.com/jech/dht"
SRC_URI="${HOMEPAGE}/archive/refs/tags/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
RESTRICT="mirror"
IUSE="doc examples"

S="${WORKDIR}/${PN}-${P}"

RDEPEND="examples? ( virtual/libcrypt )"

src_compile() {
	make
	ar -qv "dht.a" "dht.o"

	if use examples ; then
		ar -qv "dht-example.a" "dht-example.o"
	fi
}

src_install() {
	dolib.a "dht.a"

	if use examples ; then
		dolib.a "dht-example.a"
		exeinto "/usr/bin"
		doexe "dht-example"
	fi

	if use doc ; then
		dodoc "CHANGES" "LICENSE" "README"
	fi
}
