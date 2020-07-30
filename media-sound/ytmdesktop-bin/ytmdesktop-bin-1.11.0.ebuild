# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop xdg-utils

MY_PN="${PN/-bin/}"
UP_PN="${MY_PN^}"
WORK_NAME="youtube-music-desktop-app"

DESCRIPTION="A Desktop App for YouTube Music"
HOMEPAGE="https://ytmdesktop.app/"
SRC_URI="https://github.com/ytmdesktop/ytmdesktop/releases/download/v${PV}/YouTube.Music.Desktop.App-${PV}.AppImage -> ${P}.AppImage"

LICENSE="CC0v1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="-libnotify -xscreensaver"

RDEPEND="dev-libs/libappindicator
	dev-libs/glib
	dev-libs/libindicator
	dev-libs/nss
	gnome-base/gconf
	libnotify? ( x11-libs/libnotify )
	sys-apps/dbus
	xscreensaver? ( x11-libs/libXScrnSaver )
	x11-libs/libXtst
	x11-libs/gtk+"

S="${WORKDIR}"
ARCHIVE_ROOT="squashfs-root"

QA_PREBUILT="*"

src_unpack() {
	cp "${DISTDIR}/${P}".AppImage "${P}".AppImage
	chmod u+x ${P}.AppImage
	./${P}.AppImage --appimage-extract || die "extract appimage failed."
	rm -r ${ARCHIVE_ROOT}/usr/lib
}

S="${WORKDIR}/${ARCHIVE_ROOT}"

src_install() {
	insinto "/opt/${MY_PN}"
	doins -r *

	exeinto "/opt/${MY_PN}"
	doexe ${WORK_NAME} "AppRun" "chrome-sandbox" *.so

	exeinto "/opt/${MY_PN}/swiftshader"
	doexe swiftshader/*.so

	dosym "/opt/${MY_PN}/${WORK_NAME}" "/usr/bin/${MY_PN}"
	dosym "/opt/${MY_PN}/" "/usr/share/${MY_PN}"

	doicon "usr/share/icons/hicolor/256x256/apps/${WORK_NAME}.png"

	make_desktop_entry ${MY_PN} "YouTube Music" ${WORK_NAME} "AudioVideo;Player;Audio;" "StartupWMClass=${WORK_NAME}"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
