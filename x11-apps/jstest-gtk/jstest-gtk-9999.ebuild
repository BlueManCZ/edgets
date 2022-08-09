# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=8

inherit cmake desktop git-r3 xdg

DESCRIPTION="Joystick testing and configuration tool"
HOMEPAGE="https://jstest-gtk.gitlab.io/"
EGIT_REPO_URI="https://gitlab.com/jstest-gtk/jstest-gtk.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-libs/libsigc++
	dev-cpp/gtkmm"
DEPEND="${RDEPEND}
	dev-util/cmake"

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
