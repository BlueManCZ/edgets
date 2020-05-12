# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit gnome2

DESCRIPTION="Virtual Globe library"
HOMEPAGE="http://pileus.org/aweather/grits"
SRC_URI="http://pileus.org/grits/files/${P}.tar.gz"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND="dev-libs/glib:2
         net-libs/libsoup
         x11-libs/gtk+:2"

DOCS="ChangeLog README TODO"
