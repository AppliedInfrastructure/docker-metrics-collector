# docker-metrics-collector

Collect Docker host, container, and application metrics and push to your destination of choice using [CAdvisor](https://github.com/google/cadvisor) and [Collectd](https://github.com/collectd/collectd).  Based on the work of [Matt Maier](https://github.com/maier).

## Problem

* Collect metrics from hosts, containers, and applications exposing metrics.
* Send metrics to a variety of external services simultaneously (e.g. metric backends like InfluxDB or Graphite, monitoring services like Librato).
* Run effetively in a container, not on the host system.
* Minimal configuration and sane out-of-box defaults.

## Solution

### Collectd and CAdvisor

1. Low barrier of entry
   * Collectd is a well-known, widely-used, and familiar monitoring/metrics collection tool.
1. Flexibility (Collectd)
   * Offers a wide variety of "input" and "output" plugins.
   * Provides a framework for implementing custom metrics collectors.
   * Collectd's native transport is supported by many monitoring services and metrics backends.
1. Container Support (CAdvisor)
   * Exposes host, container, and application metrics via a well-supported API.
   * Provides out-of-box container discovery.
   * Offers a framework for publishing application metrics.
   * Offers near-real-time visibility into a running system, providing a powerful interactive troubleshooting tool.

## Features

* Leverage Collectd's wealth of plugins
* Leveage CAdvisor's ability to see the *Host* as well as the *Containers* and *Applications*
* Runs in a separate container (not as a 1st class process on the Host)
* Has built-in metrics collectors for:
   * Host
   * Containers
   * Applications
   * Mesos
* Trivial to get started - sane defaults and minimal configuration
* Basic metric name manipulation for metric continuity

## Getting Started

## Version History
