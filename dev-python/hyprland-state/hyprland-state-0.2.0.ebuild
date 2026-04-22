# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12,13,14} )

inherit distutils-r1 pypi

DESCRIPTION="Live state interface for Hyprland — options, animations, monitors, binds"
HOMEPAGE="
	https://github.com/BlueManCZ/hyprland-state/
	https://pypi.org/project/hyprland-state/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/hyprland-config-0.3.0[${PYTHON_USEDEP}]
	>=dev-python/hyprland-monitors-0.4.0[${PYTHON_USEDEP}]
	>=dev-python/hyprland-schema-0.3.0[${PYTHON_USEDEP}]
	>=dev-python/hyprland-socket-0.9.0[${PYTHON_USEDEP}]
"
