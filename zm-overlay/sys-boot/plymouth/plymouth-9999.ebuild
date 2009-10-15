# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit git autotools

EGIT_REPO_URI="git://anongit.freedesktop.org/plymouth"

DESCRIPTION="Graphical boot animation (splash) and logger"
HOMEPAGE="http://cgit.freedesktop.org/plymouth/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="sys-kernel/dracut"


src_prepare() {

	eautoreconf

}


src_install() {
	emake install DESTDIR="${D}" || die "install failed"

	#work around qa warning
	rm "${D}"/lib64/libply.la #if in x86,
	rm "${D}"/lib64/libply.a  #change lib64 --> lib
}
