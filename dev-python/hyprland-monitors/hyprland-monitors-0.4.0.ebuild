# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12,13,14} )

inherit distutils-r1 pypi

DESCRIPTION="Monitor management utilities for Hyprland"
HOMEPAGE="
	https://github.com/BlueManCZ/hyprland-monitors/
	https://pypi.org/project/hyprland-monitors/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-python/hyprland-socket-0.9.0[${PYTHON_USEDEP}]
"
