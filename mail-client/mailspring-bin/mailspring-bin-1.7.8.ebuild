# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop unpacker xdg-utils

MY_PN="${PN/-bin/}"
UP_PN="${MY_PN^}"

DESCRIPTION="The best email app for people and teams at work"
HOMEPAGE="https://getmailspring.com"
SRC_URI="https://github.com/Foundry376/Mailspring/releases/download/${PV}/${MY_PN}-${PV}-amd64.deb -> ${P}.deb"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+libnotify"

RDEPEND="app-crypt/libsecret
	dev-vcs/git
	dev-libs/libgcrypt
	dev-libs/nss
	dev-libs/openssl
	gnome-base/gconf
	gnome-base/gnome-keyring
	gnome-base/gvfs
	virtual/libudev
	libnotify? ( x11-libs/libnotify )
	x11-libs/libXtst
	x11-misc/xdg-utils"

S="${WORKDIR}"

QA_PREBUILT="/opt/${MY_PN}/*.so
	/opt/${MY_PN}/resources/app.asar.unpacked/*.so*
	/opt/${MY_PN}/resources/app.asar.unpacked/mailsync*
	/opt/${MY_PN}/mailspring"

src_install() {
	dodoc -r usr/share/doc/*

	insinto /opt/${MY_PN}
	doins -r usr/share/mailspring/*

	insinto /usr/share
	doins -r usr/share/lintian usr/share/pixmaps usr/share/applications

	insinto /usr/share/metainfo
	doins -r usr/share/appdata/*

	exeinto /opt/${MY_PN}
	doexe usr/share/mailspring/mailspring usr/share/mailspring/{libEGL,libGLESv2,libVkICD_mock_icd,libffmpeg}.so

	exeinto /opt/${MY_PN}/resources/app.asar.unpacked/
	doexe usr/share/mailspring/resources/app.asar.unpacked/mailsync usr/share/mailspring/resources/app.asar.unpacked/mailsync.bin

	dosym /opt/${MY_PN}/${MY_PN} /usr/bin/${MY_PN}
	dosym /opt/${MY_PN}/ /usr/share/${MY_PN}

	doicon usr/share/pixmaps/${MY_PN}.png
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}
