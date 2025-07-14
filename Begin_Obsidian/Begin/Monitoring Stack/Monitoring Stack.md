===============================================================
		**Prometheus + Grafana + Loki через Docker Compose**
===============================================================
 
 1. Создание LVM и папок
 2. Права на папки
 3. Подготовка конфигов
 4. docker-compose.yaml

**-|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|-**
**-|-	 1. Создание LVM и папок  -|--|--|-**
**-|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|-**

> [!LVM]
> **[[LVM Created]]**

> [!lsblk]
> /dev/sdb3       79693824 167772159 88078336   42G  5 Extended
> /dev/sdb5       79695872  85555199  5859328  2.8G 8e Linux LVM
> /dev/sdb6       85557248  91416575  5859328  2.8G 8e Linux LVM
> /dev/sdb7       91418624 105091071 13672448  6.5G 8e Linux LVM

**Folder Created**

> [!Folder Created]
> /mnt/prometheus_data = 3GB
> /mnt/grafana_data = 3 GB
> /mnt/loki_data = 6 GB
> 	/mnt/loki_data/wal
> /opt/monitoring-stack

**-|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|-**
**-|-            2. Права на папки        -|--|--|-**
**-|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|-**

chown -R 472:472 /mnt/grafana_data
chmod -R 755 /mnt/grafana_data
chown -R 10001:10001 /mnt/loki_data
chmod -R 755 /mnt/loki_data
mkdir -p /mnt/loki_data/wal
chown -R 10001:10001 /mnt/loki_data/wal
chmod -R 755 /mnt/loki_data/wal

**-|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|-**
**-|-      3. Подготовка конфигов    -|--|--|-**
**-|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|--|-**

[[/mnt/Prometheus data/prometheus.yml]]

[[/mnt/loki_data/local-config.yaml]]

[[docker-compose.yaml]]