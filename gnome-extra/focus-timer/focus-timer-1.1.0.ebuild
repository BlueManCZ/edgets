# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION="0.56"

inherit gnome2-utils meson vala xdg

DESCRIPTION="A time management utility for GNOME based on the pomodoro technique"
HOMEPAGE="
	https://gnomepomodoro.org/
	https://github.com/focustimerhq/FocusTimer
"
SRC_URI="https://github.com/focustimerhq/FocusTimer/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/FocusTimer-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bash-completion"
RESTRICT="mirror"

PATCHES=(
	"${FILESDIR}/${P}-lower-libpeas-requirement.patch"
)

RDEPEND="
	dev-db/sqlite:3
	>=dev-libs/glib-2.50:2
	>=dev-libs/gom-0.5.0
	>=dev-libs/json-glib-1.6.2
	dev-libs/libpeas:2
	>=gui-libs/gtk-4.18:4
	>=gui-libs/libadwaita-1.8.0:1
	media-libs/graphene[introspection]
	>=media-libs/gstreamer-1.0.10:1.0
	x11-libs/cairo
	x11-libs/pango
"
DEPEND="${RDEPEND}"
BDEPEND="
	$(vala_depend)
	bash-completion? ( app-shells/bash-completion )
	dev-libs/gobject-introspection
	dev-libs/libpeas:2[vala]
	sys-devel/gettext
	virtual/pkgconfig
"

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
