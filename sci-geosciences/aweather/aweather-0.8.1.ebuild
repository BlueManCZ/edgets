# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit gnome2

DESCRIPTION="A weather monitoring program"
HOMEPAGE="http://pileus.org/aweather"
SRC_URI="http://pileus.org/aweather/files/${P}.tar.gz"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=sci-libs/grits-${PV}
         x11-libs/gtk+:2
         sci-libs/rsl"
DEPEND="${RDEPEND}"

DOCS="ChangeLog README TODO"
