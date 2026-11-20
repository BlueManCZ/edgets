# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg

MY_PN="${PN%-bin}"

DESCRIPTION="Native photo library and non-destructive raw developer"
HOMEPAGE="
	https://getartcraft.com/apps/lightcraft
	https://github.com/storytold/lightcraft
"
SRC_URI="
	amd64? ( https://github.com/storytold/${MY_PN}/releases/download/v${PV}/${MY_PN}-${PV}-linux-x86_64.tar.gz
		-> ${P}-amd64.tar.gz )
	arm64? ( https://github.com/storytold/${MY_PN}/releases/download/v${PV}/${MY_PN}-${PV}-linux-aarch64.tar.gz
		-> ${P}-arm64.tar.gz )
"
S="${WORKDIR}"

LICENSE="|| ( Apache-2.0 MIT ) OFL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

RDEPEND="
	dev-libs/wayland
	media-libs/vulkan-loader
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libxkbcommon[X]
"

QA_PREBUILT="usr/bin/lightcraft usr/bin/lightcraft-cli"

src_install() {
	local srcdir="${MY_PN}-${PV}-linux-$(usex amd64 x86_64 aarch64)"

	dobin "${srcdir}"/bin/*

	insinto /usr/share
	doins -r "${srcdir}"/share/applications
	doins -r "${srcdir}"/share/icons
	doins -r "${srcdir}"/share/metainfo
	doins -r "${srcdir}"/share/mime

	dodoc "${srcdir}"/share/doc/${MY_PN}/README.md
	dodoc "${srcdir}"/share/doc/${MY_PN}/NOTICE
	dodoc "${srcdir}"/share/doc/${MY_PN}/OFL-*.txt
}
