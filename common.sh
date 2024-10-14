#This file will have all the common things across different files
#Its file having resuability code
#This will be imported in other files using "Source"

color="\e[36m"
noColor="\e[0m"

#Function to add user and create directory and Download Dev code to tmp and Unzip the same
addPrerequisites(){
  echo -e "$color Add App user $noColor"
  useradd roboshop

  echo -e "$color Create App directory $noColor"
  rm -rf /app
  mkdir /app

  echo -e "$color Download Dev code $noColor"
  curl -L -o /tmp/$appName.zip https://roboshop-artifacts.s3.amazonaws.com/$appName-v3.zip
  cd /app
  echo -e "$color Unzip Dev code in tmp $noColor"
  unzip /tmp/$appName.zip

}