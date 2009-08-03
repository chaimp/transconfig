# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit git eutils autotools

EGIT_REPO_URI="git://github.com/dsd/libfprint.git"


DESCRIPTION="libfprint"
HOMEPAGE="http://www.reactivated.net/fprint/wiki/Libfprint"
SRC_URI=""

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""

DEPEND="media-gfx/imagemagick
	dev-libs/libusb"
RDEPEND="${DEPEND}"

src_unpack() {
	git_src_unpack
	cd "${S}"
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

