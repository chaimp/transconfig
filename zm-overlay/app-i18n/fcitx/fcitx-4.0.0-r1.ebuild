# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

inherit autotools

DESCRIPTION="Free Chinese Input Toy for X. Another Chinese XIM Input Method"
HOMEPAGE="http://fcitx.googlecode.com"
SRC_URI="${HOMEPAGE}/files/${P}_all.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 ~x86 ~amd64"
IUSE="dbus debug +pango"

RDEPEND="media-libs/fontconfig
	x11-libs/cairo
	x11-libs/libX11
	x11-libs/libXrender
	dbus? ( sys-apps/dbus )
	pango? ( x11-libs/pango )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext
	x11-proto/xproto"


src_configure() {
	econf --enable-tray=yes --enable-recording=yes \
	$(use_enable debug) \
	$(use_enable dbus) \
	$(use_enable pango)
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog README THANKS TODO || die "dodoc failed"
	rm -rf "${D}"/usr/share/fcitx/doc || die
	dodoc doc/cjkvinput.txt doc/fcitx4.pdf doc/pinyin.txt || die "dodoc failed"
	dohtml doc/wb_fh.htm || die "dohtml failed"
}

pkg_postinst() {
	einfo "This is not an official release. Please report you bugs to:"
	einfo "http://code.google.com/p/fcitx/issues/list"
	echo
	elog "You should export the following variables to use fcitx"
	elog " export XMODIFIERS=\"@im=fcitx\""
	elog " export XIM=\"fcitx\""
	elog " export GTK_IM_MODULE=\"fcitx\""
	elog " export QT_IM_MODULE=\"fcitx\""
}
