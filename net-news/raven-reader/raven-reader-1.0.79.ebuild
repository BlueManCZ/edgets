# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=8
inherit desktop xdg

DESCRIPTION="Simple desktop RSS Reader"
HOMEPAGE="https://github.com/hello-efficiency-inc/raven-reader"
SRC_URI="${HOMEPAGE}/releases/download/v${PV}/Raven-Reader-${PV}.AppImage -> ${P}.AppImage
	${HOMEPAGE}/blob/master/public/icon.png?raw=true -> ${PN}.png"

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
	doicon -s 512 "${PN}.png" || die "doicon failed"
	domenu "${FILESDIR}/${PN}.desktop"
}
