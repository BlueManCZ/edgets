# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
VALA_USE_DEPEND="vapigen"

inherit vala meson xdg

DESCRIPTION="Building blocks for modern GNOME applications"
HOMEPAGE="https://gitlab.gnome.org/GNOME/libadwaita"

COMMIT="464b37d6b1c587ce3e7699613c366e63b1e299e0"
SRC_URI="${HOMEPAGE}/-/archive/${COMMIT}/libadwaita-${COMMIT}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
S="${WORKDIR}/${PN}-${COMMIT}"

RESTRICT="mirror"
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
