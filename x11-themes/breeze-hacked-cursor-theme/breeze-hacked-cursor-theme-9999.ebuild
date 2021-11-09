# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit unpacker xdg git-r3

DESCRIPTION="Breeze cursor theme with hacked style"
HOMEPAGE="https://github.com/codejamninja/breeze-hacked-cursor-theme"
EGIT_REPO_URI="${HOMEPAGE}.git"

LICENSE="GPL-2"
RESTRICT="mirror"
SLOT="0"
IUSE=""

DEPEND="media-gfx/inkscape
	x11-apps/xcursorgen"

RDEPEND="${DEPEND}"

src_compile() {
	./build.sh
}

src_install() {
	insinto "/usr/share/icons/${PN}"
	doins -r "Breeze_Hacked/"*
}
