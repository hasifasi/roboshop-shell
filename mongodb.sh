source common.sh

echo -e "$color Copy Mongo repo $noColor"
cp mongo.repo /etc/yum.repos.d/mongodb.repo

echo -e "$color Install the Mongodb $noColor"
 dnf install mongodb-org -y

echo -e "$color Modify port to access by any server using sed $noColor"
sed -i -e 's/127.0.0.1/0.0.0.0/'  /etc/mongod.conf

echo -e "$color Restart Application server $noColor"
 systemctl enable mongod
 systemctl restart mongod

