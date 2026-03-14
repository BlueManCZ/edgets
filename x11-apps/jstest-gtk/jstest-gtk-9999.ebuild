# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake desktop git-r3 xdg

DESCRIPTION="Joystick testing and configuration tool"
HOMEPAGE="https://github.com/Grumbel/jstest-gtk"
EGIT_REPO_URI="${HOMEPAGE}.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-libs/libsigc++
	dev-cpp/gtkmm"
DEPEND="${RDEPEND}"

src_prepare() {
	cp "data/generic.png" "data/${PN}.png"
	cmake_src_prepare
}

src_install() {
	dobin "${BUILD_DIR}/${PN}"
	insinto "/usr/share/${PN}"
	doins -r "${S}/data"

	doicon "${S}/data/${PN}.png"

	make_desktop_entry ${PN} "Joystick" ${PN} "Utility" "Path=/usr/share/${PN}\nStartupWMClass=${PN}"
}
