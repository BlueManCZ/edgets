# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg

DESCRIPTION="Free calls, text and picture sharing with anyone, anywhere"
HOMEPAGE="https://viber.com"
SRC_URI="https://download.cdn.viber.com/cdn/desktop/Linux/viber.deb -> ${P}.deb"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror strip"

RDEPEND="
	dev-libs/nss
	dev-libs/openssl
	media-libs/alsa-lib
	media-libs/libglvnd
	media-libs/mesa
	net-libs/libssh
	x11-libs/libdrm
	x11-libs/libxcb"

QA_PREBUILT="*"

S="${WORKDIR}"

src_prepare() {
	# Fix icon filename case
	mv "usr/share/icons/hicolor/scalable/apps/Viber.svg" \
		"usr/share/icons/hicolor/scalable/apps/viber.svg" || die

	# Add StartupWMClass for proper window grouping
	echo "StartupWMClass=Viber" >> usr/share/applications/viber.desktop || die

	default
}

src_install() {
	cp -a opt usr "${ED}/" || die
	dosym /opt/viber/Viber /usr/bin/viber
}
