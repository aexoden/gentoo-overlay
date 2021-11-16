# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit systemd
MY_P="${P/-bin/}"
MY_P="${MY_P/_rc/-rc.}"
MY_P="${MY_P/influxdb/influxdb2}"

S="${WORKDIR}"

DESCRIPTION="Scalable datastore for metrics, events, and real-time analytics"
HOMEPAGE="https://www.influxdata.com"
SRC_URI="https://dl.influxdata.com/influxdb/releases/${MY_P}-amd64.deb"

LICENSE="MIT BSD Apache-2.0 EPL-1.0 MPL-2.0 BSD-2 ISC"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="acct-group/influxdb
	acct-user/influxdb"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	unpack ${WORKDIR}/data.tar.gz
}

src_install() {
	dobin usr/bin/influxd
	exeinto /usr/lib/influxdb/scripts
	doexe usr/lib/influxdb/scripts/influxd-systemd-start.sh
	insinto /etc/logrotate.d
	doins etc/logrotate.d/influxdb
	insinto /usr/share/influxdb
	doins usr/share/influxdb/influxdb2-upgrade.sh
	systemd_dounit usr/lib/influxdb/scripts/influxdb.service

	newconfd "${FILESDIR}"/influxdb.confd influxdb
	newinitd "${FILESDIR}"/influxdb.initd influxdb
	keepdir /var/log/influxdb
	fowners influxdb:influxdb /var/log/influxdb
}
