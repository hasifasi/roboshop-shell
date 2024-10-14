
echo -e "\e[31m check and install nginx \e[0m"
dnf module disable nginx -y
dnf module enable nginx:1.24 -y
dnf install nginx -y

echo -e "\e[31m Placing the nginx.conf \e[0m"
cp nginx.conf /etc/nginx/nginx.conf

echo -e "\e[31m enable and start nginx \e[0m"
systemctl enable nginx
systemctl start nginx

rm -rf /usr/share/nginx/html/*

echo -e "\e[31m Download the dev code and place it in tmp folder \e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip

echo -e "\e[31m Unzip the dev code from tmp folder \e[0m"
# shellcheck disable=SC2164
cd /usr/share/nginx/html
unzip /tmp/frontend.zip

echo -e "\e[31m Restart the nginx \e[0m"
systemctl restart nginx