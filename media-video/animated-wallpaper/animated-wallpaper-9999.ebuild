# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_USE_DEPEND="vapigen"
VALA_MIN_API_VERSION="0.34"

inherit cmake git-r3 vala

DESCRIPTION="Animated wallpaper for Gnome and other desktops"
HOMEPAGE="https://github.com/Ninlives/animated-wallpaper"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE:NAMES="valac-$(vala_best_api_version)"
		-DCMAKE_INSTALL_PREFIX="/usr"
	)

	cmake_src_configure
}
