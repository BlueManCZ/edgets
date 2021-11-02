# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop unpacker xdg

MY_PN="${PN/-bin/}"
UP_PN="${MY_PN^}"

DESCRIPTION="To-do, task, project and time management application."
HOMEPAGE="https://nozbe.com/"
SRC_URI="http://webly3d.net/static/edgets-overlay/app-office/nozbe-bin/${P}.tar.gz"

LICENSE="nozbe"
SLOT="0"
KEYWORDS="~amd64"
IUSE="libnotify xscreensaver xtest"
RESTRICT="bindist mirror"

RDEPEND="dev-libs/libappindicator
	dev-libs/nss
	gnome-base/gconf
	libnotify? ( x11-libs/libnotify )
	media-libs/alsa-lib
	media-libs/freetype
	xscreensaver? ( x11-libs/libXScrnSaver )
	xtest? ( x11-libs/libXtst )
	x11-libs/gtk+"

S="${WORKDIR}/${UP_PN}-${PV}"

QA_PREBUILT="*"

src_install() {
	insinto "/opt/${MY_PN}"
	doins -r *

	exeinto "/opt/${MY_PN}"
	doexe "Nozbe" *".so"

	dosym "/opt/${MY_PN}/${UP_PN}" "/usr/bin/${MY_PN}"
	dosym "/opt/${MY_PN}/" "/usr/share/${MY_PN}"

	newicon "Nozbe.png" "nozbe.png"

	make_desktop_entry "env XDG_CURRENT_DESKTOP=KDE ${MY_PN}" "${UP_PN}" "${MY_PN}" "Office;" "MimeType=x-scheme-handler/nozbe;\nStartupWMClass=${MY_PN}"
}
