#!/bin/bash
#set -x
echo "Set APACHE_HOME"
#AWS_APACHE_HOME="check with Vishwas"
#APACHE_HOME=$AWS_APACHE_HOME

#setup for Pramod
PRAMOD_APACHE_HOME=/C/Users/pramod.malhotra/Downloads/apache-tomcat-9.0.20-windows-x64/apache-tomcat-9.0.20
#APACHE_HOME=$PRAMOD_APACHE_HOME

#setup for Hemal
#HEMAL_APACHE_HOME=/C/Users/hemal/Downloads/Apache_Tomcat_0902/apache-tomcat-9.0.24
#APACHE_HOME=$HEMAL_APACHE_HOME

echo "Copy files to Tomcat"
cp travelocity.com.war $APACHE_HOME/webapps/
cp avis.com.war $APACHE_HOME/webapps/
cp -r ./myApp $APACHE_HOME/webapps/ 
sleep 10
cp home.jsp $APACHE_HOME/webapps/avis.com
cp index.jsp $APACHE_HOME/webapps/avis.com
cp $APACHE_HOME/webapps/travelocity.com/WEB-INF/classes/wso2carbon.jks $APACHE_HOME/webapps/avis.com/WEB-INF/classes/

 
