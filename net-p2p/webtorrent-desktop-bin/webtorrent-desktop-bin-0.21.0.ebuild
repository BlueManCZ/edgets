# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop unpacker xdg-utils

MY_PN="${PN/-bin/}"
UP_PN="${MY_PN^}"

DESCRIPTION="WebTorrent, the streaming torrent client. For Mac, Windows, and Linux."
HOMEPAGE="https://webtorrent.io/desktop/"
SRC_URI="https://github.com/webtorrent/webtorrent-desktop/releases/download/v${PV}/${MY_PN}_${PV}_amd64.deb -> ${P}.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gnome-keyring libnotify pulseaudio xscreensaver xtest"

RDEPEND="app-accessibility/at-spi2-core
	dev-libs/nss
	gnome-keyring? ( gnome-base/gnome-keyring )
	gnome-base/gvfs
	libnotify? ( x11-libs/libnotify )
	media-libs/alsa-lib
	pulseaudio? ( media-sound/pulseaudio )
	sys-apps/lsb-release
	sys-apps/util-linux
	x11-libs/gtk+
	xscreensaver? ( x11-libs/libXScrnSaver )
	xtest? ( x11-libs/libXtst )
	x11-misc/xdg-utils"

S="${WORKDIR}"

QA_PREBUILT="/opt/${MY_PN}/*.so
	/opt/${MY_PN}/WebTorrent
	/opt/${MY_PN}/chrome-sandbox"

src_install() {
	dodoc -r usr/share/doc/*

	insinto /opt/${MY_PN}
	doins -r usr/lib/${MY_PN}/*

	insinto /usr/share
	doins -r usr/share/lintian

	exeinto /opt/${MY_PN}
	doexe usr/lib/${MY_PN}/WebTorrent usr/lib/${MY_PN}/chrome-sandbox usr/lib/${MY_PN}/*.so

	exeinto /opt/${MY_PN}/swiftshader
	doexe usr/lib/${MY_PN}/swiftshader/*.so

	dosym /opt/${MY_PN}/WebTorrent /usr/bin/${MY_PN}
	dosym /opt/${MY_PN}/ /usr/share/${MY_PN}

	doicon usr/share/icons/hicolor/256x256/apps/${MY_PN}.png

	make_desktop_entry ${MY_PN} "WebTorrent" ${MY_PN} "Network;FileTransfer;P2P" "Actions=CreateNewTorrent;OpenTorrentFile;OpenTorrentAddress;\n\
MimeType=application/x-bittorrent;x-scheme-handler/magnet;x-scheme-handler/stream-magnet;\n\
StartupNotify=true\n\
StartupWMClass=WebTorrent\n\n\
[Desktop Action CreateNewTorrent]\n\
Name=Create New Torrent...\n\
Exec=webtorrent-desktop -n\n\n\
[Desktop Action OpenTorrentFile]\n\
Name=Open Torrent File...\n\
Exec=webtorrent-desktop -o\n\n\
[Desktop Action OpenTorrentAddress]\n\
Name=Open Torrent Address...\n\
Exec=webtorrent-desktop -u"
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
