# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

ESVN_REPO_URI="http://fcitx.googlecode.com/svn/trunk"
inherit autotools subversion

DESCRIPTION="Free Chinese Input Toy for X. Another Chinese XIM Input Method"
HOMEPAGE="http://fcitx.googlecode.com"
#SRC_URI="http://gentoo-china-overlay.googlecode.com/svn/distfiles/zhengma.tbz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
ESVN_BOOTSTRAP='autogen.sh'

RDEPEND="x11-libs/libX11
x11-libs/libXpm
x11-libs/libXrender
x11-libs/libXt
x11-libs/libXft"
DEPEND="${RDEPEND}
dev-util/pkgconfig"

#src_unpack() {
	# Add zhengma support
	#if use zhengma ; then
#		mv "${S}"/zhm "${S}"/data/table/zhengma.txt
#		mv "${FILESDIR}"/zhengma.conf "${S}"/data/table/zhengma.conf
#		mv "${FILESDIR}"/fcitx-zhengma.png "${S}"/png/fcitx-zhengma.png
#		epatch "${FILESDIR}"/add-zhengma-support.diff
	#fi
#}

src_compile() {
econf --enable-tray=yes --enable-recording=yes --enable-dbus=yes
}


src_install() {
emake DESTDIR="${D}" install || die "Install failed"
}

pkg_postinst() {
einfo "This is not an official release. Please report you bugs to:"
einfo "http://code.google.com/p/fcitx/issues/list"
echo
elog "You should export the following variables to use fcitx"
elog " export XMODIFIERS=\"@im=fcitx\""
elog " export XIM=fcitx"
elog " export XIM_PROGRAM=fcitx"
}

