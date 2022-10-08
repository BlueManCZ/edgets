# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=8

DESCRIPTION="The best alternative to Oracle JDK"
HOMEPAGE="https://bell-sw.com/libericajdk"

LICENSE="GPL-2"
RESTRICT="mirror"
SLOT="13"

SRC_URI="amd64? ( https://download.bell-sw.com/java/${PV}/bellsoft-jre${PV}-linux-amd64.tar.gz )
	x86? ( https://download.bell-sw.com/java/${PV}/bellsoft-jre${PV}-linux-i586.tar.gz )"
KEYWORDS="-* ~amd64 ~x86"

QA_PREBUILT="*"

S="${WORKDIR}"

src_prepare() {
	default
	mv "jre-${PV}" "${P}" || die "mw failed"
}

src_install() {
	cp -a . "${ED}/opt/" || die "cp failed"
	dosym "/opt/${P}" "/opt/${PN}-${SLOT}" || die "dosym failed"
}
