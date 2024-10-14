color="\e[33m"
noColor="\e[0m"


echo -e "$color check and install nginx $noColor"
dnf module disable nginx -y
dnf module enable nginx:1.24 -y
dnf install nginx -y

echo -e "$color Placing the nginx.conf $noColor"
cp nginx.conf /etc/nginx/nginx.conf

echo -e "$color enable and start nginx $noColor"
systemctl enable nginx
systemctl start nginx

rm -rf /usr/share/nginx/html/*

echo -e "$color Download the dev code and place it in tmp folder $noColor"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip

echo -e "$color Unzip the dev code from tmp folder $noColor"
# shellcheck disable=SC2164
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "$color Restart the nginx $noColor"
systemctl restart nginx