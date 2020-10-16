# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop xdg-utils

DESCRIPTION="Cross-platform .NET IDE based on the IntelliJ platform and ReSharper"
HOMEPAGE="https://www.jetbrains.com/rider/"
SRC_URI="https://download-cf.jetbrains.com/rider/JetBrains.Rider-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="IDEA"
SLOT="0"
KEYWORDS="~amd64"
IUSE="mono"

RDEPEND="|| ( dev-dotnet/dotnetcore-sdk-bin dev-dotnet/dotnetcore-sdk )
	mono? ( dev-lang/mono )"

QA_PREBUILT="*"

S="${WORKDIR}/JetBrains Rider-${PV}"

src_install() {
	insinto "/opt/${PN}"
	doins -r *

	fperms -R a+x "/opt/${PN}/jbr/bin/"
	fperms a+x "/opt/${PN}/bin/"{"rider.sh","fsnotifier"{,"64"},"inspect.sh"}
	fperms a+x "/opt/${PN}/lib/ReSharperHost/linux-x64/dotnet/dotnet"

	dosym "/opt/${PN}/bin/rider.sh" "/usr/bin/${PN}"

	doicon "bin/${PN}.svg"

	make_desktop_entry ${PN} "JetBrains Rider" ${PN} "Development;IDE"\
		"StartupWMClass=jetbrains-rider\n\
MimeType=text/x-csharp;application/x-mds;application/x-mdp;\
application/x-cmbx;application/x-prjx;application/x-csproj;\
application/x-vbproj;application/x-sln;application/x-aspx;\
text/xml;application/xhtml+xml;text/html;text/plain;"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
