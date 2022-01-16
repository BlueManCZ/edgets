# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop xdg

MY_PN="${PN/-bin/}"

DESCRIPTION="Simple desktop RSS Reader"
HOMEPAGE="https://github.com/hello-efficiency-inc/raven-reader"
SRC_URI="${HOMEPAGE}/releases/download/v${PV}/Raven-Reader-${PV}.AppImage -> ${P}.AppImage"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""
RESTRICT="bindist mirror"

RDEPEND="dev-libs/libappindicator
	dev-libs/glib
	gnome-base/gconf
	sys-apps/dbus
	x11-libs/libnotify
	x11-libs/libXScrnSaver
	x11-libs/libXtst"

QA_PREBUILT="*"

S="${WORKDIR}"
ARCHIVE_ROOT="squashfs-root"

src_unpack() {
	cp "${DISTDIR}/${P}.AppImage" "${P}.AppImage"
	chmod +x "${P}.AppImage"
	./${P}.AppImage --appimage-extract || die "appimage extraction failed"
	rm -r "${ARCHIVE_ROOT}/usr/lib" || die "rm failed"
}

S="${WORKDIR}/${ARCHIVE_ROOT}"

src_prepare() {
	default

	rm "${MY_PN}.png" || die "rm failed"
	rm ".DirIcon" || die "rm failed"
	cp "usr/share/icons/hicolor/256x256/apps/${MY_PN}.png" "${MY_PN}.png" || die "cp failed"

	rm -fr "usr" || die "rm failed"
}

src_install() {
	mkdir "${ED}/opt" || die "mkdir failed"
	cp -a . "${ED}/opt/${MY_PN}" || die "cp failed"
	fperms +rx "/opt/${MY_PN}" || die "fperms failed"
	fperms +rx "/opt/${MY_PN}/resources" || die "fperms failed"
	fperms +rx "/opt/${MY_PN}/locales" || die "fperms failed"

	dosym "/opt/${MY_PN}/${MY_PN}" "/usr/bin/${MY_PN}" || die "dosym failed"
	dosym "/opt/${MY_PN}/" "/usr/share/${MY_PN}" || die "dosym failed"

	doicon "${MY_PN}.png" || die "doicon failed"

	make_desktop_entry ${MY_PN} "Raven Reader" ${MY_PN} "Network;News" "StartupWMClass=Raven Reader"
}
