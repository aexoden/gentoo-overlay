# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson xdg

DESCRIPTION="GNOME audio player for transcription"
HOMEPAGE="http://gkarsay.github.io/parlatype"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	SRC_URI=""
	KEYWORDS=""
	EGIT_REPO_URI="http://github.com/gkarsay/${PN}.git"
else
	SRC_URI="http://github.com/gkarsay/${PN}/releases/download/v${PV}/${P}.tar.gz"
	KEYWORDS="~amd64"
fi


LICENSE="GPL-3"
SLOT="0"
IUSE="libreoffice +introspection glade gtk-doc"
#asr

#	asr? (
#		sphinxbase
#		pocketsphinx
#	)

DEPEND="
	app-text/yelp-tools
	dev-libs/appstream-glib
	>=media-libs/gstreamer-1.6.3:1.0
	>=x11-libs/gtk+-3.22:3
	glade? (
		>=dev-util/glade-3.12.2
	)
	gtk-doc? (
		dev-util/gtk-doc
	)
	introspection? (
		dev-libs/gobject-introspection
	)
	libreoffice? (
		|| (
			app-office/libreoffice
			app-office/libreoffice-bin
		)
	)
"
RDEPEND="${DEPEND}
	media-libs/gst-plugins-good:1.0
	media-libs/gst-plugins-bad:1.0
	media-libs/gst-plugins-ugly:1.0
"

src_configure() {
	local emesonargs=(
		$(meson_use libreoffice)
		-Dlibreoffice-dir=/usr/lib64/libreoffice/share/Scripts/python
#		$(meson_use asr)
		-Dasr=false
		$(meson_use introspection gir)
		$(meson_use gtk-doc)
		$(meson_use glade)
	)
	meson_src_configure
}
