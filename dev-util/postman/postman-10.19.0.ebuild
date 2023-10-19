# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop xdg

DESCRIPTION="API platform for building and using APIs"
HOMEPAGE="https://www.postman.com/"
SRC_URI="https://dl.pstmn.io/download/version/${PV}/linux64 -> ${P}.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"

QA_PREBUILT="*"

S="${WORKDIR}/Postman/app"

src_install() {
	mkdir -p "${ED}/opt/postman" || die "mkdir failed"
	cp -a *  "${ED}/opt/postman" || die "cp failed"
	dosym "/opt/postman/postman" "/usr/bin/postman" || die "dosym failed"
	newicon "resources/app/assets/icon.png" "postman.png"
	make_desktop_entry "postman %U" "Postman" "postman" "Development;Utility;" "StartupWMClass=postman\nMimeType=x-scheme-handler/postman"
}
