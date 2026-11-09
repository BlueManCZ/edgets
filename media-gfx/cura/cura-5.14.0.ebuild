# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="3D printer / slicing GUI built on top of the Uranium framework"
HOMEPAGE="https://github.com/Ultimaker/Cura"
SRC_URI="${HOMEPAGE}/releases/download/${PV}/UltiMaker-Cura-${PV}-linux-X64.AppImage -> ${P}.AppImage"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror strip"

RDEPEND="|| ( sys-fs/fuse:0 sys-fs/fuse:3 )"

QA_PREBUILT="*"

S="${DISTDIR}"

src_install() {
	exeinto "/opt/${PN}"
	doexe "${P}.AppImage"
	dosym "/opt/${PN}/${P}.AppImage" "/usr/bin/${PN}"
	doicon -s 128 "${FILESDIR}/${PN}-icon.png"
	domenu "${FILESDIR}/${PN}.desktop"
}
