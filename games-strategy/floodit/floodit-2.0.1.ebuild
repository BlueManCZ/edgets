# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGO_SUM=(
	"codeberg.org/puregotk/purego v0.0.0-20260224095105-2513c838cb80"
	"codeberg.org/puregotk/puregotk v0.0.0-20260320050432-5bb8c3359c53"
	"github.com/pojntfx/go-gettext v0.4.1"
)

inherit gnome2-utils go-module meson xdg

go-module_set_globals

DESCRIPTION="Challenge yourself with a simple, yet addictive flood-it strategy game"
HOMEPAGE="https://github.com/tfuxu/floodit"
SRC_URI="
	https://github.com/tfuxu/floodit/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}
"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="
	>=dev-libs/glib-2.76:2
	>=gui-libs/libadwaita-1.8.0:1
	>=gui-libs/gtk-4.18.0:4
"
DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-lang/go-1.26
	sys-devel/gettext
	virtual/pkgconfig
"

src_prepare() {
	default
	# meson invokes `go build` from the build directory, which has no go.mod,
	# so Go can't find the module. Run it via `env --chdir` so go's cwd is
	# the source dir and it finds go.mod. Also rewrite '-o @OUTPUT@' to an
	# absolute path under the build dir, since @OUTPUT@ alone is relative
	# and would otherwise land the binary next to go.mod in the source tree.
	sed -i \
		-e "s|find_program('go').full_path(),|'env', '--chdir=' + meson.current_source_dir(),\n    &|" \
		-e "s|'@OUTPUT@'|meson.current_build_dir() / '@OUTPUT@'|" \
		meson.build || die

	# go-module.eclass's EGO_SUM path only populates the offline GOPROXY with
	# .zip files, not the .mod files `go build` needs for version resolution.
	# Extract each module's go.mod from its zip — this is byte-identical to
	# what proxy.golang.org serves at the .mod URL.
	local zip modfile
	while IFS= read -r -d '' zip; do
		modfile="${zip%.zip}.mod"
		[[ -f ${modfile} ]] && continue
		unzip -p "${zip}" '*/go.mod' > "${modfile}" || die "extracting ${zip}"
	done < <(find "${T}/go-proxy" -name '*.zip' -print0)
}

src_compile() {
	local -x GOFLAGS="-buildvcs=false ${GOFLAGS}"
	local -x GOCACHE="${T}/go-cache"
	# Don't let the go toolchain try to fetch a newer version at build time.
	local -x GOTOOLCHAIN=local
	meson_src_compile
}

pkg_preinst() {
	xdg_pkg_preinst
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_schemas_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_schemas_update
}
