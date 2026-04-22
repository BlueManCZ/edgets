# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11,12,13,14} )

inherit gnome2-utils meson python-single-r1 xdg

DESCRIPTION="Upscale and enhance images"
HOMEPAGE="
	https://tesk.page/upscaler
	https://gitlab.gnome.org/World/Upscaler
"
SRC_URI="https://gitlab.gnome.org/World/Upscaler/-/archive/${PV}/Upscaler-${PV}.tar.bz2 -> ${P}.tar.bz2"
S="${WORKDIR}/Upscaler-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	${PYTHON_DEPS}
	dev-libs/glib:2
	>=gui-libs/gtk-4.12:4[introspection]
	>=gui-libs/libadwaita-1.5[introspection]
	media-gfx/realesrgan-ncnn-vulkan
	$(python_gen_cond_dep '
		>=dev-python/pygobject-3.50[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP},jpeg,webp]
	')
"
DEPEND="${RDEPEND}"
BDEPEND="
	${PYTHON_DEPS}
	dev-util/blueprint-compiler
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	default

	# Upstream invokes the Upscayl-NCNN fork via 'upscayl-bin', which is
	# not packaged in ::gentoo. media-gfx/realesrgan-ncnn-vulkan ships
	# the same CLI (-i/-o/-n/-s) and the realesrgan-x4plus{,-anime}
	# models this app drives, so point the subprocess at that binary.
	sed -i -e 's|"upscayl-bin"|"realesrgan-ncnn-vulkan"|' \
		upscaler/window.py || die

	# Upstream imports the unpackaged 'vulkan' cffi binding solely to
	# pop a friendly dialog when Vulkan init fails. Drop the import and
	# force the probe off — realesrgan-ncnn-vulkan surfaces its own
	# Vulkan errors, and media-libs/vulkan-loader is pulled in as a
	# transitive dep of it.
	sed -i \
		-e '/^import vulkan$/d' \
		-e 's|os\.environ\.get("DEBUG_DISABLE_VULKAN_CHECK") != "1"|False|' \
		upscaler/window.py || die
}

src_configure() {
	local emesonargs=(
		-Dprofile=default
		-Dnetwork_tests=false
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	python_fix_shebang "${ED}"/usr/bin/upscaler
	python_optimize "${ED}"/usr/share/upscaler
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
