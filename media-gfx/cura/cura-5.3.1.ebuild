# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop xdg

DESCRIPTION="3D printer / slicing GUI built on top of the Uranium framework"
HOMEPAGE="https://github.com/Ultimaker/Cura"
SRC_URI="${HOMEPAGE}/releases/download/${PV}/UltiMaker-Cura-${PV}-linux-modern.AppImage -> ${P}.AppImage
	${HOMEPAGE}/blob/6f154ea44429491a66544f572135c50ecdab397a/resources/images/cura-icon.png?raw=true -> ${PN}-icon.png"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""
RESTRICT="bindist mirror strip"

RDEPEND="sys-fs/fuse"

QA_PREBUILT="*"

S="${DISTDIR}"

src_install() {
	exeinto "/opt/${PN}"
	doexe "${P}.AppImage"
	dosym "/opt/${PN}/${P}.AppImage" "/usr/bin/${PN}" || die "dosym failed"
	doicon -s 128 "${PN}-icon.png" || die "doicon failed"
	domenu "${FILESDIR}/${PN}.desktop"
}
