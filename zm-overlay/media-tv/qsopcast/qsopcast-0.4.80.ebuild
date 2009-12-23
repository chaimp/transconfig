# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils kde-functions

MY_ICON=${FILESDIR}/sopcast-logo.png
MY_ICON_TARGET=/usr/share/pixmaps
MY_S="${S}/src"

DESCRIPTION="A QT front-end for SopCast P2P Internet TV"
HOMEPAGE="http://ftp.magiclinux.org.cn/nihui/kde4/files/"
SRC_URI="http://ftp.magiclinux.org.cn/nihui/kde4/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="alsa"

LANGS="br es it zh"
for X in ${LANGS} ; do
	IUSE="${IUSE} linguas_${X}"
done

DEPEND=">=media-tv/sopcast-3.0.1
	alsa? ( media-libs/alsa-lib )"

RDEPEND="${DEPEND}"


src_unpack() {
	unpack ${A}

	# patch for GCC 4.3
#	epatch "${FILESDIR}/${P}-gcc-4.3.patch"
	# patch for SopCast channel list URL (http://code.google.com/p/qsopcast/issues/detail?id=5)
#	epatch "${FILESDIR}/${P}-channel-url.patch"

	if ( ! use alsa ); then
		epatch "${FILESDIR}/${PN}-0.3.5-no-alsa.patch"
	fi

	# Crude language handling
#	for X in ${LANGS} ; do
#		if ( ! use linguas_${X} ); then
#			rm "${MY_S}/language/language_${X}.ts" \
#				"${MY_S}/language/language_${X}.qm"
#			sed -e "s+language/language_${X}.qm++" \
#				-e "s+language/language_${X}.ts++" -i ${MY_S}/${PN}.pro
#		fi
#	done

	# patch some QT and other file locations to more Gentooish ones
#	sed -e s+/usr/local+/usr+ -i ${MY_S}/${PN}.pro
}

src_compile() {
	cd "${MY_S}"
	eqmake3 || die "eqmake3 failed"
	emake || die "emake failed"
}

src_install() {
	cd "${MY_S}"
	INSTALL_ROOT=${D} emake install || die "emake install failed"
	insinto ${MY_ICON_TARGET}
	doins ${DISTDIR}/${MY_ICON}
	make_desktop_entry qsopcast "QSopCast - P2P Internet TV Viewer" ${MY_ICON_TARGET}/${MY_ICON}
}
