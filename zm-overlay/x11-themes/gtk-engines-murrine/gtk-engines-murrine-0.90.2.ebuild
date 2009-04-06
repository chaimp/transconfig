# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-engines-murrine/gtk-engines-murrine-0.53.1.ebuild,v 1.5 2007/07/19 13:48:48 angelos Exp $

MY_PN="murrine"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Murrine GTK+2 Cairo Engine"

HOMEPAGE="http://cimi.netsons.org/pages/murrine.php"
URI_PREFIX="http://ftp.acc.umu.se/pub/GNOME/sources/murrine"
SRC_URI="${URI_PREFIX}/${PV%\.*}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.12"
DEPEND=">=x11-libs/gtk+-2.12"

S="${WORKDIR}/${MY_P}"

src_compile() {
	econf --enable-animation || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodir /usr/share/themes
	insinto /usr/share/themes
	doins -r ${WORKDIR}/Murrin*
}
