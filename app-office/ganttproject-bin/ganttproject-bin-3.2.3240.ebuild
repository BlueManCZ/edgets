# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7
inherit desktop unpacker xdg

MY_PN="${PN/-bin/}"
UP_PN="GanttProject"

DESCRIPTION="A tool for creating a project schedule by means of Gantt chart and resource load chart"
HOMEPAGE="https://www.ganttproject.biz"
SRC_URI="${HOMEPAGE}/dl/${PV}/lin -> ${P}.deb"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="mirror"
IUSE="doc"

RDEPEND="dev-java/liberica-jre-bin:13"

S="${WORKDIR}"

QA_PREBUILT="*"

PATCHES=(
	"${FILESDIR}/${PN}-liberica-jre-bin-13.patch"
	"${FILESDIR}/${PN}-desktop-file.patch"
)

src_prepare() {
	default

	if use doc ; then
		unpack "usr/share/doc/${MY_PN}/changelog.Debian.gz" || die "unpack failed"
		rm -f "usr/share/doc/${MY_PN}/changelog.Debian.gz" || die "rm failed"
		mv "changelog.Debian" "usr/share/doc/${MY_PN}" || die "mv failed"
	fi

	ICON_PATH="usr/share/icons/gnome/scalable/mimetypes"
	mv "${ICON_PATH}/application-x-ganttproject.svg" "${ICON_PATH}/ganttproject.svg"
}

src_install() {
	cp -a . "${ED}" || die "cp failed"

	rm -r "${ED}/usr/share/doc/${MY_PN}" || die "rm failed"

	if use doc; then
		dodoc -r "usr/share/doc/${MY_PN}/"*
	fi

	dosym "/usr/share/${MY_PN}/${MY_PN}" "/usr/bin/${MY_PN}" || die "dosym failed"
}
