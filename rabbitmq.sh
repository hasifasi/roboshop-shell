source common.sh
appName=rabbitmq

if [ -z "$1" ]; then
  echo INput Rabbitmq Password is missing
  exit 1
fi

RABBITMQ_PASSWORD=$1

printHeading "Copy RabbitMQ Repo file"
cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo &>>$logFile
statusCheck $?

printHeading " Install Rabbitmq server"
dnf install rabbitmq-server -y &>>$logFile
statusCheck $?

printHeading "Start RabbitMQ Service"
systemctl enable rabbitmq-server &>>$logFile
systemctl start rabbitmq-server &>>$logFile
statusCheck $?

printHeading " Add user and set permissions"
rabbitmqctl add_user roboshop $RABBITMQ_PASSWORD &>>$logFile
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$logFile
statusCheck $?

#Note : This is the password == roboshop123

