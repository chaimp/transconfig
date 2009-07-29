# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/epsilon/epsilon-9999.ebuild,v 1.6 2007/01/04 06:08:38 vapier Exp $

inherit enlightenment

DESCRIPTION="nice thumbnail generator"
KEYWORDS="~x86 ~amd64"
IUSE="xine"

DEPEND="media-libs/imlib2
	>=media-libs/libpng-1.2.0
	media-libs/edje
	x11-libs/evas
	x11-libs/ecore
	dev-lang/perl
	xine? ( >=media-libs/xine-lib-1.1.1 )"

src_compile() {
	export MY_ECONF="
		$(use_enable xine thumbnailer-xine) \
	"

	enlightenment_src_compile
}
