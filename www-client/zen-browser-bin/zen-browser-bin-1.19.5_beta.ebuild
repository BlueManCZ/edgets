# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop xdg

DESCRIPTION="Experience tranquillity while browsing the web without people tracking you!"
HOMEPAGE="https://zen-browser.app/"
GITHUB="https://github.com/zen-browser/desktop"
SRC_URI="${GITHUB}/releases/download/${PV/_beta/b}/zen.linux-x86_64.tar.xz -> ${P}.tar.xz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror strip"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

QA_PREBUILT="*"

S=${WORKDIR}

src_install() {
	DEST="${ED}/opt/${PN}"
	mkdir -p "${DEST}" || die "mkdir failed"
	cp -a "zen/"* "${DEST}" || die "cp failed"

	newicon -s 128 "zen/browser/chrome/icons/default/default128.png" "${PN}.png" || die "doicon failed"

	dosym "/opt/zen-browser-bin/zen" "/usr/bin/zen-browser" || die "dosym failed"

	domenu "${FILESDIR}/${PN}.desktop"
}
