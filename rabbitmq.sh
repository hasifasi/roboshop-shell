source common.sh
appName=rabbitmq

printHeading "Copy RabbitMQ Repo file"
cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo
statusCheck $?

printHeading " Install Rabbitmq server"
dnf install rabbitmq-server -y &>>$logFile
statusCheck $?

print_heading "Start RabbitMQ Service"
systemctl enable rabbitmq-server
systemctl start rabbitmq-server
statusCheck $?

printHeading " Add user and set permissions"
rabbitmqctl add_user roboshop roboshop123 &>>$logFile
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$logFile
statusCheck $?

