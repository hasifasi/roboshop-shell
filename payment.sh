source common.sh
appName=payment


if [ -z "$1" ]; then
  echo Input Rabbitmq password missing
  exit 1
fi

rabbitmqPassword=$1

pythonSetup

#=================== All code is moved as resuable function -->pythonSetup =============================
#cp payment.service /etc/systemd/system/payment.service
#
#dnf install python3 gcc python3-devel -y
#
##useradd roboshop
##
##rm -rf /app
##mkdir /app
##
##curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment-v3.zip
##cd /app
##unzip /tmp/payment.zip
#addPrerequisites
#
##cd /app
#pip3 install -r requirements.txt
#
#systemctl daemon-reload
#
#systemctl enable payment
#systemctl start payment