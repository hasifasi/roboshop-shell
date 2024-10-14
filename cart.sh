source common.sh
appName=cart

echo -e "$color Copy the cart Service $noColor"
cp cart.service /etc/systemd/system/cart.service

echo -e "$color Enable the Nodejs Version 20 $noColor"
dnf module disable nodejs -y
dnf module enable nodejs:20 -y

echo -e "$color Install nodejs $noColor"
dnf install nodejs -y

#echo -e "$color Add Application user $noColor"
#useradd roboshop
#
#echo -e "$color Create Application directory $noColor"
#rm -rf /app
#mkdir /app
#
#echo -e "$color Download Dev Code $noColor"
#curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart-v3.zip
#cd /app
#
#echo -e "$color Unzip Dev code in tmp $noColor"
#unzip /tmp/cart.zip

addPrerequisites

echo -e "$color Install the project $noColor"
npm install

echo -e "$color Start Application service $noColor"
systemctl daemon-reload
systemctl enable cart
systemctl start cart