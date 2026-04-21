# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils xdg

DESCRIPTION="Pretty simple GNOME shell theme inspired by material design"
HOMEPAGE="
	https://drasite.com/flat-remix-gnome
	https://github.com/daniruiz/flat-remix-gnome
"
SRC_URI="https://github.com/daniruiz/flat-remix-gnome/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="CC-BY-SA-4.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
RESTRICT="mirror"

src_install() {
	insinto /usr/share/themes
	doins -r themes/Flat-Remix-*

	insinto /usr/share/glib-2.0/schemas
	doins share/glib-2.0/schemas/*.gschema.override

	insinto /usr/share/gnome-shell/modes
	doins share/gnome-shell/modes/*.json

	insinto /usr/share/gtksourceview-3.0/styles
	doins share/gtksourceview-3.0/styles/*.xml

	insinto /usr/share/gtksourceview-4/styles
	doins share/gtksourceview-4/styles/*.xml

	insinto /usr/share/gtksourceview-5/styles
	doins share/gtksourceview-5/styles/*.xml

	insinto /usr/share/wayland-sessions
	doins share/wayland-sessions/*.desktop

	insinto /usr/share/xsessions
	doins share/xsessions/*.desktop
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_pkg_postrm
}
