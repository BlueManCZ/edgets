# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=8
inherit desktop xdg

DESCRIPTION="Simple program to suspend games and applications"
HOMEPAGE="https://nyrna.merritt.codes/"

LICENSE="GPL-3"
RESTRICT="mirror"
SLOT="0"

SRC_URI="https://github.com/Merrit/nyrna/releases/download/v${PV}/Nyrna-Linux-Portable.tar.gz -> ${P}.tar.gz"
KEYWORDS="-* ~amd64"

QA_PREBUILT="*"

RDEPEND="dev-libs/keybinder
	x11-libs/gtk+
	!x11-misc/nyrna
	x11-misc/wmctrl
	x11-misc/xdotool"

S="${WORKDIR}"

src_prepare() {
	default
	rm "PORTABLE"
}

src_install() {
	insinto "/usr/share/nyrna"
	doins -r *

	exeinto "/usr/share/nyrna"
	doexe "nyrna"

	dosym "/usr/share/nyrna/nyrna" "/usr/bin/nyrna" || die "dosym failed"

	newicon "data/flutter_assets/assets/icons/codes.merritt.Nyrna.svg" "nyrna.svg" || die "icon not found"
	make_desktop_entry "nyrna" "Nyrna" "nyrna" "Utility" "StartupWMClass=nyrna"
}
