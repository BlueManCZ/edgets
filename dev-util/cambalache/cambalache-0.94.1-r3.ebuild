# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit gnome2-utils meson xdg

DESCRIPTION="RAD tool for Gtk 4 and 3 with a clear MVC design and data model first philosophy."
HOMEPAGE="https://gitlab.gnome.org/jpu/cambalache"
SRC_URI="${HOMEPAGE}/-/archive/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror"
IUSE=""

DEPEND="
	>=dev-libs/glib-2.80.0[introspection]
	dev-python/lxml
	>=dev-python/pygobject-3.48.0
	>=gui-libs/casilda-0.1
	>=gui-libs/gtk-4.16.0[introspection,wayland]
	>=gui-libs/gtksourceview-5[introspection]
	>=gui-libs/libadwaita-1.6.0[introspection]
	>=x11-libs/gtk+-2.24.0[introspection,wayland]
"

S=${WORKDIR}/${P}

pkg_postinst() {
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_pkg_postrm
}
