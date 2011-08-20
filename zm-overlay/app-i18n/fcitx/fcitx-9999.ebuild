# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit cmake-utils mercurial

EHG_REVISION="default"
EHG_REPO_URI="https://fcitx.googlecode.com/hg"
EHG_UP_FREQ="12"

DESCRIPTION="Free Chinese Input Toy for X. Another Chinese XIM Input Method"
HOMEPAGE="http://fcitx.googlecode.com"
SRC_URI="${HOMEPAGE}/files/pinyin.tar.gz
		 ${HOMEPAGE}/files/table.tar.gz
		 https://github.com/transtone/transconfig/raw/master/zm.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="dbus +pango zhengma"
RESTRICT="mirror"

RDEPEND="media-libs/fontconfig
	x11-libs/cairo[X]
	x11-libs/libX11
	x11-libs/libXrender
	dbus? ( sys-apps/dbus )
	pango? ( x11-libs/pango )"
DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig
	sys-devel/gettext
	x11-proto/xproto"

src_prepare() {
	cp -v "${DISTDIR}"/pinyin.tar.gz "${S}"/data && \
	cp -v "${DISTDIR}"/table.tar.gz "${S}"/data/table || \
	die "failed to copy code tables"

	if use zhengma ; then
		cp -v "${DISTDIR}"/zm.tar.gz "${S}"/data/table || die "failed to copy zhengma table"
		cp "${FILESDIR}"/zhengma.conf.in "${S}"/data/table/zhengma.conf.in
		cp "${FILESDIR}"/fcitx-zhengma.png "${S}"/data/png/fcitx-zhengma.png
		cp "${FILESDIR}"/fcitx-zhengma-22.png "${S}"/skin/dark/zhengma.png
		cp "${FILESDIR}"/fcitx-zhengma-16.png "${S}"/skin/classic/zhengma.png
		cp "${FILESDIR}"/fcitx-zhengma-16.png "${S}"/skin/default/zhengma.png
		epatch "${FILESDIR}"/zhengma.diff
	fi
}

