# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit unpacker xdg

DESCRIPTION="Warp, the Rust-based terminal for developers and teams"
HOMEPAGE="https://warp.dev/"
SRC_URI="https://releases.warp.dev/stable/v0.${PV}.08.02.stable_01/warp-terminal_0.${PV}.08.02.stable.01_amd64.deb -> ${P}.deb"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror"
IUSE=""

RDEPEND="sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXi
	x11-libs/libxcb"

QA_PREBUILT="*"

S=${WORKDIR}

src_install() {
	cp -a . "${ED}" || die "cp failed"
	dosym "/opt/warpdotdev/warp-terminal/warp" "/usr/bin/warp-terminal"
}
