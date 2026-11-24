# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake xdg

DESCRIPTION="A soundfont editor for quickly designing musical instruments"
HOMEPAGE="
	https://www.polyphone-soundfonts.com
	https://github.com/davy7125/polyphone
"
# The 2.7.3 tag changed after initial packaging; pin to an immutable commit.
COMMIT="4a9f66043523fd867e3de1ef110f4f359acf7a4c"
SRC_URI="https://github.com/davy7125/${PN}/archive/${COMMIT}.tar.gz -> ${PN}-${COMMIT}.tar.gz"

S="${WORKDIR}/${PN}-${COMMIT}/sources"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
RESTRICT="mirror"

BDEPEND="
	dev-qt/qttools:6[linguist]
	virtual/pkgconfig
"

DEPEND="
	dev-libs/openssl:=
	dev-qt/qtbase:6[concurrent,gui,network,ssl,widgets]
	dev-qt/qtsvg:6
	media-libs/alsa-lib
	media-libs/libogg
	media-libs/libsndfile
	media-libs/libvorbis
	media-libs/rtmidi
	sys-libs/zlib
	virtual/jack
"

RDEPEND="${DEPEND}"

DOCS=( ../README.md changelog )

src_prepare() {
	# The tagged sources still carry a development version string; upstream
	# sets it from the tag at release time (packaging/set_version.py).
	echo "${PV}" > version.txt || die

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DPOLYPHONE_QT_VERSION=6
		-DPOLYPHONE_BUILD_EDITOR=ON
		-DPOLYPHONE_BUILD_PLUGIN=OFF
		-DPOLYPHONE_BUILD_TESTS=OFF
		# Bundled RtAudio, as with the former qmake build
		-DPOLYPHONE_LOCAL_RTAUDIO=ON
		-DPOLYPHONE_LOCAL_RTMIDI=OFF
	)
	cmake_src_configure
}

src_install() {
	cmake_src_install
	# Docs are installed to the versioned directory through DOCS
	rm -r "${ED}/usr/share/doc/${PN}" || die
}
