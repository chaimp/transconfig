# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $

inherit eutils

DESCRIPTION="Advanced color picker written in C++ using GTK+ toolkit"
HOMEPAGE="http://code.google.com/p/gpick/"
SRC_URI="http://gpick.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/lua
		 dev-util/scons
		 >=x11-libs/gtk+-2.4"

src_compile() {
		local sconsopts=$(echo "${MAKEOPTS}" | sed -ne "/-j/ { s/.*\(-j[0-9]\+\).*/\1/; p }")

		scons \
				${sconsopts} \
				|| die "scons failed"
}

src_install() {
		exeinto ${D}
		doexe build/source/*/*.so || die "doexe failed"
		insinto ${PN}
		doins -r data || die "doins failed"
		dodoc ChangeLog *.txt
}
