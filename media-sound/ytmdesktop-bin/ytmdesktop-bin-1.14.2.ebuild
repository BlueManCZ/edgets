# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop xdg

MY_PN="${PN/-bin/}"
WORK_NAME="youtube-music-desktop-app"

DESCRIPTION="A Desktop App for YouTube Music"
HOMEPAGE="https://ytmdesktop.app/"
GITHUB="https://github.com/ytmdesktop/ytmdesktop"
SRC_URI="${GITHUB}/releases/download/${PV}/ytm-desktop_ubuntu-$(ver_rs 1- '_').zip -> ${P}.zip"

LICENSE="CC0-1"
SLOT="0"
KEYWORDS="~amd64"
IUSE="appindicator libnotify xscreensaver"

RDEPEND="dev-libs/glib
	dev-libs/libindicator
	dev-libs/nss
	gnome-base/gconf
	sys-apps/dbus
	x11-libs/libXtst
	x11-libs/gtk+
	appindicator? ( dev-libs/libappindicator )
	libnotify? ( x11-libs/libnotify )
	xscreensaver? ( x11-libs/libXScrnSaver )"

QA_PREBUILT="*"

ARCHIVE_ROOT="squashfs-root"
S="${WORKDIR}/${ARCHIVE_ROOT}"

PATCHES=(
	"${FILESDIR}/${PN}-no-sandbox.patch"
)


src_unpack() {
	default

	mv "YouTube Music Desktop App-${PV}.AppImage" "${P}.AppImage"
	chmod u+x "${P}.AppImage"
	./${P}.AppImage --appimage-extract || die "Appimage extraction failed."
	rm -r "${ARCHIVE_ROOT}/usr/lib"
}

src_prepare() {
	default

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
