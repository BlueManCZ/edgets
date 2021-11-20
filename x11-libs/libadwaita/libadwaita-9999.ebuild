# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
VALA_USE_DEPEND="vapigen"

inherit git-r3 vala meson xdg

DESCRIPTION="Building blocks for modern GNOME applications"
HOMEPAGE="https://gitlab.gnome.org/GNOME/libadwaita"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="LGPL-2.1+"
SLOT="0"

DEPEND="dev-libs/fribidi
	dev-libs/glib:2
	dev-libs/gobject-introspection
	>=gui-libs/gtk-4.4.0"

RDEPEND="${DEPEND}"

src_prepare() {
	eapply_user
	vala_src_prepare
	export VALA_API_GEN="${VAPIGEN}"
}
