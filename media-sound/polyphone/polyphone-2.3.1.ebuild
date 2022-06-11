# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils xdg

DESCRIPTION="A soundfont editor for quickly designing musical instruments."
HOMEPAGE="https://www.polyphone-soundfonts.com"
SRC_URI="${HOMEPAGE}/download/file/893-polyphone-$(ver_rs 1- '-')-zip/latest/download -> polyphone-${PV}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
RESTRICT="mirror"

BDEPEND="dev-qt/linguist-tools:5"

DEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	virtual/jack
	media-libs/portaudio
	media-libs/rtmidi
	media-libs/stk
	dev-libs/qcustomplot"

RDEPEND="${DEPEND}
	dev-qt/qtsvg:5"

S="${WORKDIR}"

src_prepare() {
	default
	DESKTOP="contrib/com.polyphone_soundfonts.polyphone.desktop"
	cp "${DESKTOP}" "tmp.desktop"
	sed 's/\r$//' "tmp.desktop" > "$DESKTOP"
}

src_configure() {
	eqmake5 PREFIX="/usr"
}

src_install() {
	emake INSTALL_ROOT="${D}" install
	mv "${ED}/usr/share/doc/${PN}" "${ED}/usr/share/doc/${P}"
	einstalldocs
}
