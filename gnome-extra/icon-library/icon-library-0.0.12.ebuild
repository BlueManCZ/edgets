# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay:	https://github.com/BlueManCZ/edgets
# Thanks to:		https://github.com/cardoe/cargo-ebuild

EAPI=7

CRATES="
aho-corasick-0.7.18
anyhow-1.0.57
async-broadcast-0.4.0
async-channel-1.6.1
async-executor-1.4.1
async-io-1.7.0
async-lock-2.5.0
async-recursion-0.3.2
async-task-4.2.0
async-trait-0.1.53
atty-0.2.14
autocfg-1.1.0
bitflags-1.3.2
block-0.1.6
byteorder-1.4.3
cache-padded-1.2.0
cairo-rs-0.15.11
cairo-sys-rs-0.15.1
cc-1.0.73
cfg-expr-0.10.3
cfg-if-1.0.0
concurrent-queue-1.2.2
derivative-2.2.0
easy-parallel-3.2.0
enumflags2-0.7.5
enumflags2_derive-0.7.4
env_logger-0.7.1
event-listener-2.5.2
fastrand-1.7.0
field-offset-0.3.4
futures-0.3.21
futures-channel-0.3.21
futures-core-0.3.21
futures-executor-0.3.21
futures-io-0.3.21
futures-lite-1.12.0
futures-macro-0.3.21
futures-sink-0.3.21
futures-task-0.3.21
futures-util-0.3.21
gdk-pixbuf-0.15.11
gdk-pixbuf-sys-0.15.10
gdk4-0.4.7
gdk4-sys-0.4.2
getrandom-0.2.6
gettext-rs-0.7.0
gettext-sys-0.21.3
gio-0.15.11
gio-sys-0.15.10
glib-0.15.11
glib-macros-0.15.11
glib-sys-0.15.10
gobject-sys-0.15.10
graphene-rs-0.15.1
graphene-sys-0.15.10
gsk4-0.4.7
gsk4-sys-0.4.2
gtk-macros-0.3.0
gtk4-0.4.7
gtk4-macros-0.4.7
gtk4-sys-0.4.5
heck-0.4.0
hermit-abi-0.1.19
hex-0.4.3
humantime-1.3.0
instant-0.1.12
itoa-1.0.2
lazy_static-1.4.0
libadwaita-0.1.1
libadwaita-sys-0.1.0
libc-0.2.126
locale_config-0.3.0
lock_api-0.4.7
log-0.4.17
malloc_buf-0.0.6
memchr-2.5.0
memoffset-0.6.5
nix-0.23.1
objc-0.2.7
objc-foundation-0.1.1
objc_id-0.1.1
once_cell-1.12.0
ordered-stream-0.0.1
pango-0.15.10
pango-sys-0.15.10
parking-2.0.0
parking_lot-0.11.2
parking_lot_core-0.8.5
pest-2.1.3
pin-project-lite-0.2.9
pin-utils-0.1.0
pkg-config-0.3.25
polling-2.2.0
ppv-lite86-0.2.16
pretty_env_logger-0.4.0
proc-macro-crate-1.1.3
proc-macro-error-1.0.4
proc-macro-error-attr-1.0.4
proc-macro2-1.0.39
quick-error-1.2.3
quick-xml-0.22.0
quote-1.0.18
rand-0.8.5
rand_chacha-0.3.1
rand_core-0.6.3
redox_syscall-0.2.13
regex-1.5.6
regex-syntax-0.6.26
remove_dir_all-0.5.3
rustc_version-0.3.3
ryu-1.0.10
scopeguard-1.1.0
search-provider-0.3.0
semver-0.11.0
semver-parser-0.10.2
serde-1.0.137
serde_derive-1.0.137
serde_json-1.0.81
serde_repr-0.1.8
sha1-0.6.1
sha1_smol-1.0.0
slab-0.4.6
smallvec-1.8.0
socket2-0.4.4
sourceview5-0.4.1
sourceview5-sys-0.4.1
static_assertions-1.1.0
syn-1.0.95
system-deps-6.0.2
temp-dir-0.1.11
tempfile-3.3.0
termcolor-1.1.3
thiserror-1.0.31
thiserror-impl-1.0.31
toml-0.5.9
ucd-trie-0.1.3
uds_windows-1.0.2
unicode-ident-1.0.0
version-compare-0.1.0
version_check-0.9.4
waker-fn-1.1.0
wasi-0.10.2+wasi-snapshot-preview1
wepoll-ffi-0.1.2
winapi-0.3.9
winapi-i686-pc-windows-gnu-0.4.0
winapi-util-0.1.5
winapi-x86_64-pc-windows-gnu-0.4.0
zbus-2.2.0
zbus_macros-2.2.0
zbus_names-2.1.0
zvariant-3.2.1
zvariant_derive-3.2.1
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
	SRC_URI="${GITLAB}/-/archive/${PV}/${P}.tar.gz
		$(cargo_crate_uris ${CRATES})"
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
	RESTRICT="mirror"
fi

LICENSE="GPL-3"
SLOT="0"

DEPEND="dev-libs/glib:2
	gui-libs/gtk:4
	gui-libs/gtksourceview:5
	gui-libs/libadwaita"

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
