#This file will have all the common things across different files
#Its file having resuability code
#This will be imported in other files using "Source"

color="\e[36m"
noColor="\e[0m"
logFile=/tmp/roboshop.log   # Creating a variable to store all logs
rm -f $logFile              # Remove the file before every new run


#Function to add user and create directory and Download Dev code to tmp and Unzip the same
addPrerequisites(){
  printHeading "Add App user"
  useradd roboshop &>>$logFile
  echo $?

  printHeading "Create App directory"
  rm -rf /app &>>$logFile
  mkdir /app &>>$logFile
  echo $?

  printHeading "Download Dev code"
  curl -L -o /tmp/$appName.zip https://roboshop-artifacts.s3.amazonaws.com/$appName-v3.zip &>>$logFile
  cd /app
  echo $?

  printHeading "Unzip Dev code in tmp"
  unzip /tmp/$appName.zip &>>$logFile
  echo $?

}

printHeading(){
  echo -e "$color $1  $noColor" &>>logFile
  echo -e "$color $1  $noColor"
}