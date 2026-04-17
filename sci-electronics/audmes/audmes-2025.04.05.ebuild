# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

WX_GTK_VER=3.2-gtk3

inherit cmake wxwidgets xdg

DESCRIPTION="Multi-platform audio measurement system using PC sound card"
HOMEPAGE="
	https://sourceforge.net/projects/audmes/
	https://github.com/swwa/audmes
"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/swwa/audmes"
else
	SRC_URI="https://github.com/swwa/audmes/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	RESTRICT="mirror"
fi

LICENSE="GPL-2"
SLOT="0"

RDEPEND="
	dev-libs/libfccp
	media-libs/alsa-lib
	media-libs/libpulse
	x11-libs/wxGTK:${WX_GTK_VER}=[X]
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-fix-install.patch"
)

src_configure() {
	setup-wxwidgets
	cmake_src_configure
}
