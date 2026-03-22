# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11,12,13} )

inherit gnome2-utils meson python-single-r1 xdg

DESCRIPTION="RAD tool for Gtk 4 and 3 with a clear MVC design and data model first philosophy."
HOMEPAGE="https://gitlab.gnome.org/jpu/cambalache"
SRC_URI="${HOMEPAGE}/-/archive/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
IUSE="gtk3 handy webkit6 webkit4"

DEPEND="
	${PYTHON_DEPS}
    >=dev-libs/libxml2-2.9.0
    >=gui-libs/gtk-4.18.0:4
    >=gui-libs/casilda-1.0.0
    >=gui-libs/libadwaita-1.7.0
    >=gui-libs/gtksourceview-5.16.0:5
    >=dev-python/pygobject-3.52.0
    dev-python/lxml
    gtk3? ( >=x11-libs/gtk+-3.24.0:3 )
    handy? ( >=gui-libs/libhandy-1.8.0 )
    webkit6? ( >=net-libs/webkit-gtk-2.48.0:6 )
    webkit4? ( >=net-libs/webkit-gtk-2.48.0:4.1 )
"

RDEPEND="${DEPEND}"

BDEPEND="
	${PYTHON_DEPS}
    virtual/pkgconfig
"

S=${WORKDIR}/${P}

src_install() {
    meson_src_install
	python_fix_shebang "${D}"
    python_optimize
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_pkg_postrm
}
