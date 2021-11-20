# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
VALA_USE_DEPEND="vapigen"

inherit git-r3 vala meson xdg

DESCRIPTION="Building blocks for modern GNOME applications"
HOMEPAGE="https://gitlab.gnome.org/GNOME/libadwaita"
EGIT_REPO_URI="${HOMEPAGE}"

RESTRICT="!test? ( test )"
LICENSE="LGPL-2.1+"
SLOT="0"

IUSE="examples gtk-doc inspector +introspection test"

DEPEND="dev-libs/fribidi
	dev-libs/glib:2
	introspection? ( dev-libs/gobject-introspection )
	>=gui-libs/gtk-4.4.0[introspection?]
	gtk-doc? ( dev-util/gtk-doc )"

RDEPEND="${DEPEND}"

src_prepare() {
	eapply_user
	vala_src_prepare
	export VALA_API_GEN="${VAPIGEN}"
}

src_configure() {
	local emesonargs=(
		$(meson_feature introspection)
		$(meson_use examples)
		$(meson_use inspector)
		$(meson_use gtk-doc gtk_doc)
		$(meson_use test tests)
	)
	meson_src_configure
}
