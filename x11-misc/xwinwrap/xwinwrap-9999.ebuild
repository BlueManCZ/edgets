# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Utility to replace a desktop background with a movie, screensaver, etc"
HOMEPAGE="https://github.com/mmhobi7/xwinwrap"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="HPND"
SLOT="0"
KEYWORDS=""

DEPEND="x11-base/xorg-server
	x11-libs/libX11
	x11-libs/libXext
	x11-libs/libXrender"
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	sed -i 's/local//' Makefile
	default
}
