# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker xdg

MY_PN="Rel"

DESCRIPTION="Database management system that implements Tutorial D"
HOMEPAGE="https://reldb.org/"
SRC_URI="
	https://sourceforge.net/projects/dbappbuilder/files/${MY_PN}/${MY_PN}%20version%20${PV}/${MY_PN}${PV}.linux.tar.gz/download -> ${P}.tar.gz
	https://a.fsdn.com/allura/p/dbappbuilder/icon?1516966776?&w=90 -> rel.png
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="doc"
RESTRICT="strip"

RDEPEND="
	app-accessibility/at-spi2-core
	dev-libs/glib:2
	media-libs/alsa-lib
	media-libs/freetype
	media-libs/libglvnd
	sys-apps/dbus
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXtst
	x11-libs/libxkbcommon
	x11-libs/pango
"

S="${WORKDIR}/${MY_PN}"

QA_PREBUILT="*"

src_install() {
	insinto /opt/rel
	doins -r jre lib

	exeinto /opt/rel
	doexe Rel

	exeinto /opt/rel/jre/bin
	doexe jre/bin/*

	exeinto /opt/rel/jre/lib
	doexe jre/lib/*.so jre/lib/jspawnhelper

	exeinto /opt/rel/jre/lib/server
	doexe jre/lib/server/*.so

	dosym -r /opt/rel/${MY_PN} /usr/bin/rel

	newicon "${DISTDIR}"/rel.png rel.png

	make_desktop_entry "/opt/rel/${MY_PN}" "${MY_PN}" rel "Development;Utility;" "StartupWMClass=${MY_PN}"

	use doc && dodoc -r doc/* LICENSE.txt
}
