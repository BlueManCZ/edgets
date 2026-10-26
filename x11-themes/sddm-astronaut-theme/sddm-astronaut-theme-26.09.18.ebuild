# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT="abb3163c724935af888ba5ea9ac0c4f22afd8048"

DESCRIPTION="Series of modern looking themes for SDDM"
HOMEPAGE="https://github.com/Keyitdev/sddm-astronaut-theme"
SRC_URI="https://github.com/Keyitdev/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${COMMIT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~arm64 ~loong ~ppc64 ~riscv ~x86"
RESTRICT="bindist mirror"

RDEPEND="
	>=dev-qt/qtdeclarative-6.8:6
	>=dev-qt/qtmultimedia-6.8:6
	>=dev-qt/qtsvg-6.8:6
	>=dev-qt/qtvirtualkeyboard-6.8:6
	>=gui-apps/sddm-0.21.0
"

src_install() {
	mkdir -p "${ED}/usr/share/sddm/themes/${PN}" || die "mkdir failed"
	cp -a * "${ED}/usr/share/sddm/themes/${PN}" || die "cp failed"
	mkdir -p "${ED}/usr/share/fonts" || die "mkdir failed"
	cp -ar "Fonts/"* "${ED}/usr/share/fonts" || die "cp failed"
	mkdir -p "${ED}/etc/sddm.conf.d/" || die "mkdir failed"
	printf "[Theme]\nCurrent=sddm-astronaut-theme\n" > "${ED}/etc/sddm.conf.d/theme.conf" || die "printf failed"
}
