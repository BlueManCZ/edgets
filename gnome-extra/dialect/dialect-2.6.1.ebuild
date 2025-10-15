# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit gnome2-utils meson xdg

DESCRIPTION="A translation app for GNOME."
HOMEPAGE="https://github.com/dialect-app/dialect"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}.git"
else
	SRC_URI="${HOMEPAGE}/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
		https://github.com/dialect-app/po/archive/refs/tags/${PV}.tar.gz -> dialect-po-${PV}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"
fi

LICENSE="GPL-3"
RESTRICT="mirror"
SLOT="0"

DEPEND="app-crypt/libsecret
	app-text/libspelling
	dev-python/beautifulsoup4
	dev-python/gTTS
	>=dev-python/pygobject-3.51.0
	gui-libs/gtk
	gui-libs/libadwaita
	media-libs/gstreamer
	net-libs/libsoup"

src_prepare() {
	eapply_user
	if [[ ${PV} != 9999 ]]; then
		mv "../po-${PV}/"* "po"
	fi
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_pkg_postrm
}
