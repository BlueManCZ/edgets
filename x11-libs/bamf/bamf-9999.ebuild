# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools vala

DESCRIPTION="BAMF Application Matching Framework"
HOMEPAGE="https://launchpad.net/bamf"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://git.launchpad.net/bamf"
	KEYWORDS=""
else
	SRC_URI="${HOMEPAGE}/0.5/${PV}/+download/${P}.tar.xz"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
fi

LICENSE="LGPL-3"
SLOT="0"
IUSE="doc introspection"
VALA_USE_DEPEND="vapigen"

RDEPEND="dev-libs/dbus-glib
	dev-util/gdbus-codegen
	dev-libs/glib:2
	gnome-base/libgtop
	x11-libs/gtk+:3
	x11-libs/libwnck:3
	x11-libs/libX11"

DEPEND="${RDEPEND}
	$(vala_depend)
	dev-util/gtk-doc
	virtual/pkgconfig
	x11-libs/startup-notification
	introspection? ( dev-libs/gobject-introspection )"

src_prepare() {
	eapply_user
	eautoreconf
	vala_src_prepare
}

src_configure() {
	local econfargs=(
		--disable-gtktest
		$(use_enable doc gtk-doc)
		$(use_enable introspection))

	econf "${econfargs[@]}" "$@"
}
