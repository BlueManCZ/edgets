# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A client-side decorations library for Wayland client"
HOMEPAGE="https://gitlab.freedesktop.org/libdecor/libdecor"
SRC_URI="${HOMEPAGE}/-/archive/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="dbus"

DEPEND="dbus? ( sys-apps/dbus )"
RDEPEND="${DEPEND}"
BDEPEND="dev-libs/wayland
	x11-libs/cairo"
