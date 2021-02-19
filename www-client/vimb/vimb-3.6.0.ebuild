# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop xdg

DESCRIPTION="A fast, lightweight, vim-like browser based on webkit"
HOMEPAGE="https://github.com/fanglingsu/vimb"
SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
IUSE=""

RDEPEND="net-libs/libsoup
	net-libs/webkit-gtk
	x11-libs/gtk+:3"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	sed -i "/Icon/s/$/browser/" "vimb.desktop"
	default
}

src_compile() {
	make PREFIX="/usr"
}

src_install() {
	make PREFIX="${ED}/usr" install
}
