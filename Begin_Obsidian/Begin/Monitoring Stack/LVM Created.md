1. Создаём физичесекий вольюм
pvcreate /dev/sdb5
2. Создаём Volume Group
vgcreate vg_prom /dev/sdb5
3.Создаём Logical Volume 
lvcreate -n prometheus -L 2.75G vg_prom
3. Форматируем 
mkfs.ext4 /dev/mapper/vg_prom-prometheus
4. Создаём нужную дирректорию и монтируем её на vg_prom-prometheus
mkdir -p /mnt/prometheus_data
mount /dev/mapper/vg_prom-prometheus /mnt/prometheus_data/
5. Прописываем в fstab
echo '/dev/vg_prom/prometheus /mnt/prometheus_data ext4 defaults 2 0' | sudo tee -a /etc/fstab
