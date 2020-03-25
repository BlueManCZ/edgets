# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit desktop unpacker xdg-utils

MY_PN="${PN/-bin/}"

DESCRIPTION="The simplest way to keep notes"
HOMEPAGE="https://simplenote.com"
SRC_URI="https://github.com/Automattic/simplenote-electron/releases/download/v${PV}/${MY_PN}-linux-${PV}-amd64.deb -> ${P}.deb"

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
	dodoc -r usr/share/doc/*

	insinto /opt/${PN}
	doins -r opt/Simplenote/*

	exeinto /opt/${PN}
	doexe opt/Simplenote/simplenote opt/Simplenote/chrome-sandbox opt/Simplenote/*.so

	exeinto /opt/${PN}/swiftshader/
	doexe opt/Simplenote/swiftshader/*.so

	dosym /opt/${PN}/${MY_PN} /usr/bin/${MY_PN}
	dosym /opt/${PN}/ /usr/share/${MY_PN}

	doicon usr/share/icons/hicolor/512x512/apps/${MY_PN}.png

	make_desktop_entry ${MY_PN} "Simplenote" ${MY_PN} "Office" "StartupWMClass=Simplenote"
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
