# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop unpacker xdg-utils

MY_PN="${PN/-bin/}"
UP_PN="${MY_PN^}"

DESCRIPTION="Min is a fast, minimal browser that protects your privacy"
HOMEPAGE="https://minbrowser.github.io/min/"
SRC_URI="https://github.com/minbrowser/min/releases/download/v${PV}/${MY_PN}_${PV}_amd64.deb -> ${P}.deb"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gnome-keyring libnotify pulseaudio xscreensaver xtest"

RDEPEND="dev-libs/libgcrypt
	dev-libs/nss
	gnome-base/gconf
	gnome-keyring? ( gnome-base/gnome-keyring )
	gnome-base/gvfs
	libnotify? ( x11-libs/libnotify )
	media-libs/alsa-lib
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

S="${WORKDIR}"

QA_PREBUILT="/opt/${MY_PN}/*.so
	/opt/${MY_PN}/swiftshader/*.so
	/opt/${MY_PN}/min
	/opt/${MY_PN}/crashpad_handler"

src_install() {
	dodoc -r usr/share/doc/*

	insinto /opt/${MY_PN}
	doins -r usr/lib/${MY_PN}/*

	insinto /usr/share
	doins -r usr/share/lintian usr/share/pixmaps usr/share/applications

	exeinto /opt/${MY_PN}
	doexe usr/lib/${MY_PN}/min usr/lib/${MY_PN}/crashpad_handler usr/lib/${MY_PN}/*.so

	exeinto /opt/${MY_PN}/swiftshader/
	doexe usr/lib/${MY_PN}/swiftshader/*.so

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
