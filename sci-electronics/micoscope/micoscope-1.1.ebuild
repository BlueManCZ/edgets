# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit desktop xdg

DESCRIPTION="Use your pc sound card as an oscilloscope, function-generator, and UART tester."
HOMEPAGE="https://sourceforge.net/projects/micoscope/"
SRC_URI="https://master.dl.sourceforge.net/project/micoscope/micoscope-linux/micoscope-linux-x86_64-${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"

LICENSE="GPL-3"
SLOT="0"
RESTRICT="mirror"

S="${WORKDIR}/MicOscope"

src_install() {
	insinto "/opt/${PN}"
	doins "micoscope.png" "LICENSE.txt"

	dodoc "LICENSE.txt"

	doicon "micoscope.png"

	exeinto "/opt/${PN}"
	doexe "MicOscope"

	dosym "/opt/${PN}/MicOscope" "/usr/bin/${PN}"

	make_desktop_entry "${PN}" "MicOscope" "${PN}" "Electronics;Science" "StartupWMClass=${PN}"
}
