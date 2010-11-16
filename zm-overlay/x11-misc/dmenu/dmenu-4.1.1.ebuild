# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils toolchain-funcs savedconfig

DMENU_PATH_C="dmenu_path-0.c"
XFT_PATCH="${P}"-xft-4.patch

DESCRIPTION="A generic, highly customizable, and efficient menu for the X Window System"
HOMEPAGE="http://tools.suckless.org/dmenu/"
SRC_URI="http://dl.suckless.org/tools/${P}.tar.gz
	cpath? ( http://tools.suckless.org/dmenu/patches/dmenu_path.c -> ${DMENU_PATH_C} )
	xft? ( http://z.ip.fi/~henkka/dmenu-xft/${P}-4-xft.diff -> ${XFT_PATCH} )"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86 ~x86-fbsd"
IUSE="xinerama paste cpath xft"

DEPEND="x11-libs/libX11
	paste? ( x11-misc/sselp )
	xinerama? ( x11-libs/libXinerama )
	xft? ( x11-libs/libXft )"
RDEPEND=${DEPEND}

src_prepare() {
	sed -i \
		-e "s/CFLAGS = -std=c99 -pedantic -Wall -Os/CFLAGS += -std=c99 -pedantic -Wall -g/" \
		-e "s/LDFLAGS = -s/LDFLAGS += -g/" \
		-e "s/XINERAMALIBS =/XINERAMALIBS ?=/" \
		-e "s/XINERAMAFLAGS =/XINERAMAFLAGS ?=/" \
		config.mk || die "sed failed"

	use savedconfig && restore_config config.h
	use cpath && cp "${DISTDIR}"/"${DMENU_PATH_C}" .

	if use xft; then
		epatch "${DISTDIR}"/"${XFT_PATCH}" || die "xft patch failed"
	fi
}

src_compile() {
	local msg
	use savedconfig && msg=", please check the config file."
	if use xinerama; then
		emake CC=$(tc-getCC) || die "emake failed${msg}"
	else
		emake CC=$(tc-getCC) XINERAMAFLAGS="" XINERAMALIBS="" \
			|| die "emake failed${msg}"
	fi

	if use cpath; then
		rm -f dmenu_path
		$(tc-getCC) -w -o dmenu_path "${DMENU_PATH_C}" \
			|| die "${DMENU_PATH_C} make failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install || die "emake install failed"

	insinto /usr/share/${PN}
	newins config.h ${PF}.config.h

	dodoc README

	save_config config.h
}

pkg_postinst() {
	einfo "This ebuild has support for user defined configs"
	einfo "Please read this ebuild for more details and re-emerge as needed"
	einfo "if you want to add or remove functionality for ${PN}"
}
