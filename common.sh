#This file will have all the common things across different files
#Its file having resuability code
#This will be imported in other files using "Source"

color="\e[36m"
noColor="\e[0m"
logFile=/tmp/roboshop.log   # Creating a variable to store all logs
rm -f $logFile              # Remove the file before every new run
scriptsPath=$(pwd)


#Function to add user and create directory and Download Dev code to tmp and Unzip the same
addPrerequisites(){
  printHeading "Add App user"
  id roboshop &>>$logFile
  if [ $? -ne 0 ]; then
    useradd roboshop &>>$logFile
  fi
  statusCheck $?

  printHeading "Create App directory"
  rm -rf /app &>>$logFile
  mkdir /app &>>$logFile
  statusCheck $?

  printHeading "Download Dev code"
  curl -L -o /tmp/$appName.zip https://roboshop-artifacts.s3.amazonaws.com/$appName-v3.zip &>>$logFile
  cd /app
  statusCheck $?

  printHeading "Unzip Dev code in tmp"
  unzip /tmp/$appName.zip &>>$logFile
  statusCheck $?

}

#This function to print header for all the commands and add the colors to it
printHeading(){
  echo -e "$color $1  $noColor" &>>logFile  # adds to logfile
  echo -e "$color $1  $noColor"             # prints in the cli
}

statusCheck(){
  if [ $1 -eq 0 ]; then
    echo -e "\e[32m SUCCESS \e[0m"
  else
    echo -e "\e[32m FAILURE \e[0m"
    exit 1
  fi
}

systemSetup(){

  printHeading "Copy the Service files"
  cp $scriptsPath/$appName.service /etc/systemd/system/$appName.service &>>$logFile
  statusCheck $?


  printHeading "System reload enable and restart"
  systemctl daemon-reload &>>$logFile
  systemctl enable $appName &>>$logFile
  systemctl restart $appName &>>$logFile
  statusCheck $?

}