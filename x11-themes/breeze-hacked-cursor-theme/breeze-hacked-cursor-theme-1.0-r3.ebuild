# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop unpacker xdg-utils

DESCRIPTION="Breeze cursor theme with hacked style"
HOMEPAGE="https://github.com/codejamninja/breeze-hacked-cursor-theme"
SRC_URI="https://code.jpope.org/jpope/breeze_cursor_sources/raw/master/${PN}.zip -> ${P}.zip"

LICENSE="GPLv2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=""

S="${WORKDIR}"

QA_PREBUILT=""

src_install() {
	insinto /usr/share/icons/${PN}
	doins -r Breeze_Hacked/*
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
