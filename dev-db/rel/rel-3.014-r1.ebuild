# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop unpacker xdg

UP_PN="${PN^}"

DESCRIPTION="Rel is a database management system that implements Tutorial D."
HOMEPAGE="https://reldb.org/"
SRC_URI="https://sourceforge.net/projects/dbappbuilder/files/${UP_PN}/${UP_PN}%20version%20${PV}/${UP_PN}${PV}.linux.tar.gz/download -> ${P}.tar.gz
	https://a.fsdn.com/allura/p/dbappbuilder/icon?1516966776?&w=90 -> rel.png"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="doc"

RDEPEND=""

S="${WORKDIR}/${UP_PN}"

QA_PREBUILT="*"

src_install() {
	if use doc; then
		dodoc -r "doc/"* "LICENSE.txt"
	fi

	insinto "/opt/${PN}"
	doins -r "jre" "lib" "Rel"

	exeinto "/opt/${PN}"
	doexe "Rel"

	exeinto "/opt/${PN}/jre/bin"
	doexe "jre/bin/"*

	exeinto "/opt/${PN}/jre/lib"
	doexe "jre/lib/"*".so" "jre/lib/"{"jexec","jspawnhelper"}

	exeinto "/opt/${PN}/jre/lib/server"
	doexe "jre/lib/server/"*".so"

	dosym "/opt/${PN}/" "/usr/share/${PN}"

	doicon "${DISTDIR}/${PN}.png"

	make_desktop_entry "/opt/${PN}/${UP_PN}" ${UP_PN} ${PN} "Development;Utility;" "StartupWMClass=${UP_PN}"
}
