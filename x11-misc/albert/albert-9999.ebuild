# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake git-r3 xdg-utils

DESCRIPTION="A fast and flexible keyboard launcher"
HOMEPAGE="https://albertlauncher.github.io/"

EGIT_REPO_URI="https://github.com/albertlauncher/albert"

LICENSE="GPL-3+"
SLOT="0"
IUSE="debug +statistics virtualbox"

RDEPEND="dev-cpp/muParser
	dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtsql:5[sqlite]
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	statistics? ( dev-qt/qtcharts:5 )
	virtualbox? ( app-emulation/virtualbox[sdk] )
	x11-libs/libX11"

DEPEND="${RDEPEND}"

src_prepare() {
	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_DEBUG=$(usex debug)
		-DBUILD_VIRTUALBOX=$(usex virtualbox)
		-DBUILD_WITH_QTCHARTS=$(usex statistics)
	)

	cmake_src_configure
}

pkg_postinst() {
  xdg_desktop_database_update
  xdg_icon_cache_update
}

pkg_postrm() {
  xdg_desktop_database_update
}
