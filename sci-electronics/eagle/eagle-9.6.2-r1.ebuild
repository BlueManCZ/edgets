# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop xdg

DESCRIPTION="EAGLE schematic and printed circuit board (PCB) layout editor"
HOMEPAGE="https://www.autodesk.com/products/eagle/overview"
SRC_URI="http://trial2.autodesk.com/NET17SWDLD/2017/EGLPRM/ESD/Autodesk_EAGLE_${PV}_English_Linux_64bit.tar.gz -> ${P}.tar.gz"

LICENSE="Autodesk-EULA"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror"
IUSE="doc"

RDEPEND="app-arch/bzip2
	app-crypt/mit-krb5
	dev-libs/expat
	dev-libs/glib
	dev-libs/gmp
	dev-libs/libbsd
	dev-libs/libffi
	dev-libs/libpcre
	dev-libs/libtasn1
	dev-libs/libunistring
	dev-libs/nettle
	dev-libs/nspr
	dev-libs/nss
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libpng:0
	media-libs/mesa
	net-dns/libidn2
	net-libs/gnutls
	net-print/cups
	sys-apps/keyutils
	sys-apps/util-linux
	sys-devel/gcc
	sys-libs/e2fsprogs-libs
	sys-libs/glibc
	sys-libs/libselinux
	sys-libs/zlib
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXdmcp
	x11-libs/libXrandr
	x11-libs/libXxf86vm
	x11-libs/libdrm
	x11-libs/libxcb
	x11-libs/libxshmfence"

QA_PREBUILT="*"

src_install() {
	doman "doc/eagle.1"
	rm "doc/eagle.1"

	if use doc ; then
		dodoc "README" || die "dodoc failed"
		dodoc -r "doc/"* || die "dodoc failed"
	fi

	rm "README"
	rm -rf "doc"

	mkdir -p "${ED}/opt/${PN}" || die "mkdir failed"
	cp -a * "${ED}/opt/${PN}" || die "cp failed"

	fperms 0755 "/opt/${PN}/${PN}" || die "fperms failed"
	fperms -R 0755 "/opt/${PN}/lib/" || die "fperms failed"
	fperms 0755 "/opt/${PN}/libexec/QtWebEngineProcess" || die "fperms failed"

	newicon "bin/${PN}-logo.png" "${PN}.png"

	dosym "/opt/${PN}/${PN}" "/usr/bin/${PN}" || dosym "fperms failed"

	make_desktop_entry ${PN} ${PN^} ${PN} "Graphics;Electronics" "StartupWMClass=${PN}"
}
