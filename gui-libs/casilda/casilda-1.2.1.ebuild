# Copyright 1999-2026 Gentoo Authors
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

IUSE="doc"

DEPEND="
    >=media-libs/libepoxy-1.5
    >=gui-libs/gtk-4.14:4
    >=x11-libs/pixman-0.42.0
    >=dev-libs/wayland-protocols-1.32
    >=dev-libs/wayland-1.22
    >=gui-libs/wlroots-0.19
    >=x11-libs/libxkbcommon-1.5
"
RDEPEND="${DEPEND}"
BDEPEND="
    dev-libs/wayland
    doc? ( dev-util/gi-docgen )
"
