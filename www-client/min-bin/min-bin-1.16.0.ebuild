# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop unpacker xdg-utils

MY_PN="${PN/-bin/}"

DESCRIPTION="Min is a fast, minimal browser that protects your privacy"
HOMEPAGE="https://minbrowser.github.io/min/"
SRC_URI="amd64? ( https://github.com/minbrowser/min/releases/download/v${PV}/${MY_PN}_${PV}_amd64.deb -> ${P}-amd64.deb )
	arm64? ( https://github.com/minbrowser/min/releases/download/v${PV}/${MY_PN}_${PV}_arm64.deb -> ${P}-arm64.deb )"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="doc gnome-keyring libnotify pulseaudio xscreensaver xtest"

RDEPEND="dev-libs/libgcrypt
	dev-libs/nss
	gnome-base/gconf
	gnome-keyring? ( gnome-base/gnome-keyring )
	gnome-base/gvfs
	libnotify? ( x11-libs/libnotify )
	media-libs/alsa-lib
	media-libs/libglvnd
	media-libs/vulkan-loader
	media-video/ffmpeg[chromium]
	pulseaudio? ( media-sound/pulseaudio )
	sys-apps/lsb-release
	sys-apps/util-linux
	sys-fs/eudev
	sys-libs/libcap
	sys-libs/glibc
	x11-libs/gtk+
	xscreensaver? ( x11-libs/libXScrnSaver )
	xtest? ( x11-libs/libXtst )
	x11-misc/xdg-utils"

S="${WORKDIR}/usr"

QA_PREBUILT="*"

src_prepare() {
	rm "lib/${MY_PN}/"*".so"
	rm -r "lib/${MY_PN}/swiftshader"
	default
}

src_install() {
	if use doc; then
		dodoc -r "share/doc/"*
	fi

	insinto "/opt/${MY_PN}"
	doins -r "lib/${MY_PN}/"*

	insinto "/usr/share"
	doins -r "share/lintian" "share/pixmaps" "share/applications"

	exeinto "/opt/${MY_PN}"
	doexe "lib/${MY_PN}/min" "lib/${MY_PN}/chrome-sandbox"

	dosym "/usr/"$(get_libdir)"/chromium/libffmpeg.so" "/opt/${MY_PN}/libffmpeg.so"

	dosym "/opt/${MY_PN}/${MY_PN}" "/usr/bin/${MY_PN}"
	dosym "/opt/${MY_PN}/" "/usr/share/${MY_PN}"

	doicon "share/pixmaps/${MY_PN}.png"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
