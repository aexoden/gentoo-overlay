# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit systemd
MY_P="${P/-bin/}"
MY_P="${MY_P/_rc/-rc.}"

S="${WORKDIR}/${MY_P}"

DESCRIPTION="The plugin-driven server agent for collecting & reporting metrics."
HOMEPAGE="https://github.com/influxdata/telegraf"
SRC_URI="https://dl.influxdata.com/telegraf/releases/${MY_P}_linux_amd64.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RESTRICT+=" test"

DEPEND="acct-group/telegraf
	acct-user/telegraf"
	RDEPEND="${DEPEND}"

src_install() {
	dobin usr/bin/telegraf
	insinto /etc/telegraf
	doins etc/telegraf/telegraf.conf
	keepdir /etc/telegraf/telegraf.d

	insinto /etc/logrotate.d
	doins etc/logrotate.d/telegraf

	systemd_dounit usr/lib/telegraf/scripts/telegraf.service
	newconfd "${FILESDIR}"/telegraf.confd telegraf
	newinitd "${FILESDIR}"/telegraf.rc telegraf

	keepdir /var/log/telegraf
	fowners telegraf:telegraf /var/log/telegraf
}
