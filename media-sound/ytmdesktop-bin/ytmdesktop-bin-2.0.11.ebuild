# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop unpacker xdg

MY_PN="${PN/-bin/}"
WORK_NAME="youtube-music-desktop-app"

DESCRIPTION="A Desktop App for YouTube Music"
HOMEPAGE="https://ytmdesktop.app/"
GITHUB="https://github.com/ytmdesktop/ytmdesktop"
SRC_URI="${GITHUB}/releases/download/v${PV}/${WORK_NAME}_${PV}_amd64.deb -> ${P}.deb"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="appindicator doc libnotify xscreensaver"

RDEPEND="dev-libs/glib
	dev-libs/nss
	sys-apps/dbus
	x11-libs/libXtst
	x11-libs/gtk+
	appindicator? ( dev-libs/libayatana-appindicator )
	libnotify? ( x11-libs/libnotify )
	xscreensaver? ( x11-libs/libXScrnSaver )"

QA_PREBUILT="*"

S="${WORKDIR}"

src_install() {
	cp -a . "${ED}" || die "cp failed"

	rm -r "${ED}/usr/share/doc/youtube-music-desktop-app" || die "rm failed"

	if use doc ; then
		dodoc -r "usr/share/doc/youtube-music-desktop-app/"* || die "dodoc failed"
	fi
}
