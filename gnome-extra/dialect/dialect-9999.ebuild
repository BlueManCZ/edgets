# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

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

DEPEND="dev-python/dbus-python
	dev-python/googletrans
	dev-python/gTTS
	dev-python/httpx
	dev-python/pygobject
	gui-libs/libhandy
	media-libs/gstreamer
	x11-libs/gtk+:3"

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
