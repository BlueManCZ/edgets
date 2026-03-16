# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop unpacker xdg

MY_PN="${PN/-bin/}"

DESCRIPTION="Desktop app for Gmail — the Gmail experience you deserve"
HOMEPAGE="https://meru.so https://github.com/zoidsh/meru"
SRC_URI="https://github.com/zoidsh/meru/releases/download/v${PV}/${MY_PN}_${PV}_amd64.deb -> ${P}.deb"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror strip"
IUSE="appindicator libnotify"

RDEPEND="app-accessibility/at-spi2-core
	app-crypt/libsecret
	dev-libs/nss
	sys-apps/util-linux
	x11-libs/gtk+:3
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-misc/xdg-utils
	appindicator? ( dev-libs/libappindicator )
	libnotify? ( x11-libs/libnotify )"

QA_PREBUILT="*"

S=${WORKDIR}

src_prepare() {
	default

	# Fix duplicate MimeType entries in desktop file (upstream bug:
	# protocols.schemes and linux.mimeTypes both add x-scheme-handler/mailto)
	sed -i 's/MimeType=.*/MimeType=x-scheme-handler\/mailto;x-scheme-handler\/meru;/' \
		usr/share/applications/meru.desktop || die "sed failed"
}

src_install() {
	cp -a . "${ED}" || die "cp failed"

	# Remove upstream doc directory, let portage handle it
	rm -rf "${ED}/usr/share/doc/${MY_PN}" || true

	dosym "/opt/Meru/${MY_PN}" "/usr/bin/${MY_PN}" || die "dosym failed"
}
