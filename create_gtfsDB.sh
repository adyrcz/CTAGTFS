#!/bin/bash
#Script checks to see if you have DB with given name and if it does not exist it will create it for you.


#************************************************************************************************
#Instructions
#change VARIABLES to work with your environment
#newdb ex. = newdb=gtfsdb
#dbuser ex. = dbuser=jsmith
#you dont need to add the password to the VARIABLES because remote hosts will require you to type it in for each transaction
#dbhost ex. = dbhost=mysql.domainname.com or dbhost=localhost or dbhost=127.0.0.1
#once you update the VARIABES you can just run the script as ./create_gtfsDB.sh 
#************************************************************************************************


#VARIABLES
newdb=DB Name
dbuser=username with CREATE access granted
#dbpass=password
dbhost=hostname of server

#CREATE DB
#STEP 1 = check if db exists first
echo "Creating a database for $newdb"
DBS=`mysql -u $dbuser -h $dbhost -p -Bse 'show databases'| egrep -v 'information_schema|mysql'`
for db in $DBS; do
if [ "$db" = "$newdb" ]
then
echo "This database already exists : exiting now"
    exit
  fi
done
sleep 1
#STEP 2 = create the database
mysqladmin -u $dbuser -h $dbhost -p create $newdb;
echo ":) Database $newdb created"
