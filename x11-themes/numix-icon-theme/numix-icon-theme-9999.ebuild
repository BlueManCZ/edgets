# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7

inherit git-r3 xdg

DESCRIPTION="Icon theme from the Numix project."
HOMEPAGE="https://numixproject.github.io/"
EGIT_REPO_URI="https://github.com/numixproject/numix-icon-theme"
NUMIX_CIRCLE="https://github.com/numixproject/numix-icon-theme-circle"
NUMIX_SQUARE="https://github.com/numixproject/numix-icon-theme-square"
NUMIX_CORE="https://github.com/numixproject/numix-core"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="+circle +square"

RDEPEND="x11-libs/cairo
  circle? ( !x11-themes/numix-icon-theme-circle )
  square? ( !x11-themes/numix-icon-theme-square )"

DEFAULT_WORKDIR="${WORKDIR}"

src_unpack() {
	# get numix-icon-theme
	git-r3_src_unpack

	# get numix-core
	if use square || use circle; then
		P="numix-core"
		EGIT_REPO_URI="${NUMIX_CORE}"
		git-r3_src_unpack
	fi

	# get numix-icon-theme-circle
	if use circle; then
		P="numix-icon-theme-circle"
		EGIT_REPO_URI="${NUMIX_CIRCLE}"
		git-r3_src_unpack
	fi

	# get numix-icon-theme-square
	if use square; then
		P="numix-icon-theme-square"
		EGIT_REPO_URI="${NUMIX_SQUARE}"
		git-r3_src_unpack
	fi
}

src_prepare() {
	eapply_user

	# use latest circle icons from numix-core
	if use circle; then
		rm ../numix-icon-theme-circle/Numix-Circle/48/apps/*

		cd ../numix-core
		./gen.py --theme circle --platform linux || die
		echo "Circle icons generated..."

		cp numix-icon-theme-circle/Numix-Circle/48/apps/* ../numix-icon-theme-circle/Numix-Circle/48/apps
		cd "${S}"
	fi

	# use latest square icons from numix-core
	if use square; then
		rm ../numix-icon-theme-square/Numix-Square/48/apps/*

		cd ../numix-core
		./gen.py --theme square --platform linux || die
		echo "Square icons generated..."

		cp numix-icon-theme-square/Numix-Square/48/apps/* ../numix-icon-theme-square/Numix-Square/48/apps
		cd "${S}"
	fi
}

src_install() {
	insinto /usr/share/icons
	doins -r Numix{,-Light}

	if use circle; then
		doins -r ../numix-icon-theme-circle/Numix-Circle{,-Light}
	fi

	if use square; then
		doins -r ../numix-icon-theme-square/Numix-Square{,-Light}
	fi
}
