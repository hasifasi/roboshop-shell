source common.sh

echo -e "$color Copy the catalogue Service $noColor"
cp catalogue.service /etc/systemd/system/catalogue.service
echo -e "$color Copy the mongo repo $noColor"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "$color Enable nodejs version 20 $noColor"
dnf module disable nodejs -y
dnf module enable nodejs:20 -y

echo -e "$color Install nodejs $noColor"
dnf install nodejs -y

echo -e "$color Add App user $noColor"
useradd roboshop

echo -e "$color Create App directory $noColor"
rm -rf /app
mkdir /app

echo -e "$color Download Dev code $noColor"
curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip

echo -e "$color Unzip Dev code in tmp $noColor"
unzip /tmp/catalogue.zip

echo -e "$color Install the dev code $noColor"
npm install




systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue



dnf install mongodb-mongosh -y

mongosh --host 172.31.26.200 </app/db/master-data.js