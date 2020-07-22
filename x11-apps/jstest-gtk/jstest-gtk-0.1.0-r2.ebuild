# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=6

inherit scons-utils eutils xdg-utils

DESCRIPTION="Joystick testing and configuration tool"
HOMEPAGE="https://jstest-gtk.gitlab.io/"

LICENSE="GPLv3"
SLOT="0"

KEYWORDS="~amd64 ~x86"
SRC_URI="https://jstest-gtk.gitlab.io/jstest-gtk-${PV}.tar.bz2 -> ${P}.tar.bz2"

RDEPEND="dev-libs/libsigc++
	dev-cpp/gtkmm
	~x11-libs/gtkglext-1.2.0:="
HDEPEND="${RDEPEND}
	dev-util/sconf"

src_prepare(){
	# strangly enough, the gtkglext-1.2 installed by ::gentoo is found only as gtkglext-1.0
	sed -i 's/gtkglext-1.2/gtkglext-1.0/' SConstruct || die "sed gtkglext version failed"
	sed -i 's/gtkglextmm-1.2/gtkglext-1.0/' SConstruct || die "sed gtkglext version failed"

	# remove -Werror flag to allow compilation with warnings
	sed -i 's/, "-Werror"//g' SConstruct || die "sed for removing -Werror flag failed"

	# include unistd.h to allow usage of open/close functions
	sed -i '34i#include <unistd.h>' src/joystick.cpp || die "sed failed"

	cp data/generic.png data/${PN}.png
	default
}

src_compile() {
	escons
}

src_install() {
	dobin "${S}/${PN}"
	insinto "/usr/share/${PN}"
	doins -r "${S}"/data

	doicon ${S}/data/${PN}.png

	make_desktop_entry "${PN}" "Joystick" ${PN} "Utility" "Path=/usr/share/${PN}\nStartupWMClass=${PN}"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
