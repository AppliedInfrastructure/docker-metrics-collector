#!/bin/bash
# Name: docker-entrypoint.sh
# Description: Simple shell script to kick off the cAdvisor and Collectd
#              processes with the appropriate configuration parameters.
#
# M.Laws - 7SEP2016
# Applied Infrastructure, LLC.

# Configurables
    COLLECTD_HOST=${HOST:-"dockerhost"}
    COLLECTD_INTERVAL=${REPORTING_INTERVAL_SEC:-"60"}
    CADVISOR_HOUSEKEEPING_INTERVAL=${HOUSEKEEPING_INTERVAL_SEC:-"30"}

# Token-replace in configuration files
    sed -i 's/COLLECTD_HOST/'${COLLECTD_HOST}'/' /etc/collectd/collectd.conf
    sed -i 's/COLLECTD_INTERVAL/'${COLLECTD_INTERVAL}'/' /etc/collectd/collectd.conf

# Start cAdvisor in background, then collectd in foreground
    echo "Docker host name ${COLLECTD_HOST} for host metrics"
    echo "Reporting metrics every ${COLLECTD_INTERVAL} seconds"
    echo "cAdvisor metrics collection every ${CADVISOR_HOUSEKEEPING_INTERVAL} seconds"

    echo "Starting cAdvisor..."
    /usr/bin/cadvisor --logtostderr --housekeeping_interval=${CADVISOR_HOUSEKEEPING_INTERVAL}s &

    echo "Starting collectd..."
    /collectd-launch.sh
