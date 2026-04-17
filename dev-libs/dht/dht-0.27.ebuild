# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="BitTorrent DHT library"
HOMEPAGE="https://github.com/jech/dht"
SRC_URI="${HOMEPAGE}/archive/refs/tags/${P}.tar.gz"
S="${WORKDIR}/${PN}-${P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~sparc ~x86"
RESTRICT="mirror"
IUSE="examples"

DEPEND="examples? ( virtual/libcrypt )"
RDEPEND="${DEPEND}"

src_compile() {
	tc-export CC AR

	${CC} ${CFLAGS} ${CPPFLAGS} -c -o dht.o dht.c || die
	${AR} rcs libdht.a dht.o || die

	if use examples; then
		${CC} ${CFLAGS} ${CPPFLAGS} -c -o dht-example.o dht-example.c || die
		${CC} ${CFLAGS} ${LDFLAGS} -o dht-example dht-example.o dht.o -lcrypt || die
	fi
}

src_install() {
	dolib.a libdht.a
	doheader dht.h

	use examples && dobin dht-example

	einstalldocs
}
