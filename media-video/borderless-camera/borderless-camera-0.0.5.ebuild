# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit desktop xdg

DESCRIPTION="Simple camera app without window borders, useful for the screencast recording."
HOMEPAGE="https://github.com/grigio/borderless-camera"
SRC_URI="${HOMEPAGE}/releases/download/v${PV}/${P}-x86_64.AppImage -> ${P}.AppImage"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror"

DEPEND="dev-libs/libappindicator
	dev-libs/libindicator
	gnome-base/gconf
	x11-libs/libnotify
	x11-libs/libXScrnSaver
	x11-libs/libXtst"
RDEPEND="${DEPEND}"

QA_PREBUILT="*"

S="${WORKDIR}"
ARCHIVE_ROOT="squashfs-root"

PATCHES=(
	"${FILESDIR}/${PN}-desktop-file.patch"
)


src_unpack() {
	cp "${DISTDIR}/${P}.AppImage" "${P}.AppImage"
	chmod +x "${P}.AppImage"
	./${P}.AppImage --appimage-extract || die "appimage extraction failed"
}

S="${WORKDIR}/${ARCHIVE_ROOT}"

src_install() {
	mkdir "${ED}/opt" || die "mkdir failed"
	cp -a . "${ED}/opt/${PN}" || die "cp failed"

	fperms +rx "/opt/${PN}" || die "fperms failed"
	fperms +rx "/opt/${PN}/resources" || die "fperms failed"
	fperms +rx "/opt/${PN}/locales" || die "fperms failed"

	rm -r "${ED}/opt/${PN}/usr"
	rm "${ED}/opt/${PN}/AppRun"
	rm "${ED}/opt/${PN}/LICENSES.chromium.html"
	rm "${ED}/opt/${PN}/borderless-camera.png"
	rm "${ED}/opt/${PN}/borderless-camera.desktop"

	doicon "usr/share/icons/hicolor/128x128/apps/${PN}.png"
	domenu "borderless-camera.desktop"
	dosym "/opt/${PN}/${PN}" "/usr/bin/${PN}"
}
