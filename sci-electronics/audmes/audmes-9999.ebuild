# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=8
inherit cmake xdg

DESCRIPTION="Multi-platfrom system for audio measurement through sound card in the PC."
HOMEPAGE="https://github.com/swwa/audmes"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
	RESTRICT="mirror"
fi

LICENSE="GPL-2"
SLOT="0"

DEPEND="dev-libs/libfccp
	media-libs/rtaudio
	media-sound/pulseaudio[alsa]
	x11-libs/wxGTK"

RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-system-rtaudio.patch"
	"${FILESDIR}/${PN}-remove-docs.patch"
)

src_prepare() {
	# Remove bundled rtaudio and use media-libs/rtaudio instead.
	rm -r "rtaudio"
	cmake_src_prepare
}
