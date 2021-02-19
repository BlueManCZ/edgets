# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit autotools git-r3 vala

DESCRIPTION="BAMF Application Matching Framework"
HOMEPAGE="https://launchpad.net/bamf"
EGIT_REPO_URI="https://git.launchpad.net/bamf"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
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
