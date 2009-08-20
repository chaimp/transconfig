# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/screen/screen-4.0.3_p20070403.ebuild,v 1.4 2008/06/07 19:05:56 swegener Exp $

EAPI="1"

inherit eutils

DESCRIPTION="A set of profiles for GNU Screen, app-misc/screen"
HOMEPAGE="https://launchpad.net/screen-profiles"
SRC_URI="https://launchpad.net/ubuntu/jaunty/+source/screen-profiles/1.42-0ubuntu1/+files/screen-profiles_1.42.orig.tar.gz
	https://launchpad.net/ubuntu/jaunty/+source/screen-profiles/1.42-0ubuntu1/+files/screen-profiles_1.42-0ubuntu1.diff.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-util/debhelper"
RDEPEND="app-misc/screen"

src_unpack() {
	unpack ${A}
	epatch "${WORKDIR}"/*.diff
}

src_install() {
#	emake --makefile=debian/rules install || die
	exeinto /var/lib/${PN}
	doexe bin/* || die
#	insinto /usr/share/locale
#	doins po/locale/* || die
	insinto /usr/share/${PN}
	doins -r profiles keybindings windows screen-launcher-install screen-launcher-uninstall || die
	dobin screen-launcher select-screen-profile screen-profiles motd+shell screen-profiles-export || die
	doman *.1
	dodoc doc/*
}
