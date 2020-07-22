# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=6

inherit cmake-utils git-r3 xdg-utils
CMAKE_BUILD_TYPE="Release"

DESCRIPTION="Joystick testing and configuration tool"
HOMEPAGE="https://jstest-gtk.gitlab.io/"
EGIT_REPO_URI="https://gitlab.com/jstest-gtk/jstest-gtk.git"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS=""

RDEPEND="dev-libs/libsigc++
	dev-cpp/gtkmm"
DEPEND="${RDEPEND}
	dev-util/cmake"

src_prepare() {
	cp "data/generic.png" "data/${PN}.png"
	default
}

src_configure() {
	cmake-utils_src_configure
}

src_install() {
	dobin "${CMAKE_BUILD_DIR}/${PN}"
	insinto "/usr/share/${PN}"
	doins -r "${S}/data"

	doicon "${S}/data/${PN}.png"

	make_desktop_entry ${PN} "Joystick" ${PN} "Utility" "Path=/usr/share/${PN}\nStartupWMClass=${PN}"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
