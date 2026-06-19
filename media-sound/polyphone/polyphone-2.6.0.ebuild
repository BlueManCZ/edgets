# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils xdg

DESCRIPTION="A soundfont editor for quickly designing musical instruments"
HOMEPAGE="
	https://www.polyphone-soundfonts.com
	https://github.com/davy7125/polyphone
"
SRC_URI="https://github.com/davy7125/${PN}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
RESTRICT="mirror"

BDEPEND="dev-qt/linguist-tools:5"

DEPEND="
	dev-libs/openssl:=
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	media-libs/alsa-lib
	media-libs/libogg
	media-libs/libsndfile
	media-libs/libvorbis
	media-libs/rtmidi
	media-libs/stk
	sys-libs/zlib
	virtual/jack
"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}/sources"

src_configure() {
	eqmake5 PREFIX="${EPREFIX}/usr"
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	mv "${ED}/usr/share/doc/${PN}" "${ED}/usr/share/doc/${PF}" || die
}
