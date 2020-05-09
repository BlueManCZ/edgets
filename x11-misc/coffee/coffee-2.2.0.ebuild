# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit meson vala xdg-utils gnome2-utils

MY_PN="${PN/-bin/}"
UP_PN="${MY_PN^}"

DESCRIPTION="A news and weather feed for Linux"
HOMEPAGE="https://nick92.github.io/coffee/"
SRC_URI="https://github.com/nick92/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="app-misc/geoclue
         dev-libs/glib
         dev-libs/json-glib
         dev-libs/libgee
         net-libs/libsoup
         sci-geosciences/geocode-glib
         x11-libs/gtk+"

DEPEND="$(vala_depend)"

S="${WORKDIR}/${P}"

QA_PREBUILT=""

src_prepare() {
	default
	vala_src_prepare
}

src_configure() {
	meson_src_configure
	echo "Comment=${DESCRIPTION}" >> data/com.github.nick92.coffee.desktop
}

src_install() {
	meson_src_install
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_desktop_database_update
	xdg_icon_cache_update
}
