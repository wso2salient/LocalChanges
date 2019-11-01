<%--
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

<%@ page import="org.owasp.encoder.Encode" %>
<%@ page import="org.wso2.carbon.identity.mgt.endpoint.IdentityManagementEndpointConstants" %>
<%@ page import="org.wso2.carbon.identity.mgt.endpoint.IdentityManagementEndpointUtil" %>
<jsp:directive.include file="localize.jsp"/>

<%
    boolean error = IdentityManagementEndpointUtil.getBooleanValue(request.getAttribute("error"));
    String errorMsg = IdentityManagementEndpointUtil.getStringValue(request.getAttribute("errorMsg"));
%>


<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%=IdentityManagementEndpointUtil.i18n(recoveryResourceBundle, "Wso2.identity.server")%>
    </title>
    
    <link rel="icon" href="images/favicon.png" type="image/x-icon"/>
    <link href="libs/bootstrap_3.3.5/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/Roboto.css" rel="stylesheet">
    <link href="css/custom-common.css" rel="stylesheet">
    
    <!--[if lt IE 9]>
    <script src="js/html5shiv.min.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->
</head>

<body>
     <div style="margin: 0px; font-size: small;">
           <!--  <div style="width: 100%; height: 90px;" class="headerImage">
            </div> -->
        <div class="container-fluid">
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
              
                    <div class="col-md-4" style="display: flex;">
                            <img src="./images/american-flag-small.png" class="headerFlagClass" alt="usa flag">
                            <div style="top: 50%;"><i>An official website of the United States Government.</i></div>      
                    </div>
                       <div class="col-md-3">
                           <div><a href="#">U.S. Department of the Treasury</a></div>
                       </div>
                       <div class="col-md-2">
                            <div><a href="#">Alcohol Tax and Trade Bureau.</a></div>
                        </div>
                        <div class="col-md-2">
                                <div><a href="#">Public COLAs Registry.</a></div>
                        </div>
                        <div class="col-md-1">
                                <div><a href="#">Pay.gov</a></div>
                        </div>  
            </div>
        </div>
    </div>
<!-- header -->
<!-- <header class="header header-default">
    <div class="container-fluid"><br></div>
    <div class="container-fluid">
        <div class="pull-left brand float-remove-xs text-center-xs">
            <a href="#">
                <img src="images/logo-inverse.svg" alt=<%=IdentityManagementEndpointUtil.i18n(recoveryResourceBundle,
                 "Wso2")%> title=<%=IdentityManagementEndpointUtil.i18n(recoveryResourceBundle,
                 "Wso2")%> class="logo">
                
                <h1><em><%=IdentityManagementEndpointUtil.i18n(recoveryResourceBundle, "Identity.server")%>
                </em></h1>
            </a>
        </div>
    </div>
</header> -->
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
<!-- page content -->
<div class="container-fluid body-wrapper">
    
    <div class="row">
        <!-- content -->
        <div class="col-xs-12 col-sm-10 col-md-8 col-lg-6 col-centered wr-login">
            <form action="recoverpassword.do" method="post" id="tenantBasedRecovery">
                <h2 class="wr-title uppercase blue-bg padding-double white boarder-bottom-blue margin-none">
                    <%=IdentityManagementEndpointUtil.i18n(recoveryResourceBundle, "Start.password.recovery")%>
                </h2>
                
                <div class="clearfix"></div>
                <div class="boarder-all ">
                    <div class="alert alert-danger margin-left-double margin-right-double margin-top-double"
                         id="error-msg" hidden="hidden">
                    </div>
                    <% if (error) { %>
                    <div class="alert alert-danger margin-left-double margin-right-double margin-top-double"
                         id="server-error-msg">
                        <%=IdentityManagementEndpointUtil.i18nBase64(recoveryResourceBundle, errorMsg)%>
                    </div>
                    <% } %>
                    <!-- validation -->
                    <div class="padding-double">
                        
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 form-group required">
                            <div class="margin-bottom-double">
                                <%=IdentityManagementEndpointUtil.i18n(recoveryResourceBundle, "Enter.your.username.here")%>
                            </div>
                            <label class="control-label">
                                <%=IdentityManagementEndpointUtil.i18n(recoveryResourceBundle, "Username")%>
                            </label>
                            
                            <input id="username" name="username" type="text"
                                   class="form-control required usrName usrNameLength" required>
                            <div class="font-small help-block">
                                <%=IdentityManagementEndpointUtil.i18n(recoveryResourceBundle,
                                        "If.you.do.not.specify.tenant.domain.consider.as.super.tenant")%>
                            </div>
                        </div>
                        
                        <%
                            String callback = Encode.forHtmlAttribute
                                    (request.getParameter("callback"));
                            if (callback != null) {
                        %>
                        <div>
                            <input type="hidden" name="callback" value="<%=callback %>"/>
                        </div>
                        <%
                            }
                        %>
                        
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 form-group username-proceed">
                            <button id="registrationSubmit"
                                    class="wr-btn grey-bg uppercase font-large full-width-xs"
                                    type="submit"><%=IdentityManagementEndpointUtil.i18n(recoveryResourceBundle,
                                    "Proceed.password.recovery")%>
                            </button>
                            <a href="<%=Encode.forHtmlAttribute(IdentityManagementEndpointUtil.getUserPortalUrl(
                                    application.getInitParameter(IdentityManagementEndpointConstants.ConfigConstants.USER_PORTAL_URL)))%>"
                               class="light-btn uppercase font-large full-width-xs">
                                <%=IdentityManagementEndpointUtil.i18n(recoveryResourceBundle, "Cancel")%>
                            </a>
                        </div>
                        <div class="clearfix"></div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>


<!-- footer -->
<!-- <footer class="footer">
    <div class="container-fluid">
        <p><%=IdentityManagementEndpointUtil.i18n(recoveryResourceBundle, "Wso2.identity.server")%> | &copy;
            <script>document.write(new Date().getFullYear());</script>
            <a href="<%=IdentityManagementEndpointUtil.i18n(recoveryResourceBundle, "business.homepage")%>" target="_blank"><i class="icon fw fw-wso2"></i> <%=
            IdentityManagementEndpointUtil.i18n(recoveryResourceBundle, "Inc")%>
            </a>.
            <%=IdentityManagementEndpointUtil.i18n(recoveryResourceBundle, "All.rights.reserved")%>
        </p>
    </div>
</footer> -->

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


<script src="libs/jquery_1.11.3/jquery-1.11.3.js"></script>
<script src="libs/bootstrap_3.3.5/js/bootstrap.min.js"></script>
<script type="text/javascript">

    $(document).ready(function () {
        $("#tenantBasedRecovery").submit(function (e) {
            var errorMessage = $("#error-msg");
            errorMessage.hide();
            var username = $("#username").val();

            if (username == '') {
                errorMessage.text("Please fill the username.");
                errorMessage.show();
                $("html, body").animate({scrollTop: errorMessage.offset().top}, 'slow');
                return false;
            }
            return true;
        });
    });
</script>
</body>
</html>
