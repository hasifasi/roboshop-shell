
source common.sh
app_name=redis

printHeading "Disable Default Redis"
dnf module disable redis -y &>>$logFile
statusCheck $?

printHeading "Enable Redis 7 Version"
dnf module enable redis:7 -y &>>$logFile
statusCheck $?

printHeading "Install Redis"
dnf install redis -y &>>$logFile
statusCheck $?

printHeading "Update Redis Listen address and Disable protection"
sed -i -e 's/127.0.0.1/0.0.0.0/' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf &>>$logFile
statusCheck $?

printHeading "Start Redis Service"
systemctl enable redis &>>$logFile
systemctl restart redis &>>$logFile
statusCheck $?
