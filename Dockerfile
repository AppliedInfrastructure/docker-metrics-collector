# Metrics collection container based on Google's cAdvisor and the
# cAdvisor-collectd project by Matt Maier (https://github.com/maier)
# ------------------------------------------------------------------
FROM google/cadvisor:v0.23.8
MAINTAINER Michael Laws <mlaws@appliedinfrastructure.com>

ENV HOST="dockerhost" HOUSEKEEPING_INTERVAL_SEC="30" REPORTING_INTERVAL_SEC="60"

RUN apk update && \
    apk add collectd collectd-python collectd-network collectd-write_http && \
    apk add collectd-curl ca-certificates device-mapper python py-pip py-yaml && \
    apk add wget bash git ca-certificates coreutils && \
    rm -rf /var/cache/apk/* && \
    update-ca-certificates && \
    pip install docopt pystache docker-py python-dateutil flask requests && \
    mkdir -p /opt/collectd/csv && \
    mkdir -p /opt/collectd/python && \
    mkdir -p /opt/collectd/working && \
    touch /opt/collectd/python/__init__.py

COPY src/cadvisor/cadvisor-cli /opt/collectd/
COPY src/cadvisor/python/cadvisor.py /opt/collectd/python/
COPY src/cadvisor/python/cadvisor-metrics.py /opt/collectd/python/
COPY src/cadvisor/cadvisor-types.db /opt/collectd/
COPY src/mesos/mesos-cli /opt/collectd/
COPY src/mesos/python/mesos.py /opt/collectd/python/
COPY src/mesos/python/mesos_collectd.py /opt/collectd/python/
COPY src/mesos/python/mesos-master.py /opt/collectd/python/
COPY src/mesos/python/mesos-slave.py /opt/collectd/python/
COPY src/mesos/mesos-types.db /opt/collectd/
COPY collectd-launch.sh /
COPY etc /etc/collectd/
COPY docker-entrypoint.sh /

RUN chown nobody /opt/collectd/cadvisor-cli && \
    chown nobody /opt/collectd/mesos-cli && \
    chmod +x     /opt/collectd/cadvisor-cli && \
    chmod +x     /opt/collectd/mesos-cli && \
    chmod +x     /collectd-launch.sh && \
    chmod 755    /docker-entrypoint.sh

EXPOSE 8080

VOLUME [ '/etc/collectd/conf.d', '/opt/collectd/working' ]

ENTRYPOINT [ "/docker-entrypoint.sh" ]
