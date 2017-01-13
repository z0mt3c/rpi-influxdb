FROM resin/rpi-raspbian:jessie

ENV INFLUXDB_VERSION 1.1.1

RUN apt-get update && apt-get install wget
RUN wget -q https://dl.influxdata.com/influxdb/releases/influxdb-${INFLUXDB_VERSION}_linux_armhf.tar.gz && \
    tar xvfz influxdb-${INFLUXDB_VERSION}_linux_armhf.tar.gz --strip-components=2 -C /

COPY influxdb.conf /etc/influxdb/influxdb.conf
VOLUME /var/lib/influxdb

RUN chmod +x /usr/bin/influx*

ENV INFLUXDB_INIT_USER root
ENV INFLUXDB_INIT_PWD root

EXPOSE 8083
EXPOSE 8086
EXPOSE 8088

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT ["entrypoint.sh"]

CMD ["influxd"]