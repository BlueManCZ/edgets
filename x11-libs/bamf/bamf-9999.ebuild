# Copyright 1999-2021 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_USE_DEPEND="vapigen"
VALA_MIN_API_VERSION="0.34"

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
IUSE="doc dbus introspection test"

RDEPEND="
	dev-libs/glib:2
	x11-libs/gtk+:3
	gnome-base/libgtop
	x11-libs/libwnck:3
	x11-libs/libX11
	dev-libs/dbus-glib
	dbus? ( dev-libs/libdbusmenu )
"
DEPEND="${RDEPEND}
	x11-libs/startup-notification
	introspection? ( dev-libs/gobject-introspection )
"
BDEPEND="
	$(vala_depend)
	virtual/pkgconfig
	gnome-base/gnome-common
	dev-util/gdbus-codegen
	dev-util/gtk-doc
	dev-util/gtk-doc-am
"

src_prepare() {
	eapply_user
	eautoreconf
	vala_src_prepare
	export VALA_API_GEN="${VAPIGEN}"
}

src_configure() {
	local econfargs=(
		$(use_enable doc gtk-doc)
		$(use_enable dbus export-actions-menu)
		$(use_enable introspection)
		--disable-gtktest
	)
	econf "${econfargs[@]}" "$@"
}

src_test() {
	emake check || die
}
