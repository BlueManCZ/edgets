# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop xdg

DESCRIPTION="A minimal web GUI for coding agents."
HOMEPAGE="https://t3.codes https://github.com/pingdotgg/t3code"
SRC_URI="${HOMEPAGE}/releases/download/v${PV}/T3-Code-${PV}-x86_64.AppImage -> ${P}.AppImage
	https://raw.githubusercontent.com/pingdotgg/t3code/v${PV}/assets/prod/black-universal-1024.png -> ${PN}.png"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror strip"

RDEPEND="sys-fs/fuse"

QA_PREBUILT="*"

S="${DISTDIR}"

src_install() {
	exeinto "/opt/${PN}"
	doexe "${P}.AppImage"
	dosym "/opt/${PN}/${P}.AppImage" "/usr/bin/${PN}"
	doicon -s 256 "${PN}.png"
	domenu "${FILESDIR}/${PN}.desktop"
}
