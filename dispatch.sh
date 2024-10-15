source common.sh
appName=dispatch

if [ -z "$1" ]; then
  echo INput Rabbitmq Password is missing
  exit 1
fi
RABBITMQ_PASSWORD=$1

printHeading "Copy Dispatch Service file"
cp dispatch.service  /etc/systemd/system/dispatch.service &>>$logFile
sed -i -e "s/RABBITMQ_PASSWORD/$RABBITMQ_PASSWORD/" /etc/systemd/system/dispatch.service &>>$logFile
statusCheck $?

printHeading  "Install GoLang"
dnf install golang -y &>>$logFile
statusCheck $?

#useradd roboshop
#
#rm -rf /app
#mkdir /app
#
#curl -L -o /tmp/dispatch.zip https://roboshop-artifacts.s3.amazonaws.com/dispatch-v3.zip
#cd /app
#unzip /tmp/dispatch.zip

addPrerequisites

printHeading "Copy Download Application Dependencies"
cd /app
go mod init dispatch &>>$logFile
go get &>>$logFile
go build &>>$logFile
statusCheck $?

printHeading "Start Application Service"
systemctl daemon-reload &>>$logFile
systemctl enable dispatch &>>$logFile
systemctl restart dispatch &>>$logFile
statusCheck $?