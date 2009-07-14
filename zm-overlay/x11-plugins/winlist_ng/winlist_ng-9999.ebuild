# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit enlightenment subversion
ESVN_REPO_URI="http://itask-module.googlecode.com/svn/trunk/${PN}"

DESCRIPTION="Different window list for e17"
HOMEPAGE="http://code.google.com/p/itask-module"

DEPEND=">=x11-wm/enlightenment-9999
	media-libs/edje
	dev-libs/efreet"
