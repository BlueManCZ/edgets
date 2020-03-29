# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop xdg-utils

MY_PN="${PN/-bin/}"
UP_PN="${MY_PN^}"

DESCRIPTION="All your articles in one place. Beautiful."
HOMEPAGE="https://github.com/hello-efficiency-inc/raven-reader"
SRC_URI="https://github.com/hello-efficiency-inc/raven-reader/releases/download/v${PV}/Raven-Reader-${PV}.AppImage -> ${P}.AppImage"

LICENSE="LGPLv3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="-libnotify -xscreensaver -xtest"

RDEPEND="dev-libs/libappindicator
	dev-libs/glib
	gnome-base/gconf
	sys-apps/dbus
	libnotify? ( x11-libs/libnotify )
	xscreensaver? ( x11-libs/libXScrnSaver )
	xtest? ( x11-libs/libXtst )"

S="${WORKDIR}"
ARCHIVE_ROOT="squashfs-root"

QA_PREBUILT="/opt/${MY_PN}/*.so
	/opt/${MY_PN}/swiftshader/*.so
	/opt/${MY_PN}/raven-reader
	/opt/${MY_PN}/AppRun
	/opt/${MY_PN}/chrome-sandbox"

src_unpack() {
	cp "${DISTDIR}/${P}".AppImage "${P}".AppImage
	chmod u+x ${P}.AppImage
	./${P}.AppImage --appimage-extract || die "extract appimage failed."
	rm -r ${ARCHIVE_ROOT}/usr/lib
}

S="${WORKDIR}/${ARCHIVE_ROOT}"

src_install() {
	insinto /opt/${MY_PN}
	doins -r *

	exeinto /opt/${MY_PN}
	doexe raven-reader AppRun chrome-sandbox *.so

	exeinto /opt/${MY_PN}/swiftshader
	swiftshader/*.so

	dosym /opt/${MY_PN}/${MY_PN} /usr/bin/${MY_PN}
	dosym /opt/${MY_PN}/ /usr/share/${MY_PN}

	doicon usr/share/icons/hicolor/256x256/apps/${MY_PN}.png

	make_desktop_entry ${MY_PN} "Raven Reader" ${MY_PN} "Network" "StartupWMClass=Raven Reader"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
