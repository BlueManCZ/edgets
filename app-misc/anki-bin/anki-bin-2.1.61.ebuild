# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN/-bin/}"

inherit unpacker xdg

DESCRIPTION="A spaced-repetition memory training program (flash cards)"
HOMEPAGE="https://apps.ankiweb.net"
SRC_URI="https://github.com/ankitects/anki/releases/download/${PV}/${MY_PN}-${PV}-linux-qt6.tar.zst -> ${P}.tar.zst"

LICENSE="AGPL-3+ BSD MIT GPL-3+ CC-BY-SA-3.0 Apache-2.0 CC-BY-2.5"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="!app-misc/anki"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}-linux-qt6"

QA_PREBUILT="*"

src_install() {
	PREFIX="${ED}/usr" ./install.sh
}
