source common.sh


printHeading " check and install nginx "
dnf module disable nginx -y
dnf module enable nginx:1.24 -y
dnf install nginx -y
statusCheck $?

printHeading " Placing the nginx.conf "
cp nginx.conf /etc/nginx/nginx.conf
statusCheck $?

#echo -e "$color enable and start nginx $noColor"
#systemctl enable nginx
#systemctl start nginx
#statusCheck $?

rm -rf /usr/share/nginx/html/*

printHeading " Download the dev code and place it in tmp folder "
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip
statusCheck $?

printHeading " Unzip the dev code from tmp folder "
# shellcheck disable=SC2164
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
statusCheck $?

printHeading " Enable and Restart the nginx "
systemctl enable nginx
systemctl restart nginx
statusCheck $?