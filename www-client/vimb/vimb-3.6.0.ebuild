# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop xdg-utils

UP_PN="${PN^}"

DESCRIPTION="A fast, lightweight, vim-like browser based on webkit"
HOMEPAGE="https://github.com/fanglingsu/vimb"
SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
IUSE="gtk3"

RDEPEND="net-libs/libsoup
	net-libs/webkit-gtk
	!gtk3? ( x11-libs/gtk+:2 )
	gtk3? ( x11-libs/gtk+:3	)"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare() {
	sed -i '/Icon/s/$/browser/' vimb.desktop
	default
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
