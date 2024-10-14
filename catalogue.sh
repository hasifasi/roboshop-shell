source common.sh
appName=catalogue

echo -e "$color Copy the catalogue Service $noColor"
cp catalogue.service /etc/systemd/system/catalogue.service
echo -e "$color Copy the mongo repo $noColor"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "$color Enable nodejs version 20 $noColor"
dnf module disable nodejs -y
dnf module enable nodejs:20 -y

echo -e "$color Install nodejs $noColor"
dnf install nodejs -y

#*********************
#This Code is now replaced with a funcion called --> addPrerequisites()
#echo -e "$color Add App user $noColor"

#useradd roboshop
#
#echo -e "$color Create App directory $noColor"
#rm -rf /app
#mkdir /app
#
#echo -e "$color Download Dev code $noColor"
#curl -L -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
#cd /app
#echo -e "$color Unzip Dev code in tmp $noColor"
#unzip /tmp/catalogue.zip
#**********************
addPrerequisites()

echo -e "$color Install the dev code $noColor"
npm install



echo -e "$color Restart the server $noColor"
systemctl daemon-reload
systemctl enable catalogue
systemctl restart catalogue


echo -e "$color Install Mongodb  $noColor"
dnf install mongodb-mongosh -y

echo -e "$color Connect Catalogue and Mongodb $noColor"
mongosh --host 172.31.26.200 </app/db/master-data.js