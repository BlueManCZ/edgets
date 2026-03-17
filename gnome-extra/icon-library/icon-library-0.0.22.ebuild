# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CRATES="
        aho-corasick-1.1.3
        anyhow-1.0.97
        async-broadcast-0.7.2
        async-channel-2.3.1
        async-executor-1.13.1
        async-fs-2.1.2
        async-io-2.4.0
        async-lock-3.4.0
        async-process-2.3.0
        async-recursion-1.1.1
        async-signal-0.2.10
        async-task-4.7.1
        async-trait-0.1.88
        atomic-waker-1.1.2
        autocfg-1.4.0
        bitflags-2.9.0
        block-0.1.6
        blocking-1.6.1
        cairo-rs-0.21.0
        cairo-sys-rs-0.21.0
        cc-1.2.17
        cfg-expr-0.17.2
        cfg-if-1.0.0
        cfg_aliases-0.2.1
        concurrent-queue-2.5.0
        crossbeam-utils-0.8.21
        endi-1.1.0
        enumflags2-0.7.11
        enumflags2_derive-0.7.11
        env_logger-0.10.2
        equivalent-1.0.2
        errno-0.3.10
        event-listener-5.4.0
        event-listener-strategy-0.5.4
        fastrand-2.3.0
        field-offset-0.3.6
        futures-channel-0.3.31
        futures-core-0.3.31
        futures-executor-0.3.31
        futures-io-0.3.31
        futures-lite-2.6.0
        futures-macro-0.3.31
        futures-task-0.3.31
        futures-util-0.3.31
        gdk-pixbuf-0.21.0
        gdk-pixbuf-sys-0.21.0
        gdk4-0.10.0
        gdk4-sys-0.10.0
        getrandom-0.3.2
        gettext-rs-0.7.2
        gettext-sys-0.22.5
        gio-0.21.0
        gio-sys-0.21.0
        glib-0.21.0
        glib-macros-0.21.0
        glib-sys-0.21.0
        gobject-sys-0.21.0
        graphene-rs-0.21.0
        graphene-sys-0.21.0
        gsk4-0.10.0
        gsk4-sys-0.10.0
        gtk4-0.10.0
        gtk4-macros-0.10.0
        gtk4-sys-0.10.0
        hashbrown-0.15.2
        heck-0.5.0
        hermit-abi-0.4.0
        hermit-abi-0.5.0
        hex-0.4.3
        humantime-2.2.0
        indexmap-2.8.0
        is-terminal-0.4.16
        itoa-1.0.15
        lazy_static-1.5.0
        libadwaita-0.8.0
        libadwaita-sys-0.8.0
        libc-0.2.171
        linux-raw-sys-0.4.15
        linux-raw-sys-0.9.3
        locale_config-0.3.0
        log-0.4.27
        malloc_buf-0.0.6
        memchr-2.7.5
        memoffset-0.9.1
        nix-0.29.0
        objc-0.2.7
        objc-foundation-0.1.1
        objc_id-0.1.1
        once_cell-1.21.3
        ordered-stream-0.2.0
        pango-0.21.0
        pango-sys-0.21.0
        parking-2.2.1
        pin-project-lite-0.2.16
        pin-utils-0.1.0
        piper-0.2.4
        pkg-config-0.3.32
        polling-3.7.4
        pretty_env_logger-0.5.0
        proc-macro-crate-3.3.0
        proc-macro2-1.0.94
        quote-1.0.40
        r-efi-5.2.0
        regex-1.11.1
        regex-automata-0.4.9
        regex-syntax-0.8.5
        rustc_version-0.4.1
        rustix-0.38.44
        rustix-1.0.3
        ryu-1.0.20
        search-provider-0.12.0
        semver-1.0.26
        serde-1.0.219
        serde_derive-1.0.219
        serde_json-1.0.140
        serde_repr-0.1.20
        serde_spanned-0.6.8
        shlex-1.3.0
        signal-hook-registry-1.4.2
        slab-0.4.9
        smallvec-1.15.1
        sourceview5-0.10.0
        sourceview5-sys-0.10.1
        static_assertions-1.1.0
        syn-2.0.104
        system-deps-7.0.3
        target-lexicon-0.12.16
        temp-dir-0.1.14
        tempfile-3.19.1
        termcolor-1.4.1
        toml-0.8.20
        toml_datetime-0.6.8
        toml_edit-0.22.24
        tracing-0.1.41
        tracing-attributes-0.1.28
        tracing-core-0.1.33
        uds_windows-1.1.0
        unicode-ident-1.0.18
        version-compare-0.2.0
        wasi-0.14.2+wasi-0.2.4
        winapi-0.3.9
        winapi-i686-pc-windows-gnu-0.4.0
        winapi-util-0.1.9
        winapi-x86_64-pc-windows-gnu-0.4.0
        windows-sys-0.59.0
        windows-targets-0.52.6
        windows_aarch64_gnullvm-0.52.6
        windows_aarch64_msvc-0.52.6
        windows_i686_gnu-0.52.6
        windows_i686_gnullvm-0.52.6
        windows_i686_msvc-0.52.6
        windows_x86_64_gnu-0.52.6
        windows_x86_64_gnullvm-0.52.6
        windows_x86_64_msvc-0.52.6
        winnow-0.7.4
        wit-bindgen-rt-0.39.0
        xdg-home-1.3.0
        zbus-5.5.0
        zbus_macros-5.5.0
        zbus_names-4.2.0
        zvariant-5.4.0
        zvariant_derive-5.4.0
        zvariant_utils-3.2.0
"

RUST_MIN_VER="1.85.0"

inherit gnome2-utils meson xdg cargo

DESCRIPTION="Symbolic icons for your apps"
HOMEPAGE="https://flathub.org/en/apps/org.gnome.design.IconLibrary"
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
