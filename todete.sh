#!/bin/bash

#Variables & Config
DATE=$(date +%F_%H-%M)
LOGFILE="/var/log/zabbix_db_backup.log"
FILENAME="zabbix_db_${DATE}.sql.gz"
BACKUP_DIR="/mnt/nfs/zabbix_client_db" # Указываем директорию для удобства

#Logging
echo "[$(date)] Starting Backup Database Zabbix ...." | tee -a "$LOGFILE"

#Dump
sudo -u zabbix pg_dump zabbix | gzip | sudo -u zabbixclidb tee "$BACKUP_DIR/$FILENAME" > /dev/null

#Echo Result
if [[ $? -eq 0 ]]; then
    echo "[$(date)] Dump, GZIP and MV on 93.5 successful: ${FILENAME}" | tee -a "$LOGFILE"
else
    echo "[$(date)] FAILED ...." | tee -a "$LOGFILE"
fi

---

# Cleanup: Удаление файлов старше 1 часа
echo "[$(date)] Starting cleanup of old backup files in $BACKUP_DIR ...." | tee -a "$LOGFILE"

# Находим и удаляем файлы старше 60 минут
# Важно: используем -delete для безопасного удаления найденных файлов.
# Использование -maxdepth 1 предотвращает рекурсивный поиск в поддиректориях.
sudo -u zabbixclidb find "$BACKUP_DIR" -maxdepth 1 -type f -name "zabbix_db_*.sql.gz" -mmin +60 -exec rm {} \;

# Проверяем успешность операции удаления (опционально, так как find -delete не возвращает ошибку, если файлов нет)
if [[ $? -eq 0 ]]; then
    echo "[$(date)] Cleanup successful: old files removed." | tee -a "$LOGFILE"
else
    echo "[$(date)] Cleanup FAILED or no old files found." | tee -a "$LOGFILE"
fi