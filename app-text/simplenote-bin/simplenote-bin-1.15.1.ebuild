# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop unpacker xdg-utils

MY_PN="${PN/-bin/}"
UP_PN="${MY_PN^}"

DESCRIPTION="The simplest way to keep notes"
HOMEPAGE="https://simplenote.com"
SRC_URI="https://github.com/Automattic/simplenote-electron/releases/download/v${PV}/${UP_PN}-linux-${PV}-amd64.deb -> ${P}.deb"

LICENSE="GPLv2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="gnome-base/gconf"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

QA_PREBUILT="/opt/${PN}/*.so
	/opt/${PN}/swiftshader/*.so
	/opt/${PN}/simplenote
	/opt/${PN}/chrome-sandbox"

src_install() {
	insinto /opt/${PN}
	doins -r opt/${UP_PN}/*

	exeinto /opt/${PN}
	doexe opt/${UP_PN}/simplenote opt/${UP_PN}/chrome-sandbox opt/${UP_PN}/*.so

	exeinto /opt/${PN}/swiftshader/
	doexe opt/${UP_PN}/swiftshader/*.so

	dosym /opt/${PN}/${MY_PN} /usr/bin/${MY_PN}
	dosym /opt/${PN}/ /usr/share/${MY_PN}

	doicon usr/share/icons/hicolor/512x512/apps/${MY_PN}.png

	make_desktop_entry ${MY_PN} ${UP_PN} ${MY_PN} "Office" "GenericName=Note Taking Application\nStartupNotify=true\nStartupWMClass=${UP_PN}"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
