# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit autotools

DESCRIPTION="Graphical boot animation (splash) and logger"
HOMEPAGE="http://cgit.freedesktop.org/plymouth/"
SRC_URI="http://cgit.freedesktop.org/${PN}/snapshot/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="sys-boot/dracut"


src_prepare() {

	eautoreconf

}


src_install() {
	emake install DESTDIR="${D}" || die "install failed"

	#work around qa warning
	rm "${D}"/lib64/libply.la #if in x86,
	rm "${D}"/lib64/libply.a  #change lib64 --> lib
}
