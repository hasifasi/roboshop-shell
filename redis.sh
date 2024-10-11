

dnf module disable redis -y
dnf module enable redis:7 -y

dbf install redis -y


systemctl enable redis
systemctl start redis
