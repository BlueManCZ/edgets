# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..9} )

inherit git-r3 distutils-r1

HOMEPAGE="https://github.com/vaab/colour"
EGIT_REPO_URI="${HOMEPAGE}.git"
EGIT_CLONE_TYPE="single"
EGIT_COMMIT="0.1.5"

DESCRIPTION="Converts and manipulates common color representation (RGB, HSL, web, ect.)"

DEPEND="dev-python/d2to1"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

src_prepare() {
	sed -i "5,10s/-/_/g" "setup.cfg" || die "sed failed"
	eapply_user
}

python_install_all() {
	distutils-r1_python_install_all
}
