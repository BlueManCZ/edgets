# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Internet connection measurement for developers"
HOMEPAGE="https://www.speedtest.net/apps/cli"
SRC_URI="
	amd64? ( https://install.speedtest.net/app/cli/${P}-linux-x86_64.tgz -> ${P}-amd64.tgz )
	x86? ( https://install.speedtest.net/app/cli/${P}-linux-i386.tgz -> ${P}-x86.tgz )"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
RESTRICT="bindist mirror"
IUSE="doc"

DEPEND="app-misc/ca-certificates
	!net-analyzer/speedtest-cli"
RDEPEND="${DEPEND}"

QA_PREBUILT="*"

S="${WORKDIR}"

src_install() {
	exeinto "/usr/bin"
	doexe "speedtest"
	doman "speedtest.5"
	if use doc ; then
		dodoc "speedtest.md"
	fi
}
