
source common.sh
app_name=redis

printHeading "Disable Default Redis"
dnf module disable redis -y &>>$log_file
statusCheck $?

printHeading "Enable Redis 7 Version"
dnf module enable redis:7 -y &>>$log_file
statusCheck $?

printHeading "Install Redis"
dnf install redis -y &>>$log_file
statusCheck $?

printHeading "Update Redis Listen address and Disable protection"
sed -i -e 's/127.0.0.1/0.0.0.0/' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf &>>$log_file
statusCheck $?

printHeading "Start Redis Service"
systemctl enable redis &>>$log_file
systemctl restart redis &>>$log_file
statusCheck $?
