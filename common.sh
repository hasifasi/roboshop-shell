#This file will have all the common things across different files
#Its file having resuability code
#This will be imported in other files using "Source"

color="\e[36m"
noColor="\e[0m"
logFile=/tmp/roboshop.log   # Creating a variable to store all logs
rm -f $logFile              # Remove the file before every new run


#Function to add user and create directory and Download Dev code to tmp and Unzip the same
addPrerequisites(){
  echo -e "$color Add App user $noColor"
  useradd roboshop &>>$logFile
  echo $?

  echo -e "$color Create App directory $noColor"
  rm -rf /app &>>$logFile
  mkdir /app &>>$logFile
  echo $?

  echo -e "$color Download Dev code $noColor"
  curl -L -o /tmp/$appName.zip https://roboshop-artifacts.s3.amazonaws.com/$appName-v3.zip &>>$logFile
  cd /app
  echo $?

  echo -e "$color Unzip Dev code in tmp $noColor"
  unzip /tmp/$appName.zip &>>$logFile
  echo $?

}