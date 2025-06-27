tar -czvf /mnt/nfs/zabbix_backup/etc_zabbix_backup_$(date +%F_%H-%M).tar.gz /etc/zabbix



sudo -u zabbix pg_dump zabbix | gzip | sudo -u $USERNFS tee /mnt/nfs/zabbix_client_db/$FILENAME > /dev/null
USERNFS="zabbixcli"
FILENAME_Z="etc_zabbix_${DATE}.tar"
sudo -u zabbixcli tar -czf /etc/zabbix | tee -u zabbixcli /mnt/nfs/zabbix_client/$FILENAME > /dev/null