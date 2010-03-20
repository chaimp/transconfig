# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

PHPCONFUTILS_MISSING_DEPS="adabas birdstep db2 dbmaker empress empress-bcs esoob interbase oci8 sapdb solid sybase-ct"

inherit eutils autotools flag-o-matic versionator depend.apache apache-module db-use phpconfutils php-common-r1 libtool eblits

PHP_PATCHSET=""
SUHOSIN_VERSION="$PV-0.9.9.1"
FPM_VERSION="0.6"
EXPECTED_TEST_FAILURES=""

KEYWORDS="~amd64 ~x86"


# All are in ${FILESDIR}/eblits
# If a function for a given version needs to change,
# then we create a new eblit and increment the
# version and reference it here.

eblit-pkg metadata v2
eblit-php-metadata

eblit-pkg pkg_setup v1

src_prepare() { eblit-run src_prepare v1 ; }
src_configure() { eblit-run src_configure v1 ; }
src_compile() { eblit-run src_compile v2 ; }
src_install() { eblit-run src_install v2 ; }
src_test() { eblit-run src_test v1 ; }

eblit-pkg pkg_postinst v1
