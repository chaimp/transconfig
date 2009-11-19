# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mmm-mode/mmm-mode-0.4.8-r1.ebuild,v 1.5 2007/11/06 08:07:26 opfer Exp $

inherit elisp git

DESCRIPTION="Enables the user to edit different parts of a file in different major modes"
HOMEPAGE="http://github.com/mujaheed/mmm-mode/"
SRC_URI=""
EGIT_REPO_URI="git://github.com/mujaheed/mmm-mode.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

SITEFILE=50${PN}-gentoo.el

src_compile() {
	econf --host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--with-emacs \
		--with-listdir=${SITELISP}/${PN} \
		--mandir=/usr/share/man || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	elisp-install ${PN} *.el *.elc || die "elisp-install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" \
		|| die "elisp-site-file-install failed"
	doinfo *.info*
	dodoc AUTHORS ChangeLog FAQ NEWS README README.Mason TODO
}
