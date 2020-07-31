# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop unpacker xdg-utils

MY_PN="${PN/-bin/}"
UP_PN="${MY_PN^}"

DESCRIPTION="GitHub Notifications on your menu bar"
HOMEPAGE="https://www.gitify.io/"
SRC_URI="https://github.com/manosim/gitify/releases/download/v${PV}/${MY_PN}_${PV}_amd64.deb -> ${P}.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="-libnotify -xscreensaver -xtest"

RDEPEND="app-accessibility/at-spi2-core
	app-crypt/libsecret
	dev-libs/libappindicator
	dev-libs/nss
	sys-apps/util-linux
	x11-libs/gtk+
	libnotify? ( x11-libs/libnotify )
	xscreensaver? ( x11-libs/libXScrnSaver )
	xtest? ( x11-libs/libXtst )
	x11-misc/xdg-utils"

S="${WORKDIR}"

QA_PREBUILT="*"

src_install() {
	insinto /opt/${MY_PN}
	doins -r opt/${UP_PN}/*

	exeinto /opt/${MY_PN}
	doexe opt/${UP_PN}/{gitify,chrome-sandbox} opt/${UP_PN}/*.so

	exeinto /opt/${MY_PN}/swiftshader
	doexe opt/${UP_PN}/swiftshader/*.so

	dosym /opt/${MY_PN}/${MY_PN} /usr/bin/${MY_PN}
	dosym /opt/${MY_PN}/ /usr/share/${MY_PN}

	doicon usr/share/icons/hicolor/128x128/apps/${MY_PN}.png

	make_desktop_entry ${MY_PN} ${UP_PN} ${MY_PN} "Development;" "StartupWMClass=${MY_PN}"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
