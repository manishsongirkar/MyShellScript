#!/bin/bash
# This code Developed by @manishsongirkar

read -p "Enter Source IP: " SOURCEIP
read -p "Enter Destination IP: " DESTIP
read -p "Enter Source Domain Name To rsync: " DOMAINNAME
read -p "Enter Destination Domain Name To rsync: " REMOTEDOMAIN

cd /var/www/$DOMAINNAME
echo "Dump MySQL, Please Enter MySQL Password..."
DBNAME=$(grep DB_NAME /var/www/$DOMAINNAME/wp-config.php | cut -d"'" -f4)
mysqldump -u root -p $DBNAME > $DBNAME.sql

echo "rsync Data from '$DOMAINNAME' to '$REMOTEDOMAIN', Please Wait...."
rsync -avz htdocs $DBNAME.sql www-data@$DESTIP:/var/www/$REMOTEDOMAIN

echo "Importing MySQL to '$REMOTEDOMAIN', Please wait...";
ssh www-data@$DESTIP "mysql -u root -p `$(grep DB_NAME /var/www/$REMOTEDOMAIN/wp-config.php | cut -d"'" -f4)` < /var/www/'$REMOTEDOMAIN'/'$DBNAME.sql'"

exit 0
