<%@ page import="org.wso2.carbon.identity.mgt.endpoint.IdentityManagementEndpointUtil" %>
<%@ page import="org.owasp.encoder.Encode" %>
<%@ page import="org.wso2.carbon.identity.mgt.endpoint.IdentityManagementEndpointConstants" %>
<%@ page import="org.wso2.carbon.identity.mgt.constants.SelfRegistrationStatusCodes" %>
<%@ page import="org.wso2.carbon.identity.mgt.endpoint.client.model.User" %>
<%@ page import="org.wso2.carbon.identity.mgt.endpoint.IdentityManagementServiceUtil" %>
<%@ page import="java.util.Map" %><%--
  ~ Copyright (c) 2018, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
  ~
  ~  WSO2 Inc. licenses this file to you under the Apache License,
  ~  Version 2.0 (the "License"); you may not use this file except
  ~  in compliance with the License.
  ~  You may obtain a copy of the License at
  ~
  ~    http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing,
  ~ software distributed under the License is distributed on an
  ~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  ~ KIND, either express or implied.  See the License for the
  ~ specific language governing permissions and limitations
  ~ under the License.
  --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:directive.include file="localize.jsp"/>

<%
    boolean error = IdentityManagementEndpointUtil.getBooleanValue(request.getAttribute("error"));
    String username = request.getParameter("username");
    User user = IdentityManagementServiceUtil.getInstance().getUser(username);
    Object errorCodeObj = request.getAttribute("errorCode");
    Object errorMsgObj = request.getAttribute("errorMsg");
    String callback =  Encode.forHtmlAttribute(request.getParameter("callback"));
    String errorCode = null;
    String errorMsg = null;
    
    if (errorCodeObj != null) {
        errorCode = errorCodeObj.toString();
    }
    if (SelfRegistrationStatusCodes.ERROR_CODE_INVALID_TENANT.equalsIgnoreCase(errorCode)) {
        errorMsg = "Invalid tenant domain - " + user.getTenantDomain();
    } else if (SelfRegistrationStatusCodes.ERROR_CODE_USER_ALREADY_EXISTS.equalsIgnoreCase(errorCode)) {
        errorMsg = "Username '" + username + "' is already taken. Please pick a different username";
    } else if (SelfRegistrationStatusCodes.ERROR_CODE_SELF_REGISTRATION_DISABLED.equalsIgnoreCase(errorCode)) {
        errorMsg = "Self registration is disabled for tenant - " + user.getTenantDomain();
    } else if (SelfRegistrationStatusCodes.CODE_USER_NAME_INVALID.equalsIgnoreCase(errorCode)) {
        errorMsg = user.getUsername() + " is an invalid user name. Please pick a valid username.";
    } else if (errorMsgObj != null) {
        errorMsg = errorMsgObj.toString();
    }
    boolean skipSignUpEnableCheck = Boolean.parseBoolean(request.getParameter("skipsignupenablecheck"));
%>


    <html>
    <head>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title><%=IdentityManagementEndpointUtil.i18n(recoveryResourceBundle, "Wso2.identity.server")%></title>

        <link rel="icon" href="images/favicon.png" type="image/x-icon"/>
        <link href="libs/bootstrap_3.3.5/css/bootstrap.min.css" rel="stylesheet">
        <link href="css/Roboto.css" rel="stylesheet">
        <link href="css/custom-common.css" rel="stylesheet">
        <link href="css/ttb-login_accountRecoveryEnd.css" rel="stylesheet">
        <!--[if lt IE 9]>
        <script src="js/html5shiv.min.js"></script>
        <script src="js/respond.min.js"></script>
        <![endif]-->
        <script src="libs/jquery_1.11.3/jquery-1.11.3.js"></script>
        <style type="text/css">
        a.my-tool-tip, a.my-tool-tip:hover, a.my-tool-tip:visited {
            color: black; font-size: small;
            }

            .my-tool-tip + .tooltip > .tooltip-inner {
                background-color: #0053A2;
                max-width: 300px;
                text-align: left;
            }
          /*  .headerImage{
                background: url(./images/header_ttb_logo.png) repeat;
                background: linear-gradient(rgba(23,554,232,65));
                position: absolute;
                  top: -50px;
                  z-index: -10;
                  background-size: cover;
            }*/
        a:hover {
            color: #333333;
            text-decoration: underline;
        }
        </style>
        <script type="text/javascript">
            $(document).ready(function(){
                $("a").tooltip();
            });
        </script>
    </head>
   <!--  <script type="text/javascript">
 
    $("a.my-tool-tip").tooltip();
    </script> -->

    <body>
           <div style="margin: 0px; font-size: small;">
            <div style="width: 100%; height: 40px;" class="headerImage">
            </div>
        <div class="container-fluid">
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
              
                    <div class="col-md-6" style="display: flex;">
                            <img src="./images/Flag_banner_icon.png" class="headerFlagClass" alt="usa flag">
                            <div style="top: 50%;"><i class="headerFlagLink">An official website of the United States Government</i></div>      
                    </div>
                       <div class="col-md-2">
                           <div><span id="headerClass"><a href="#" class="headerFlagLink">U.S. Department of the Treasury</a></span></div>
                       </div>
                       <div class="col-md-3">
                            <div><a href="#" class="headerFlagLink">Alcohol and Tobacco Tax and Trade Bureau</a></div>
                        </div>
                        <div class="col-md-1">
                                <div><a href="#" class="headerFlagLink">Contact</a></div>
                        </div>
            </div>
        </div>
    </div>
      
    <!-- header -->
    <header class="header header-ttb">
        <div class="container-fluid">
            <div class="row">
               <div class="col-md-1"> <a href="#">
                    <img src="images/AlcoholAndTobaccoTaxAndTradeBureau-Seal.png" class="ttbLogoClass" alt="ttb_logo">
                 
                </a></div>
               <div class="col-md-11" style="margin-top: 10px; padding-left: 0px;"> 
                <h1 style="color: white; vertical-align: middle; display: inline;font-family: Merriweather;">TTB Online</h1>
                 <h5 style="color: white; margin-top: 0px;">A single, secure access point for all your ttb application.</h5>
            </div>
               
            </div>
        </div>
    </header>

 <!--    <header class="header-ttb">
     <div class="container-fluid"><br></div> --
    <div class="container">
      <div class="row">
        <div class="col-1 pr-0">
          <img src="images/AlcoholAndTobaccoTaxAndTradeBureau-Seal.png" class="ttbLogoClass" style="margin-top: 10px; margin-bottom: 10px" alt="ttb_logo">
        </div>
        <div class="col-11" style="padding-left: 0px; ">
          <h1 class="h1Heading mb-0">TTB Online</h1>
          <h5 class="h1Heading">A single, secure access point for all your ttb application.</h5>
        </div>

      </div>
    </div>
  </header> -->
    <!-- page content -->
    <div class="container-fluid body-wrapper">
    
        <div class="row">
            <!-- content -->
            <div class="col-xs-12 col-sm-10 col-md-6 col-lg-6 wr-login">
                <div class="col-xs-12 col-sm-10 col-md-2 col-lg-2"></div>
                <div class="col-xs-12 col-sm-10 col-md-10 col-lg-10" style="padding-left: 0px">
                    <h2>Create Your Account</h2>
                <h3>Register once to apply for access to any Application</h3>
                <p>Ambitioni dedisse scripsisse iudicaretur. Cras mattis iudicium purus sit amet fermentum. Donec sed odio operae, eu vulputate felis rhoncus. Praeterea iter est quasdam res quas ex communi. At nos hinc posthac, sitientis piros Afros. Petierunt uti sibi concilium totius Galliae in diem certam indicere. Cras mattis iudicium purus sit amet fermentum.</p>
                </div>
            </div>
            <div class="col-xs-12 col-sm-10 col-md-6 col-lg-6 wr-login">
                <form action="signup.do" method="post" id="register">
                    <h2
                            class="wr-title blue-bcolor padding-double white boarder-bottom-blue margin-none">
                            <%=IdentityManagementEndpointUtil.i18n(recoveryResourceBundle, "Sign up")%>
                    </h2>
                
                    <div class="clearfix"></div>
                    <div class="boarder-all ">
                        <div class="alert alert-danger margin-left-double margin-right-double margin-top-double" id="error-msg" hidden="hidden">
                        </div>
                        <% if (error) { %>
                        <div class="alert alert-danger margin-left-double margin-right-double margin-top-double" id="server-error-msg">
                            <%=IdentityManagementEndpointUtil.i18nBase64(recoveryResourceBundle, errorMsg)%>
                        </div>
                        <% } %>
                        <!-- validation -->
                        <div class="padding-double">
                        
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 form-group required">
                             <!--    <div class="margin-bottom-double">
                                    <%=IdentityManagementEndpointUtil.i18n(recoveryResourceBundle, "Enter.your.username.here")%>
                                </div> -->
                                <label class="control-label">
                                    <%=IdentityManagementEndpointUtil.i18n(recoveryResourceBundle, "Username")%></label>
                                    <span>
            <a style="" class='my-tool-tip' data-toggle="tooltip" data-placement="bottom" 
                title="
                    Username should be between 5 and 30 characters long (letters and numbers).
                  Username must not contain the following special characters: ' (single-quote),
                  (double-quote), _ (underscore), = (equal sign), spaces, & (ampersand), % (percent),
                   ; (semicolon) , and @ (at sign). 
                                "> <!-- The class CANNOT be tooltip... -->
                <i class='glyphicon glyphicon-info-sign'></i>
            </a>
        </span>
                                <input id="username" name="username" type="text"
                                       class="form-control required usrName usrNameLength" required
                                    <% if(skipSignUpEnableCheck) {%> value="<%=Encode.forHtmlAttribute(username)%>" <%}%>>
                               <!--  <div class="font-small help-block">
                                    <%=IdentityManagementEndpointUtil.i18n(recoveryResourceBundle,
                                            "If.you.specify.tenant.domain.you.registered.under.super.tenant")%></div> -->
                                <input id="callback" name="callback" type="hidden" value="<%=callback%>"
                                       class="form-control required usrName usrNameLength" required>
                            </div>
                            <%  Map<String, String[]> requestMap = request.getParameterMap();
                                for (Map.Entry<String, String[]> entry : requestMap.entrySet()) {
                                    String key = Encode.forHtmlAttribute(entry.getKey());
                                    String value = Encode.forHtmlAttribute(entry.getValue()[0]); %>
                                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 form-group ">
                                    <input id="<%= key%>" name="<%= key%>" type="hidden"
                                           value="<%=value%>" class="form-control">
                                </div>
                            <% } %>
                            <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 form-group username-proceed column-centered">
                                   <a href="<%=Encode.forHtmlAttribute(IdentityManagementEndpointUtil.getUserPortalUrl(
                                    application.getInitParameter(IdentityManagementEndpointConstants.ConfigConstants.USER_PORTAL_URL)))%>"
                                   class="btn btn-default font-large full-width-xs">
                                    <%=IdentityManagementEndpointUtil.i18n(recoveryResourceBundle, "Cancel")%>
                                </a>
                                <button id="registrationSubmit"
                                        class="btn btn-primary font-large full-width-xs"
                                        type="submit"><%=IdentityManagementEndpointUtil.i18n(recoveryResourceBundle,
                                        "Continue")%>
                                </button>
                            
                            </div>
                            <div class="clearfix"></div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>


    <!-- footer -->
    <footer class="footer">
        <div class="">
          <!--   <p><%=IdentityManagementEndpointUtil.i18n(recoveryResourceBundle, "Wso2.identity.server")%> | &copy;
                <script>document.write(new Date().getFullYear());</script>
                <a href="<%=IdentityManagementEndpointUtil.i18n(recoveryResourceBundle, "business.homepage")%>" target="_blank"><i class="icon fw fw-wso2"></i> <%=
                IdentityManagementEndpointUtil.i18n(recoveryResourceBundle, "Inc")%></a>.
                <%=IdentityManagementEndpointUtil.i18n(recoveryResourceBundle, "All.rights.reserved")%>
            </p> -->
            
             <div class="col-12" style="background-color: #0053A2; height: 30px;">
                <div class="container">
                    <div class="row">
                        <div class="pull-right">
                            <span class="privacyPolicyClass" style="margin-right: 15px">Privacy Policy</span>
                            <span class="privacyPolicyClass">Privacy Impact Accessment</span>
                        </div>
                    </div>
                </div>
            </div>
             <div class="col-12" style="background-color: #003A6C;">
                <div class="container">
                    <div class="row" style="margin-top: 15px;">
                        <div class="col-md-6">
                            <div class="col-md-2">
                                <img src="images/ttb_landing_white_icon.png" class="ttbLogoFooter" alt="ttb_logo">
                            </div>
                            <div class="col-md-10" style="padding-left: 0px;">
                                <h4 style="color: white; vertical-align: middle;font-family: Merriweather;">Alcohol and
                                    Tobacco Tax and Trade Bureau(TTB)</h4>
                                <h4 style="color: white; vertical-align: middle;font-family: Merriweather;">
                                    U.S.Department of Treasury</h4>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <h4 style="color: white">Contact Us Online</h4>
                            <h4 style="color: white">TTB.helpdesk@ttb.gov</h4>
                        </div>
                        <div class="col-md-3">
                            <h4 style="color: white">Call the TTB Helpline</h4>
                            <h4 style="color: white">1-877-882-3277</h4>
                        </div>
                    </div>
                </div>
            </div>
                  <div class="row" style="background-color: #5c5c5c; color: white; padding-bottom: 30px;">
                <div class="container">
                    <p class="footerBottom">TTB PORTAL Version 1.5.11</p>
                    <p class="footerBottom">If you have difficulty accessing any information in the site due to a
                        disability, please contact us via online inquiry and we will do our best to make the information
                        available to you.</p>
                    <p class="footerBottom">This site is best viewed at 1280x800 screen resolution or higher using
                        Internet Explorer 8.0 or higher.</p>
                    <p class="footerBottom">WARNING! THIS SYSTEM IS THE PROPERTY OF THE UNITED STATES DEPARTMENT OF
                        TREASURY. UNAUTHORIZED USE OF THIS SYSTEM IS STRICTLY PROHIBITED AND SUBJECT TO CRIMINAL AND
                        CIVIL PENALITIES. THE DEPARTMENT MAY MONITOR, RECORD, AND AUDIT ANY ACTIVITY ON THE SYSTEM AND
                        SEARCH AND RETRIEVE ANY INFORMATION STORED WITHIN THE SYSTEM. BY ACCESSING AND USING THIS
                        COMPUTER YOU ARE AGREEING TO ABIDE BY THE TTB RULES OF BEHAVIOR, AND ARE CONSENTING TO SUCH
                        MONITORING, RECORDING, AND INFORMATION RETRIEVAL FOR LAW ENFORCEMENT AND OTHER PURPOSES. USERS
                        SHOULD HAVE NO EXPECTATION OF PRIVACY WHILE USING THIS SYSTEM.</p>
                </div>

            </div>
        </div>
    </footer>

   <!--   <footer class="footer">

        <div class="container-fluid">

            <div class="col-12" style="background-color: #0053A2; height: 30px;">
                <div class="container">
                    <div class="row">
                        <div class="pull-right">
                            <span class="privacyPolicyClass" style="margin-right: 15px">Privacy Policy</span>
                            <span class="privacyPolicyClass">Privacy Impact Accessment</span>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12" style="background-color: #003A6C;">
                <div class="container">
                    <div class="row" style="margin-top: 15px;">
                        <div class="col-md-6">
                            <div class="col-md-2">
                                <img src="images/AlcoholAndTobaccoTaxAndTradeBureau-Seal.png" class="ttbLogoFooter" alt="ttb_logo">
                            </div>
                            <div class="col-md-10" style="padding-left: 0px;">
                                <h4 style="color: white; vertical-align: middle;font-family: Merriweather;">Alcohol and
                                    Tobacco Tax and Trade Bureau(TTB)</h4>
                                <h4 style="color: white; vertical-align: middle;font-family: Merriweather;">
                                    U.S.Department of Treasury</h4>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <h4 style="color: white">Contact Us Online</h4>
                            <h4 style="color: white">TTB.helpdesk@ttb.gov</h4>
                        </div>
                        <div class="col-md-3">
                            <h4 style="color: white">Call the TTB Helpline</h4>
                            <h4 style="color: white">1-877-882-3277</h4>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row" style="background-color: #5c5c5c; color: white; padding-bottom: 30px;">
                <div class="container">
                    <p class="footerBottom">TTB PORTAL Version 1.5.11</p>
                    <p class="footerBottom">If you have difficulty accessing any information in the site due to a
                        disability, please contact us via online inquiry and we will do our best to make the information
                        available to you.</p>
                    <p class="footerBottom">This site is best viewed at 1280x800 screen resolution or higher using
                        Internet Explorer 8.0 or higher.</p>
                    <p class="footerBottom">WARNING! THIS SYSTEM IS THE PROPERTY OF THE UNITED STATES DEPARTMENT OF
                        TREASURY. UNAUTHORIZED USE OF THIS SYSTEM IS STRICTLY PROHIBITED AND SUBJECT TO CRIMINAL AND
                        CIVIL PENALITIES. THE DEPARTMENT MAY MONITOR, RECORD, AND AUDIT ANY ACTIVITY ON THE SYSTEM AND
                        SEARCH AND RETRIEVE ANY INFORMATION STORED WITHIN THE SYSTEM. BY ACCESSING AND USING THIS
                        COMPUTER YOU ARE AGREEING TO ABIDE BY THE TTB RULES OF BEHAVIOR, AND ARE CONSENTING TO SUCH
                        MONITORING, RECORDING, AND INFORMATION RETRIEVAL FOR LAW ENFORCEMENT AND OTHER PURPOSES. USERS
                        SHOULD HAVE NO EXPECTATION OF PRIVACY WHILE USING THIS SYSTEM.</p>
                </div>

            </div>
        </div>
    </footer> -->
    <script src="libs/jquery_1.11.3/jquery-1.11.3.js"></script>
    <script src="libs/bootstrap_3.3.5/js/bootstrap.min.js"></script>


    </body>
    </html>
