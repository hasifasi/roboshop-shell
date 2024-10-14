source common.sh
appName=catalogue

#******It is added to systemSetup function in common.sh
#printHeading " Copy the catalogue Service "
#cp catalogue.service /etc/systemd/system/catalogue.service &>>$logFile
#statusCheck $?

printHeading " Copy the mongo repo "
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>$logFile
statusCheck $?


nodejsSetup
#=======================nodejsSetup function replaced the below code==========
#printHeading " Enable nodejs version 20 "
#dnf module disable nodejs -y &>>$logFile
#dnf module enable nodejs:20 -y &>>$logFile
#statusCheck $?
#
#printHeading " Install nodejs "
#dnf install nodejs -y &>>$logFile
#statusCheck $?

#*********************
#This Code is now replaced with a funcion called --> addPrerequisites()
#printHeading " Add App user "

#useradd roboshop
#
#printHeading " Create App directory "
#rm -rf /app
#mkdir /app
#
#printHeading " Download Dev code "
#curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
#cd /app
#printHeading " Unzip Dev code in tmp "
#unzip /tmp/catalogue.zip
#**********************
#addPrerequisites
#
#
#printHeading " Install the dev code "
#npm install &>>$logFile
#statusCheck $?
#
#
#systemSetup
#******It is added to systemSetup function in common.sh
#printHeading " Restart the server "
#systemctl daemon-reload &>>$logFile
#systemctl enable catalogue &>>$logFile
#systemctl restart catalogue &>>$logFile
#statusCheck $?
#**************************
#=========================================================
printHeading " Install Mongodb  "
dnf install mongodb-mongosh -y &>>$logFile
statusCheck $?

printHeading " Connect Catalogue and Mongodb "
mongosh --host mongodb.waferhassan.online </app/db/master-data.js &>>$logFile
statusCheck $?

printHeading "Restart Catalogue Service"
systemctl restart catalogue &>>$logFile
statusCheck $?