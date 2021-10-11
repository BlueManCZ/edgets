# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Source overlay: https://github.com/BlueManCZ/edgets

EAPI=7

DESCRIPTION="The best alternative to Oracle JDK"
HOMEPAGE="https://bell-sw.com"

LICENSE="GPL-2"
RESTRICT="mirror"
SLOT="17"

SRC_URI="https://download.bell-sw.com/java/${PV/_p/+}/bellsoft-jre${PV/_p/+}-linux-amd64-full.tar.gz"
KEYWORDS="-* ~amd64"

QA_PREBUILT="*"

S="${WORKDIR}"

src_prepare() {
	default
	mv "jre-${SLOT}-full" "${P}"
}

src_install() {
	cp -a . "${ED}/opt/" || die "cp failed"
	dosym "/opt/${P}" "/opt/${PN}-${SLOT}" || die "dosym failed"
}
