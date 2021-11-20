# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7

inherit gnome.org meson vala virtualx xdg

DESCRIPTION="A text widget implementing syntax highlighting and other features"
HOMEPAGE="https://wiki.gnome.org/Projects/GtkSourceView"
GITLAB="https://gitlab.gnome.org/GNOME/gtksourceview"
SRC_URI="${GITLAB}/-/archive/${PV}/${P}.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="5"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
RESTRICT="mirror !test? ( test )"
IUSE="gtk-doc +introspection sysprof +vala"
REQUIRED_USE="vala? ( introspection )"

RDEPEND=">=dev-libs/glib-2.66:2
	>=gui-libs/gtk-4.2[introspection?]
	>=dev-libs/libxml2-2.6:2
	introspection? ( >=dev-libs/gobject-introspection-1.42.0:= )
	>=dev-libs/fribidi-0.19.7
	>=dev-libs/libpcre2-10.21"

DEPEND="${RDEPEND}"
BDEPEND="dev-util/glib-utils
	gtk-doc? (
		>=dev-util/gtk-doc-1.25
		app-text/docbook-xml-dtd:4.3
	)
	>=sys-devel/gettext-0.19.8
	virtual/pkgconfig
	vala? ( $(vala_depend) )"

src_prepare() {
	use vala && vala_src_prepare
	xdg_src_prepare
}

src_configure() {
	local emesonargs=(
		$(meson_use test install_tests)
		$(meson_feature introspection)
		$(meson_use vala vapi)
		$(meson_use gtk-doc gtk_doc)
    $(meson_use sysprof)
	)
	meson_src_configure
}

src_test() {
	if use test ; then
		virtx meson_src_test
	fi
}
