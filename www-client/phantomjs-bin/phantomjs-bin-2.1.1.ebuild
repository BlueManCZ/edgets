# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=8

DESCRIPTION="A headless WebKit scriptable with a JavaScript API"
HOMEPAGE="http://phantomjs.org/"
SRC_URI="https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-${PV}-linux-x86_64.tar.bz2 -> ${P}.tar.bz2"
RESTRICT="mirror"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="examples"

RDEPEND="media-libs/fontconfig"

QA_PREBUILT="*"
S="${WORKDIR}/phantomjs-${PV}-linux-x86_64/"

src_install() {
	exeinto "/usr/bin"
	doexe "bin/phantomjs"

	if use examples ; then
		insinto "/usr/share/phantomjs"
		doins -r "examples"
	fi

	dodoc "ChangeLog" "LICENSE.BSD" "README.md" "third-party.txt"
}
