# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop xdg-utils

MY_PN="${PN/-bin/}"
WORK_NAME="youtube-music-desktop-app"

DESCRIPTION="A Desktop App for YouTube Music"
HOMEPAGE="https://ytmdesktop.app/"
GITHUB="https://github.com/ytmdesktop/ytmdesktop"
SRC_URI="${GITHUB}/releases/download/v${PV}/YouTube.Music.Desktop.App-${PV}.AppImage -> ${P}.AppImage"

LICENSE="CC0v1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="-libnotify -xscreensaver -hardcode-tray-fix"

RDEPEND="dev-libs/libappindicator
	dev-libs/glib
	dev-libs/libindicator
	dev-libs/nss
	gnome-base/gconf
	libnotify? ( x11-libs/libnotify )
	media-libs/libglvnd
	media-libs/mesa
	media-libs/vulkan-loader
	<media-video/ffmpeg-4.3.1[chromium]
	sys-apps/dbus
	xscreensaver? ( x11-libs/libXScrnSaver )
	x11-libs/libXtst
	x11-libs/gtk+"

QA_PREBUILT="*"

ARCHIVE_ROOT="squashfs-root"
S="${WORKDIR}/${ARCHIVE_ROOT}"

src_unpack() {
	cp "${DISTDIR}/${P}".AppImage "${P}".AppImage
	chmod u+x ${P}.AppImage
	./${P}.AppImage --appimage-extract || die "Appimage extraction failed."
	rm -r ${ARCHIVE_ROOT}/usr/lib
}

src_prepare() {
	rm *".so"
	rm -r "swiftshader"
	rm "${WORK_NAME}.png"
	rm "${WORK_NAME}.desktop"
	mv "usr/share/icons/hicolor/0x0/apps/${WORK_NAME}.png" "../${WORK_NAME}.png"
	rm -r "usr"
	default
}

src_install() {
	insinto "/opt/${MY_PN}"
	doins -r *

	exeinto "/opt/${MY_PN}"
	doexe ${WORK_NAME} "AppRun" "chrome-sandbox"

	dosym "/usr/lib64/chromium/libffmpeg.so" "/opt/${MY_PN}/libffmpeg.so"

	dosym "/opt/${MY_PN}/AppRun" "/usr/bin/${MY_PN}"
	dosym "/opt/${MY_PN}/" "/usr/share/${MY_PN}"

	doicon "../${WORK_NAME}.png"

	if use hardcode-tray-fix; then
		make_desktop_entry "env XDG_CURRENT_DESKTOP=KDE ${MY_PN}" "YouTube Music" ${WORK_NAME} "AudioVideo;Player;Audio;" "MimeType=x-scheme-handler/ytmd;\nStartupWMClass=${WORK_NAME}"
	else
		make_desktop_entry ${MY_PN} "YouTube Music" ${WORK_NAME} "AudioVideo;Player;Audio;" "MimeType=x-scheme-handler/ytmd;\nStartupWMClass=${WORK_NAME}"
	fi
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
