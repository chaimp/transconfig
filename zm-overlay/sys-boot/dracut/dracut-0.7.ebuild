# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

DESCRIPTION="Dracut is a new initramfs infrastructure."
HOMEPAGE="http://apps.sourceforge.net/trac/dracut/wiki"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=""
RDEPEND="app-arch/cpio
	sys-fs/udev
	sys-apps/util-linux
	sys-devel/binutils
	sys-apps/coreutils
	sys-apps/module-init-tools
	sys-apps/findutils
	sys-apps/grep
	sys-apps/openrc
	"

#src_prepare() {
	#run sed which adds CFLAGS to make file
#}

src_install() {
	#pkglibdir=/usr/libexec/dracut 
	emake install DESTDIR="${D}" sbindir=/sbin sysconfdir=/etc \
		|| die "emake install failed"
}
