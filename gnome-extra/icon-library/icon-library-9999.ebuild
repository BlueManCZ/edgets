# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay:	https://github.com/BlueManCZ/edgets
# Thanks to:			https://github.com/cardoe/cargo-ebuild

EAPI=7

CRATES="
aho-corasick-0.7.18
anyhow-1.0.41
atty-0.2.14
autocfg-1.0.1
bitflags-1.2.1
block-0.1.6
cairo-rs-0.14.0
cairo-sys-rs-0.14.0
cc-1.0.68
cfg-expr-0.7.4
cfg-if-1.0.0
dbus-0.8.4
either-1.6.1
env_logger-0.7.1
field-offset-0.3.4
futures-channel-0.3.15
futures-core-0.3.15
futures-executor-0.3.15
futures-io-0.3.15
futures-macro-0.3.15
futures-task-0.3.15
futures-util-0.3.15
gdk-pixbuf-0.14.0
gdk-pixbuf-sys-0.14.0
gdk4-0.1.0
gdk4-sys-0.1.0
getrandom-0.2.3
gettext-rs-0.7.0
gettext-sys-0.21.0
gio-0.14.0
gio-sys-0.14.0
glib-0.10.3
glib-0.14.0
glib-macros-0.10.1
glib-macros-0.14.0
glib-sys-0.10.1
glib-sys-0.14.0
gobject-sys-0.10.0
gobject-sys-0.14.0
graphene-rs-0.14.0
graphene-sys-0.14.0
gsk4-0.1.0
gsk4-sys-0.1.0
gtk-macros-0.3.0
gtk4-0.1.0
gtk4-macros-0.1.0
gtk4-sys-0.1.0
heck-0.3.3
hermit-abi-0.1.19
humantime-1.3.0
itertools-0.10.1
itertools-0.9.0
itoa-0.4.7
lazy_static-1.4.0
libadwaita-0.1.0-alpha
libadwaita-sys-0.1.0-alpha
libc-0.2.97
libdbus-sys-0.2.1
locale_config-0.3.0
log-0.4.14
malloc_buf-0.0.6
memchr-2.4.0
memoffset-0.6.4
objc-0.2.7
objc-foundation-0.1.1
objc_id-0.1.1
once_cell-1.8.0
pango-0.14.0
pango-sys-0.14.0
pest-2.1.3
pin-project-lite-0.2.7
pin-utils-0.1.0
pkg-config-0.3.19
ppv-lite86-0.2.10
pretty_env_logger-0.4.0
proc-macro-crate-0.1.5
proc-macro-crate-1.0.0
proc-macro-error-1.0.4
proc-macro-error-attr-1.0.4
proc-macro-hack-0.5.19
proc-macro-nested-0.1.7
proc-macro2-1.0.27
quick-error-1.2.3
quote-1.0.9
rand-0.8.4
rand_chacha-0.3.1
rand_core-0.6.3
rand_hc-0.3.1
redox_syscall-0.2.9
regex-1.5.4
regex-syntax-0.6.25
remove_dir_all-0.5.3
rustc_version-0.3.3
ryu-1.0.5
search-provider-0.2.0
semver-0.11.0
semver-parser-0.10.2
serde-1.0.126
serde_derive-1.0.126
serde_json-1.0.64
slab-0.4.3
smallvec-1.6.1
sourceview5-0.1.0
sourceview5-sys-0.1.1
strum-0.18.0
strum-0.21.0
strum_macros-0.18.0
strum_macros-0.21.1
syn-1.0.73
system-deps-1.3.2
system-deps-3.1.2
tempfile-3.2.0
termcolor-1.1.2
thiserror-1.0.25
thiserror-impl-1.0.25
toml-0.5.8
ucd-trie-0.1.3
unicode-segmentation-1.8.0
unicode-xid-0.2.2
version-compare-0.0.10
version-compare-0.0.11
version_check-0.9.3
wasi-0.10.2+wasi-snapshot-preview1
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
"

inherit gnome2-utils meson xdg cargo

DESCRIPTION="Symbolic icons for your apps"
HOMEPAGE="https://apps.gnome.org/app/org.gnome.design.IconLibrary"
GITLAB="https://gitlab.gnome.org/World/design/icon-library"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	SRC_URI="$(cargo_crate_uris ${CRATES})"
	EGIT_REPO_URI="${GITLAB}"
else
	SRC_URI="${GITLAB}/-/archive/${PV}/${P}.tar.gz"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
	RESTRICT="mirror"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="dev-libs/glib:2
	gui-libs/gtk:4
	x11-libs/gtksourceview:5
	>=x11-libs/libadwaita-21.11.16"

RDEPEND="${DEPEND}"

PATCHES=(
	# Bundled cargo script defined in src/meson.build has to be disabled
	# because we use `cargo_src_compile` from cargo.eclass for building.
	"${FILESDIR}/${PN}-disable-bundled-cargo.patch"
)

src_configure() {
	cargo_src_unpack
	cargo_gen_config
	cargo_src_configure
	meson_src_configure
}

src_compile() {
	cargo_src_compile
	meson_src_compile
}

src_install() {
	cargo_src_install
	meson_src_install
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_pkg_postinst
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_pkg_postrm
}
