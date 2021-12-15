# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit gnome2

DESCRIPTION="A newsreader for GNOME"
HOMEPAGE="http://pan.rebelbase.com/"
SRC_URI="http://pan.rebelbase.com/download/releases/${PV}/source/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="crypt dbus libnotify spell ssl"

RDEPEND="
	>=dev-libs/glib-2.26:2
	>=sys-libs/zlib-1.2.0
	x11-libs/gtk+:3
	libnotify? ( >=x11-libs/libnotify-0.4.1:0= )
	dev-libs/gmime:3.0[crypt=]
	spell? (
		>=app-text/enchant-1.6:0/0
		app-text/gtkspell:3 )
	ssl? ( >=net-libs/gnutls-3:0= )
"
DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.19.7
	virtual/pkgconfig
"

src_configure() {
	gnome2_src_configure \
		--without-yelp-tools \
		--with-gtk3 \
		--with-gmime30 \
		--without-webkit \
		$(use_with crypt gmime-crypto) \
		$(use_with dbus) \
		--disable-gkr \
		$(use_with spell gtkspell) \
		$(use_enable libnotify) \
		$(use_with ssl gnutls)
}
