# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_USE_DEPEND="vapigen"
VALA_MIN_API_VERSION="0.34"

inherit gnome2-utils meson vala xdg

DESCRIPTION="A time management utility for GNOME based on the pomodoro technique!"
HOMEPAGE="https://gnomepomodoro.org/"
SRC_URI="https://github.com/gnome-pomodoro/gnome-pomodoro/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
RESTRICT="mirror"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-libs/dbus-glib
	dev-libs/glib
	dev-libs/gobject-introspection
	dev-libs/gom
	dev-util/intltool"
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	vala_setup
	meson_src_configure
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_pkg_postrm
}
