# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7

inherit desktop xdg

DESCRIPTION="Simple and powerful voice changer for Linux"
HOMEPAGE="https://github.com/constcharptr/lyrebird"

LICENSE="MIT"
SLOT="0"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="${HOMEPAGE}.git"
else
	SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"
fi

RDEPEND=">=dev-lang/python-3
	dev-python/pygobject
	dev-python/toml
	media-sound/pavucontrol
	media-sound/pulseaudio
	media-sound/sox[pulseaudio]
	x11-libs/gtk+"

src_compile() {
  not
}

src_install() {
	insinto "/usr/share/${PN}"
	doins -r "app" || die
	doins "icon.png" "app.py"

	exeinto "/usr/bin"
	doexe "lyrebird"

	newicon "icon.png" "lyrebird.png"

	make_desktop_entry "${PN}" "Lyrebird" "${PN}" "AudioVideo;Audio"
}
