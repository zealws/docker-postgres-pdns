# PowerDNS on Arch Linux.
# Version 0.0.1

FROM base/archlinux

MAINTAINER Zeal Jagannatha <zealjagannatha@gmail.com>

RUN yes | pacman -Sy --noprogressbar powerdns postgresql

ADD db-init.sh /tmp/db-init.sh
ADD schema.sql /tmp/schema.sql

# This whole scripts needs to be run in one container, otherwise the database won't be running when
# the role and database are created.
RUN sh /tmp/db-init.sh

ADD pdns.conf /etc/powerdns/pdns.conf
ADD powerdns.sh /tmp/powerdns.sh

CMD sh /tmp/powerdns.sh
