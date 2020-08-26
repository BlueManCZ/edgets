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

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+libnotify doc"

RDEPEND="app-crypt/libsecret
	dev-vcs/git
	dev-libs/libgcrypt
	dev-libs/nss
	dev-libs/openssl
	gnome-base/gconf
	gnome-base/gnome-keyring
	gnome-base/gvfs
	media-libs/libglvnd
	media-libs/mesa
	media-video/ffmpeg[chromium]
	virtual/libudev
	libnotify? ( x11-libs/libnotify )
	x11-libs/libXtst
	x11-misc/xdg-utils"

S="${WORKDIR}/usr/share"

QA_PREBUILT="*"

src_prepare() {
	rm "mailspring/"*".so"
	rm -r "mailspring/swiftshader"
	default
}

src_install() {
	dodoc -r "doc/"*

	insinto "/opt/${MY_PN}"
	doins -r "mailspring/"*

	insinto "/usr/share"
	doins -r "lintian" "pixmaps" "applications"

	insinto "/usr/share/metainfo"
	doins -r "appdata/"*

	exeinto "/opt/${MY_PN}"
	doexe "mailspring/mailspring"

	exeinto "/opt/${MY_PN}/resources/app.asar.unpacked/"
	doexe "mailspring/resources/app.asar.unpacked/mailsync" "mailspring/resources/app.asar.unpacked/mailsync.bin"

	dosym "/usr/lib64/chromium/libffmpeg.so" "/opt/${MY_PN}/libffmpeg.so"

	dosym "/opt/${MY_PN}/${MY_PN}" "/usr/bin/${MY_PN}"
	dosym "/opt/${MY_PN}/" "/usr/share/${MY_PN}"
}

pkg_postinst() {
	xdg_icon_cache_update
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
