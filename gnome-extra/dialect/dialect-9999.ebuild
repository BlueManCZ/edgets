# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11,12,13} )

inherit gnome2-utils meson python-single-r1 xdg

DESCRIPTION="A translation app for GNOME"
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

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	${PYTHON_DEPS}
	dev-libs/glib:2
	>=dev-libs/gobject-introspection-1.35.0
	>=media-libs/gstreamer-1.18:1.0
	>=gui-libs/gtk-4.17.5:4
	>=gui-libs/libadwaita-1.7
	>=net-libs/libsoup-3.0
	app-text/libspelling
	app-crypt/libsecret
	$(python_gen_cond_dep '
		>=dev-python/pygobject-3.51[${PYTHON_USEDEP}]
		dev-python/beautifulsoup4[${PYTHON_USEDEP}]
		dev-python/gTTS[${PYTHON_USEDEP}]
	')
"

RDEPEND="${DEPEND}"

BDEPEND="
	${PYTHON_DEPS}
	dev-util/blueprint-compiler
	virtual/pkgconfig
"

src_prepare() {
	if [[ ${PV} != 9999 ]]; then
		mv "${WORKDIR}/po-${PV}"/* po || die
	fi
	eapply_user
}

src_install() {
	meson_src_install
	python_fix_shebang "${D}"
	python_optimize
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_pkg_postrm
}
