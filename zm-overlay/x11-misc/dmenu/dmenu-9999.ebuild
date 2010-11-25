# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit mercurial

DESCRIPTION="A generic, highly customizable, and efficient menu for the X Window System"
HOMEPAGE="http://tools.suckless.org/dmenu/"
SRC_URI=""
EHG_REPO_URI="http://hg.suckless.org/dmenu"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
IUSE="xinerama paste"

DEPEND="x11-libs/libX11
	xinerama? ( x11-libs/libXinerama )
	paste? ( x11-misc/sselp )"
RDEPEND=${DEPEND}

src_unpack() {
	mercurial_src_unpack
}

S=${WORKDIR}/${PN}

src_prepare() {
	sed -i \
		-e 's/CFLAGS \+= -std=c99 -pedantic -Wall -Os/CFLAGS += -std=c99 -pedantic -Wall -g/' \
		-e 's/LDFLAGS \+= -s/LDFLAGS += -g/' \
		-e 's/XINERAMALIBS \+=/XINERAMALIBS ?=/' \
		-e 's/XINERAMAFLAGS \+=/XINERAMAFLAGS ?=/' \
		-e "s/CC \+=.*/CC = $(tc-getCC)/" \
		config.mk || die "sed failed"
}

src_compile() {
	if use xinerama; then
		emake || die "emake failed"
	else
		emake XINERAMAFLAGS="" XINERAMALIBS="" \
			|| die "emake failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install || die "emake install failed"

	dodoc README
}
