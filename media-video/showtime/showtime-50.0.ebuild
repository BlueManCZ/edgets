# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11,12,13,14} )

inherit gnome.org gnome2-utils meson python-single-r1 xdg

DESCRIPTION="A modern video player for GNOME"
HOMEPAGE="
	https://apps.gnome.org/Showtime/
	https://gitlab.gnome.org/GNOME/showtime
"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	dev-libs/glib:2
	>=gui-libs/gtk-4.18:4[introspection]
	>=gui-libs/libadwaita-1.8:1[introspection]
	>=media-libs/gstreamer-1.22:1.0[introspection]
	>=media-libs/gst-plugins-base-1.22:1.0[introspection]
	media-libs/gst-plugins-good:1.0
	media-libs/gst-plugins-bad:1.0
	media-plugins/gst-plugin-gtk4
	media-plugins/gst-plugins-aom
	media-plugins/gst-plugins-libav
	$(python_gen_cond_dep '
		>=dev-python/pygobject-3.50[${PYTHON_USEDEP}]
	')
"
DEPEND="${RDEPEND}"
BDEPEND="
	${PYTHON_DEPS}
	>=dev-util/blueprint-compiler-0.17
	sys-devel/gettext
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=(
		-Dprofile=release
		-Dpython_exec="${PYTHON}"
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	python_fix_shebang "${ED}"/usr/bin/showtime
	python_optimize
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
