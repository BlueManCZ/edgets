# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# File was automatically generated by automatic-ebuild-maker
# https://github.com/BlueManCZ/automatic-ebuild-maker

EAPI=7
inherit unpacker xdg

DESCRIPTION="Unofficial Gmail Desktop App"
HOMEPAGE="https://github.com/timche/gmail-desktop#readme"
SRC_URI="https://github.com/timche/gmail-desktop/releases/download/v${PV}/gmail-desktop-${PV}-linux.deb -> ${P}.deb"

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* ~amd64"
RESTRICT="bindist mirror"
IUSE="appindicator doc libnotify system-ffmpeg system-mesa"

RDEPEND="app-accessibility/at-spi2-core
	app-crypt/libsecret
	dev-libs/nss
	sys-apps/util-linux
	x11-libs/gtk+:3
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	x11-misc/xdg-utils
	appindicator? ( dev-libs/libappindicator )
	libnotify? ( x11-libs/libnotify )
	system-ffmpeg? ( <media-video/ffmpeg-4.3[chromium] )
	system-mesa? ( media-libs/mesa )"

QA_PREBUILT="*"

S=${WORKDIR}

src_prepare() {
	default

	if use doc ; then
		unpack "usr/share/doc/gmail-desktop/changelog.gz" || die "unpack failed"
		rm -f "usr/share/doc/gmail-desktop/changelog.gz" || die "rm failed"
		mv "changelog" "usr/share/doc/gmail-desktop" || die "mv failed"
	fi

	if use system-ffmpeg ; then
		rm -f  "opt/Gmail Desktop/libffmpeg.so" || die "rm failed"
	fi

	if use system-mesa ; then
		rm -fr "opt/Gmail Desktop/swiftshader" || die "rm failed"
		rm -f  "opt/Gmail Desktop/libEGL.so" || die "rm failed"
		rm -f  "opt/Gmail Desktop/libGLESv2.so" || die "rm failed"
		rm -f  "opt/Gmail Desktop/libvk_swiftshader.so" || die "rm failed"
		rm -f  "opt/Gmail Desktop/libvulkan.so.1" || die "rm failed"
		rm -f  "opt/Gmail Desktop/vk_swiftshader_icd.json" || die "rm failed"
	fi
}

src_install() {
	cp -a . "${ED}" || die "cp failed"

	rm -r "${ED}/usr/share/doc/gmail-desktop" || die "rm failed"

	if use doc ; then
		dodoc -r "usr/share/doc/gmail-desktop/"* || die "dodoc failed"
	fi

	if use system-ffmpeg ; then
		dosym "/usr/"$(get_libdir)"/chromium/libffmpeg.so" "/opt/Gmail Desktop/libffmpeg.so" || die "dosym failed"
	fi

	dosym "/opt/Gmail Desktop/gmail-desktop" "/usr/bin/gmail-desktop" || die "dosym failed"
}
