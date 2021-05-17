# Copyright 2020-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# WARNING: This ebuild is probably not suitable for general use. I only did
#          the minimum to get it to work on my system.

EAPI=7

inherit kernel-build

MY_P=linux-${PV%.*}
GENPATCHES_P=genpatches-${PV%.*}-$(( ${PV##*.} + 3 ))
XANMOD_VERSION="1"

DESCRIPTION="Full XanMod sources with cacule option and including Gentoo patches"
HOMEPAGE="https://www.xanmod.org/"
SRC_URI+=" https://cdn.kernel.org/pub/linux/kernel/v$(ver_cut 1).x/${MY_P}.tar.xz
	https://dev.gentoo.org/~alicef/dist/genpatches/${GENPATCHES_P}.base.tar.xz
	https://dev.gentoo.org/~alicef/dist/genpatches/${GENPATCHES_P}.extras.tar.xz
	https://github.com/xanmod/linux/releases/download/${PV}-xanmod${XANMOD_VERSION}/patch-${PV}-xanmod${XANMOD_VERSION}.xz
	https://raw.githubusercontent.com/xanmod/linux/${PV}-xanmod${XANMOD_VERSION}/.config -> kernel.config"
S=${WORKDIR}/${MY_P}

LICENSE="GPL-2"
KEYWORDS="~amd64"
IUSE="debug"
REQUIRED_USE="arm? ( savedconfig )"

RDEPEND="
	!sys-kernel/gentoo-kernel-bin:${SLOT}"
BDEPEND="
	debug? ( dev-util/dwarves )"
PDEPEND="
	>=virtual/dist-kernel-${PV}"

src_prepare() {
	local PATCHES=(
		# meh, genpatches have no directory
		"${WORKDIR}"/*.patch
	)
	default

	cp "${DISTDIR}/kernel.config" .config || die

	echo 'CONFIG_LOCALVERSION="-xanmod-dist"' > "${T}"/version.config || die
	local merge_configs=(
		"${T}"/version.config
	)
	kernel-build_merge_configs "${merge_configs[@]}"
}
