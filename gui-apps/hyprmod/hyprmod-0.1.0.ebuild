# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12,13,14} )

inherit desktop xdg distutils-r1

DESCRIPTION="Native GTK4/libadwaita settings app for Hyprland"
HOMEPAGE="https://github.com/BlueManCZ/hyprmod"
SRC_URI="https://github.com/BlueManCZ/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	dev-libs/glib:2
	>=dev-python/hyprland-config-0.4.3[${PYTHON_USEDEP}]
	>=dev-python/hyprland-monitors-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/hyprland-schema-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/hyprland-socket-0.9.1[${PYTHON_USEDEP}]
	>=dev-python/hyprland-state-0.2.0[${PYTHON_USEDEP}]
	>=dev-python/pygobject-3.50.1:3[${PYTHON_USEDEP}]
	gnome-base/gnome-desktop:4
	gui-libs/gtk:4[introspection]
	gui-libs/libadwaita[introspection]
"
BDEPEND="
	dev-libs/glib:2
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest

python_install_all() {
	distutils-r1_python_install_all

	domenu data/applications/io.github.bluemancz.hyprmod.desktop
	doicon -s scalable data/icons/hicolor/scalable/apps/io.github.bluemancz.hyprmod.svg

	insinto /usr/share/metainfo
	doins data/metainfo/io.github.bluemancz.hyprmod.metainfo.xml
}
