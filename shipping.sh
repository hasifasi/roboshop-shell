source common.sh
appName=shipping


mavenSetup

#=================All code are moved under mavenSetup in common.sh====================

#cp shipping.service /etc/systemd/system/shipping.service
#
#dnf install maven -y
#
##useradd roboshop
##
##rm -rf /app
##mkdir /app
##
##curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping-v3.zip
##cd /app
##unzip /tmp/shipping.zip
#addPrerequisites
#
#
#cd /app
#mvn clean package
#mv target/shipping-1.0.jar shipping.jar
#
#systemctl daemon-reload
#systemctl enable shipping
#systemctl restart shipping
#==================================================================================
printHeading "Install MySQL Client"
dnf install mysql -y
statusCheck

for sql_file in schema app-user master-data; do
  printHeading "Load SQL File - $sql_file"
  mysql -h mysql.waferhassan.online -uroot -pRoboShop@1 < /app/db/$sql_file.sql
  statusCheck
done
#mysql -h mysql.waferhassan.online -uroot -pRoboShop@1 < /app/db/app-user.sql
#
#mysql -h mysql.waferhassan.online -uroot -pRoboShop@1 < /app/db/master-data.sql

print_heading "Restart Shipping Service"
systemctl restart shipping &>>$logFile
statusCheck $?