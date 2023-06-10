# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A macOS BigSur-like theme for your GTK apps"
HOMEPAGE="https://github.com/vinceliuice/WhiteSur-gtk-theme"

if [[ ${PV} == 9999 ]];then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}"
else
	SRC_URI="${HOMEPAGE}/archive/${PV//./-}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"
	S="${WORKDIR}/WhiteSur-gtk-theme-${PV//./-}"
fi

LICENSE="MIT"
RESTRICT="mirror"
SLOT="0"

DEPEND="dev-lang/sassc
	dev-libs/glib
	dev-libs/libxml2
	x11-libs/gtk+:2
	>=x11-libs/gtk+-3.18:3
	x11-themes/gtk-engines-murrine"
RDEPEND="${DEPEND}"

src_install() {
	mkdir -p "${ED}/usr/share/themes"
	./install.sh --dest "${ED}/usr/share/themes" --nautilus-style "mojave"
}
