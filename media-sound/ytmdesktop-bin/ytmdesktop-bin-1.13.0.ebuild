# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop xdg

MY_PN="${PN/-bin/}"
WORK_NAME="youtube-music-desktop-app"

DESCRIPTION="A Desktop App for YouTube Music"
HOMEPAGE="https://ytmdesktop.app/"
GITHUB="https://github.com/ytmdesktop/ytmdesktop"
SRC_URI="${GITHUB}/releases/download/v${PV}/YouTube-Music-Desktop-App-${PV}.AppImage -> ${P}.AppImage"

LICENSE="CC0-1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="appindicator libnotify system-ffmpeg system-mesa xscreensaver"

RDEPEND="dev-libs/glib
	dev-libs/libindicator
	dev-libs/nss
	gnome-base/gconf
	sys-apps/dbus
	x11-libs/libXtst
	x11-libs/gtk+
	appindicator? ( dev-libs/libappindicator )
	libnotify? ( x11-libs/libnotify )
	xscreensaver? ( x11-libs/libXScrnSaver )
	system-ffmpeg? ( <media-video/ffmpeg-4.3[chromium] )
	system-mesa? ( media-libs/mesa )"

QA_PREBUILT="*"

ARCHIVE_ROOT="squashfs-root"
S="${WORKDIR}/${ARCHIVE_ROOT}"

src_unpack() {
	cp "${DISTDIR}/${P}.AppImage" "${P}.AppImage"
	chmod u+x "${P}.AppImage"
	./${P}.AppImage --appimage-extract || die "Appimage extraction failed."
	rm -r "${ARCHIVE_ROOT}/usr/lib"
}

src_prepare() {
	default

	if use system-ffmpeg ; then
		rm -f  "libffmpeg.so" || die "rm failed"
	fi

	if use system-mesa ; then
		rm -fr "swiftshader" || die "rm failed"
		rm -f  "libEGL.so" || die "rm failed"
		rm -f  "libGLESv2.so" || die "rm failed"
		rm -f  "libvk_swiftshader.so" || die "rm failed"
		rm -f  "libvulkan.so" || die "rm failed"
		rm -f  "vk_swiftshader_icd.json" || die "rm failed"
	fi

	rm "${WORK_NAME}.png"
	rm "${WORK_NAME}.desktop"
	mv "usr/share/icons/hicolor/0x0/apps/${WORK_NAME}.png" "../${WORK_NAME}.png"
	rm -r "usr"
}

src_install() {
	insinto "/opt/${MY_PN}"
	doins -r *

	exeinto "/opt/${MY_PN}"
	doexe ${WORK_NAME} "AppRun" "chrome-sandbox"

	if use system-ffmpeg ; then
		dosym "/usr/"$(get_libdir)"/chromium/libffmpeg.so" "/opt/${MY_PN}/libffmpeg.so" || die "dosym failed"
	fi

	dosym "/opt/${MY_PN}/AppRun" "/usr/bin/${MY_PN}"
	dosym "/opt/${MY_PN}/" "/usr/share/${MY_PN}"

	doicon "../${WORK_NAME}.png"

	Categories="AudioVideo;Player;Audio;"
	MimeType="MimeType=x-scheme-handler/ytmd;"
	WMClass="StartupWMClass=${WORK_NAME}"

	if use appindicator; then
		make_desktop_entry "env XDG_CURRENT_DESKTOP=KDE ${MY_PN}" "YouTube Music" ${WORK_NAME} ${Categories} "${MimeType}\n${WMClass}"
	else
		make_desktop_entry ${MY_PN} "YouTube Music" ${WORK_NAME} ${Categories} "${MimeType};\n${WMClass}"
	fi
}
