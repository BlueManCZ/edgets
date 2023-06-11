# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop unpacker xdg

DESCRIPTION="Application for tracking your sporting activities."
HOMEPAGE="https://github.com/ssaring/sportstracker"
SRC_URI="${HOMEPAGE}/releases/download/SportsTracker-${PV}/sportstracker_${PV}-1_amd64.deb -> ${P}.deb"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror"
IUSE=""

RDEPEND="media-libs/freetype
	sys-libs/glibc
	sys-libs/zlib
	x11-misc/xdg-utils"

QA_PREBUILT="*"

S=${WORKDIR}

src_prepare() {
	rm "opt/sportstracker/lib/sportstracker-SportsTracker.desktop"
	rm -r "opt/sportstracker/share"
	default
}

src_install() {
	cp -a . "${ED}" || die "cp failed"
	newicon "opt/sportstracker/lib/SportsTracker.png" "sportstracker.png" || die "newicon failed"
	rm "${ED}/opt/sportstracker/lib/SportsTracker.png" || die "rm failed"
	dosym "/opt/sportstracker/bin/SportsTracker" "/usr/bin/sportstracker" || die "dosym failed"
	make_desktop_entry ${PN} "SportsTracker" ${PN} "Sports;Utility" "StartupWMClass=de.saring.sportstracker.gui.STApplication"
}
