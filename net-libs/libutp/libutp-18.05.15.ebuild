# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

COMMIT="2b364cbb0650bdab64a5de2abb4518f9f228ec44"

DESCRIPTION="uTorrent Transport Protocol library"
HOMEPAGE="https://github.com/bittorrent/libutp"
SRC_URI="${HOMEPAGE}/archive/${COMMIT}.zip -> ${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ia64 ~ppc ~ppc64 ~riscv ~sparc ~x86"

S="${WORKDIR}/${PN}-${COMMIT}"

src_install() {
	insinto "/usr/"$(get_libdir)
	doins "libutp."{"so","a"}
}
