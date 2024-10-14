source common.sh
appName=rabbitmq

printHeading "Copy RabbitMQ Repo file"
cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo &>>$logFile
statusCheck $?

printHeading " Install Rabbitmq server"
dnf install rabbitmq-server -y &>>$logFile
statusCheck $?

print_heading "Start RabbitMQ Service"
systemctl enable rabbitmq-server &>>$logFile
systemctl start rabbitmq-server &>>$logFile
statusCheck $?

printHeading " Add user and set permissions"
rabbitmqctl add_user roboshop roboshop123 &>>$logFile
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$logFile
statusCheck $?

