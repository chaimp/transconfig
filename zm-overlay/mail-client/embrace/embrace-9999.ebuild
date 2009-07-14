# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/embrace/embrace-9999.ebuild,v 1.4 2006/08/25 07:15:33 vapier Exp $

ESVN_SUB_PROJECT="MISC"
inherit enlightenment

DESCRIPTION="mail-checker which is based on the EFL"

IUSE="ssl mbox maildir imap"

DEPEND="dev-db/edb
	>=x11-libs/ecore-9999
	>=x11-libs/evas-9999
	>=media-libs/edje-9999
	>=x11-libs/esmart-9999
	ssl? ( dev-libs/openssl )
	sys-devel/libtool"

src_compile() {
	export MY_ECONF="
		$(use_enable ssl) \
		$(use_with mbox) \
		$(use_with maildir) \
		--with-pop \
		$(use_with imap) \
	"
	enlightenment_src_compile
}
