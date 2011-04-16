# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils

DESCRIPTION="A Python Object-Document-Mapper for working with MongoDB"
HOMEPAGE="http://hmarr.com/mongoengine/"
SRC_URI="http://pypi.python.org/packages/source/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""

DEPEND="${DEPEND}"
RDEPEND="${RDEPEND}
	dev-python/pymongo"
