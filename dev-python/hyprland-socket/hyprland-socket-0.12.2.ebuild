# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{12,13,14} )

inherit distutils-r1 pypi

DESCRIPTION="Typed Python library for Hyprland IPC via Unix sockets"
HOMEPAGE="
	https://github.com/BlueManCZ/hyprland-socket/
	https://pypi.org/project/hyprland-socket/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
