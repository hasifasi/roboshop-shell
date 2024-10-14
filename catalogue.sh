source common.sh
appName=catalogue

printHeading " Copy the catalogue Service "
cp catalogue.service /etc/systemd/system/catalogue.service &>>$logFile
echo $?

printHeading " Copy the mongo repo "
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>$logFile
echo $?

printHeading " Enable nodejs version 20 "
dnf module disable nodejs -y &>>$logFile
dnf module enable nodejs:20 -y &>>$logFile
echo $?

printHeading " Install nodejs "
dnf install nodejs -y &>>$logFile
echo $?

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
addPrerequisites


printHeading " Install the dev code "
npm install &>>$logFile
echo $?



printHeading " Restart the server "
systemctl daemon-reload &>>$logFile
systemctl enable catalogue &>>$logFile
systemctl restart catalogue &>>$logFile
echo $?


printHeading " Install Mongodb  "
dnf install mongodb-mongosh -y &>>$logFile
echo $?

printHeading " Connect Catalogue and Mongodb "
mongosh --host 172.31.26.200 </app/db/master-data.js &>>$logFile
echo $?