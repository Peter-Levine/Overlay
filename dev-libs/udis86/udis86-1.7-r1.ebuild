# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/udis86/udis86-1.7-r1.ebuild,v 1.4 2013/02/14 22:08:27 ago Exp $

EAPI="5"

inherit autotools eutils multilib-minimal

DESCRIPTION="Disassembler library for the x86/-64 architecture sets."
HOMEPAGE="http://udis86.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~hppa ppc ~ppc64 x86 ~amd64-fbsd ~x86-fbsd"
IUSE="test"

DEPEND="!dev-libs/udis86-32bit
	test? (
		amd64? ( dev-lang/yasm )
		x86? ( dev-lang/yasm )
		x86-fbsd? ( dev-lang/yasm )
	)"
RDEPEND=""

src_prepare() {
	# Don't fail tests if dev-lang/yasm is not installed, bug #318805
	epatch "${FILESDIR}"/${P}-yasm.patch
	eautoreconf
	multilib_copy_sources
}

multilib_src_configure() {
	econf \
		--docdir="/usr/share/doc/${PF}" \
		--disable-static \
		--enable-shared \
		--with-pic
}

multilib_src_install() {
	default
	find "${ED}"/usr -name '*.la' -delete
}