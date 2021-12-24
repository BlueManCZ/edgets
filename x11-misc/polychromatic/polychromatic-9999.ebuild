# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg

DESCRIPTION="An open source RGB lighting management front-end application to customise OpenRazer peripherals on GNU/Linux."
HOMEPAGE="https://polychromatic.app"
GITHUB="https://github.com/polychromatic/polychromatic"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${GITHUB}"
else
	SRC_URI="${GITHUB}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"
fi

LICENSE="GPL-3"
RESTRICT="mirror"
SLOT="0"

DEPEND="dev-libs/libappindicator:3
	>=dev-lang/python-3.7.0
	>=dev-python/colorama-0.4.4
	dev-python/colour
	dev-python/distro
	dev-python/pygobject
	dev-python/setproctitle
	dev-python/requests
	dev-python/PyQt5
	dev-python/PyQtWebEngine
	dev-qt/qtsvg
	sys-apps/openrazer"

BDEPEND="${DEPEND}
	dev-lang/sassc
	dev-util/intltool"

RDEPEND="${DEPEND}"
