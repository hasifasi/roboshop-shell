source common.sh
appName=mongodb

printHeading " Copy Mongo repo "
cp mongo.repo /etc/yum.repos.d/mongodb.repo &>>$logFile
statusCheck $?

printHeading " Install the Mongodb "
 dnf install mongodb-org -y &>>$logFile
 statusCheck $?

printHeading " Modify port to access by any server using sed "
sed -i -e 's/127.0.0.1/0.0.0.0/'  /etc/mongod.conf &>>$logFile
statusCheck $?

printHeading " Restart Application server "
 systemctl enable mongod &>>$logFile
 systemctl restart mongod &>>$logFile
 statusCheck $?

