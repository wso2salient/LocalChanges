#!/bin/bash
#set -x
echo "This script should be run after installing WSO2"
echo "This script copies all changes to wso2 file over basic installation"
echo "Set WSO2_HOME"
echo "-----"
PRAMOD_WSO2_HOME=/C/Program\ Files/WSO2/Identity\ Server/5.8.0/repository
WSO2_HOME=$PRAMOD_WSO2_HOME
#----------
#AWS_WSO2_HOME=/home/ec2-user/WSO2/Identity\ Server/5.8.0/repository
#WSO2_HOME=$AWS_WSO2_HOME
# -------
#echo "Rename files"
#echo "Copy files to WSO2"
#mv ./custom.inbound.authenticator-1.0.0.txt custom.inbound.authenticator-1.0.0.jar
#mv ./org.wso2.carbon.identity.application.ttbfonl.authenticator.basicauth-1.0.0.txt org.wso2.carbon.identity.application.ttbfonl.authenticator.basicauth-1.0.0.jar
#mv ./org.wso2.carbon.identity.application.ttbponl.authenticator.basicauth-1.0.0.txt org.wso2.carbon.identity.application.ttbponl.authenticator.basicauth-1.0.0.jar
cp ./custom.inbound.authenticator-1.0.0.jar $WSO2_HOME/components/dropins/
cp ./org.wso2.carbon.identity.application.ttbfonl.authenticator.basicauth-1.0.0.jar $WSO2_HOME/components/dropins
cp ./org.wso2.carbon.identity.application.ttbponl.authenticator.basicauth-1.0.0.jar $WSO2_HOME/components/dropins
cp ./application-authentication.xml $WSO2_HOME/conf/identity/application-authentication.xml
cp ./basicauth.jsp $WSO2_HOME/deployment/server/webapps/authenticationendpoint/basicauth.jsp
cp ./ttb_login_page.jsp $WSO2_HOME/deployment/server/webapps/authenticationendpoint/
cp ./default_login.jsp $WSO2_HOME/deployment/server/webapps/authenticationendpoint/
cp ./ttb_login.css $WSO2_HOME/deployment/server/webapps/authenticationendpoint/css/
cp ./custom-common.css $WSO2_HOME/deployment/server/webapps/authenticationendpoint/css/
cp ./travelocity_login.jsp $WSO2_HOME/deployment/server/webapps/authenticationendpoint/
cp ./avis_app_login.jsp $WSO2_HOME/deployment/server/webapps/authenticationendpoint/
cp ./login.jsp $WSO2_HOME/deployment/server/webapps/authenticationendpoint/login.jsp
cp ./index.jag $WSO2_HOME/deployment/server/jaggeryapps/dashboard/index.jag
cp ./AlcoholAndTobaccoTaxAndTradeBureau-Seal.png $WSO2_HOME/deployment/server/webapps/authenticationendpoint/images/
cp ./CallCenter.png $WSO2_HOME/deployment/server/webapps/authenticationendpoint/images/
cp ./american-flag-small.png $WSO2_HOME/deployment/server/webapps/authenticationendpoint/images/
cp ./COLA.png $WSO2_HOME/deployment/server/webapps/authenticationendpoint/images/
cp ./COLA_small.png $WSO2_HOME/deployment/server/webapps/authenticationendpoint/images/
cp ./FONL_small.png $WSO2_HOME/deployment/server/webapps/authenticationendpoint/images/
cp ./header_ttb_logo.png $WSO2_HOME/deployment/server/webapps/authenticationendpoint/images/
cp ./IndustryMember.png $WSO2_HOME/deployment/server/webapps/authenticationendpoint/images/
cp ./PONL.png $WSO2_HOME/deployment/server/webapps/authenticationendpoint/images/
cp ./PONL_small.png $WSO2_HOME/deployment/server/webapps/authenticationendpoint/images/
cp ./PUBLIC.png $WSO2_HOME/deployment/server/webapps/authenticationendpoint/images/
cp ./ttb_landing_page.png $WSO2_HOME/deployment/server/webapps/authenticationendpoint/images/
cp ./ttb_logo.png $WSO2_HOME/deployment/server/webapps/authenticationendpoint/images/
cp ./ttb_logo_header.png $WSO2_HOME/deployment/server/webapps/authenticationendpoint/images/
cp ./Dollar_sign.png $WSO2_HOME/deployment/server/jaggeryapps/dashboard/img/
cp ./Fonl_image.png $WSO2_HOME/deployment/server/jaggeryapps/dashboard/img/
cp ./Cola_img.png $WSO2_HOME/deployment/server/jaggeryapps/dashboard/img/
