#!/bin/bash
WP_DIR="/var/www/html/wordpress"
DB_NAME="wordpress"
DB_USER="WP_USER"
DB_PASS="wordpressSuperSecurePassword"
BACKUP="/var/backups/wp"
DATE=$(date +%y-%m-%d)
mkdir -p $BACKUP
tar -czf  $BACKUP/files_$DATE.tar.gz $WP_DIR
mysqldump -u$DB_USER -p$DB_PASS $DB_NAME | gzip > $BACKUP/db_$DATE.sql.gz
tar -czf $BACKUP/wp_backup_$DATE.tar.gz $BACKUP/files_$DATE.tar.gz $BACKUP/db_$DATE.sql.gz
find $BACKUP -mtime +7 -delete
(crontab -1 2>/dev/null/ | grep -q wp_backup) || (crontab -1 2>/dev/null; echo "0 2
*** /bin/bash/ /(realpath $0)" | crontab -
