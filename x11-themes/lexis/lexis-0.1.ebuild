# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7

DESCRIPTION="Gnome Shell theme designed for Enigmo OS 2"
HOMEPAGE="https://www.gnome-look.org/p/1012901/"
SRC_URI="http://webly3d.net/static/edgets-overlay/x11-themes/lexis/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
IUSE=""

S="${WORKDIR}"

src_install() {
	insinto /usr/share/themes/
	doins -r Lexis
}
