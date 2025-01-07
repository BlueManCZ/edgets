# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit meson

DESCRIPTION="A simple Wayland compositor widget for Gtk 4 which can be used to embed other
processes windows in your Gtk 4 application."
HOMEPAGE="https://gitlab.gnome.org/jpu/casilda"
SRC_URI="${HOMEPAGE}/-/archive/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="
	gui-libs/gtk
	gui-libs/wlroots
"
RDEPEND="${DEPEND}"
BDEPEND=""
