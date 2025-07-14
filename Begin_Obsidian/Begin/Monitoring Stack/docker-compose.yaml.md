version: '3.8'

services:
  prometheus:
    image: prom/prometheus:latest
    container_name: prometheus
    volumes:
      - /mnt/prometheus_data:/etc/prometheus
    ports:
      - "9090:9090"
    restart: always

  grafana:
    image: grafana/grafana:latest
    container_name: grafana
    volumes:
      - /mnt/grafana_data:/var/lib/grafana
    ports:
      - "3000:3000"
    depends_on:
      - prometheus
    restart: always

  loki:
    image: grafana/loki:latest
    container_name: loki
    volumes:
      - /mnt/loki_data:/etc/loki
      - /mnt/loki_data/wal:/wal
    command: -config.file=/etc/loki/local-config.yaml
    ports:
      - "3100:3100"
    restart: always
