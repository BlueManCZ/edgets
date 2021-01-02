# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7

DESCRIPTION="Simple program to pause games & applications"
HOMEPAGE="https://github.com/Merrit/nyrna"

GOLANG_PKG_ARCHIVEPREFIX="v"
GOLANG_PKG_IMPORTPATH="github.com/Merrit"
GOLANG_PKG_USE_CGO=1

GOLANG_PKG_DEPENDENCIES=(
  "github.com/adrg/xdg:fb8a0a2"
  "github.com/BurntSushi/xgb:20f126e"
  "github.com/BurntSushi/xgbutil:ad855c7"
  "github.com/fsnotify/fsnotify:7f4cf4d"
  "github.com/gen2brain/beeep:e9c15c2"
  "github.com/getlantern/context:c447772"
  "github.com/getlantern/errors:abdb3e3"
  "github.com/getlantern/golog:4ef2e79"
  "github.com/getlantern/hidden:f02dbb0"
  "github.com/getlantern/hex:c6586a6"
  "github.com/getlantern/ops:8476b16"
  "github.com/getlantern/systray:33b837f"
  "github.com/go-ini/ini:1fc6efb -> gopkg.in/ini.v1"
  "github.com/go-stack/stack:2fee6af"
  "github.com/go-vgo/robotgo:698ab9d"
  "github.com/go-yaml/yaml:b893565 -> gopkg.in/yaml.v2"
  "github.com/godbus/dbus:efee839"
  "github.com/golang/image:c137617 -> golang.org/x"
  "github.com/golang/sys:0e2f3a6 -> golang.org/x"
  "github.com/golang/text:23ae387 -> golang.org/x"
  "github.com/hashicorp/hcl:569ae81"
  "github.com/magiconair/properties:cfba716"
  "github.com/mitchellh/mapstructure:9e1e471"
  "github.com/oxtoacart/bpool:03653db"
  "github.com/pelletier/go-toml:34de94e"
  "github.com/robotn/gohook:a1db03b"
  "github.com/robotn/xgb:2cb92d0"
  "github.com/robotn/xgbutil:c861d6f"
  "github.com/skratchdot/open-golang:eef8423"
  "github.com/shirou/gopsutil:7e94bb8"
  "github.com/spf13/afero:5d9e780"
  "github.com/spf13/cast:8d17101"
  "github.com/spf13/jwalterweatherman:94f6ae3"
  "github.com/spf13/pflag:81378bb"
  "github.com/spf13/viper:13494e8"
  "github.com/subosito/gotenv:de67a66"
  "github.com/vcaesar/gops:c22fcf3"
  "github.com/vcaesar/imgo:e6a1d5a"
  "github.com/vcaesar/tt:f4f588f"
)

inherit golang-single xdg-utils

LICENSE="GPL-3"
SLOT="0"
IUSE="appindicator"
KEYWORDS="~amd64 ~arm ~arm64 ~ppc ~ppc64 ~x86"

RDEPEND="appindicator? ( dev-libs/libappindicator )
  gnome-extra/zenity
  x11-libs/gtk+
  !x11-misc/nyrna-bin"

src_install() {
  golang-single_src_install

  insinto "/usr/share/pixmaps"
  doins "packaging/PKGBUILD/nyrna.png"

  insinto "/usr/share/applications"
  doins "packaging/PKGBUILD/nyrna.desktop"
}

pkg_postinst() {
  xdg_desktop_database_update
  xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
}
