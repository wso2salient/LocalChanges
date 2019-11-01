<%--
  ~ Copyright (c) 2014, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
  ~
  ~ WSO2 Inc. licenses this file to you under the Apache License,
  ~ Version 2.0 (the "License"); you may not use this file except
  ~ in compliance with the License.
  ~ You may obtain a copy of the License at
  ~
  ~ http://www.apache.org/licenses/LICENSE-2.0
  ~
  ~ Unless required by applicable law or agreed to in writing,
  ~ software distributed under the License is distributed on an
  ~ "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
  ~ KIND, either express or implied.  See the License for the
  ~ specific language governing permissions and limitations
  ~ under the License.
  --%>

<%@page import="com.google.gson.Gson" %>
<%@page import="org.wso2.carbon.identity.application.authentication.endpoint.util.AuthContextAPIClient" %>
<%@page import="org.wso2.carbon.identity.application.authentication.endpoint.util.Constants" %>
<%@ page import="org.wso2.carbon.identity.core.util.IdentityCoreConstants" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.wso2.carbon.identity.core.util.IdentityUtil" %>
<%@ page import="static org.wso2.carbon.identity.application.authentication.endpoint.util.Constants.STATUS" %>
<%@ page import="static org.wso2.carbon.identity.application.authentication.endpoint.util.Constants.STATUS_MSG" %>
<%@ page
        import="static org.wso2.carbon.identity.application.authentication.endpoint.util.Constants.CONFIGURATION_ERROR" %>
<%@ page
        import="static org.wso2.carbon.identity.application.authentication.endpoint.util.Constants.AUTHENTICATION_MECHANISM_NOT_CONFIGURED" %>
<%@ page
        import="static org.wso2.carbon.identity.application.authentication.endpoint.util.Constants.ENABLE_AUTHENTICATION_WITH_REST_API" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Map" %>
<%@include file="localize.jsp" %>
<jsp:directive.include file="init-url.jsp" />

<%!
    private static final String FIDO_AUTHENTICATOR = "FIDOAuthenticator";
    private static final String IWA_AUTHENTICATOR = "IwaNTLMAuthenticator";
    private static final String IS_SAAS_APP = "isSaaSApp";
    private static final String BASIC_AUTHENTICATOR = "BasicAuthenticator";
    private static final String IDENTIFIER_EXECUTOR = "IdentifierExecutor";
    private static final String OPEN_ID_AUTHENTICATOR = "OpenIDAuthenticator";
    private static final String JWT_BASIC_AUTHENTICATOR = "JWTBasicAuthenticator";
    private static final String X509_CERTIFICATE_AUTHENTICATOR = "x509CertificateAuthenticator";
%>

<%
        request.getSession().invalidate();
        String queryString = request.getQueryString();
        Map<String, String> idpAuthenticatorMapping = null;
        if (request.getAttribute(Constants.IDP_AUTHENTICATOR_MAP) != null) {
            idpAuthenticatorMapping = (Map<String, String>) request.getAttribute(Constants.IDP_AUTHENTICATOR_MAP);
        }

        String errorMessage = "authentication.failed.please.retry";
        String errorCode = "";
        if(request.getParameter(Constants.ERROR_CODE)!=null){
            errorCode = request.getParameter(Constants.ERROR_CODE) ;
        }
        String loginFailed = "false";

        if (Boolean.parseBoolean(request.getParameter(Constants.AUTH_FAILURE))) {
            loginFailed = "true";
            String error = request.getParameter(Constants.AUTH_FAILURE_MSG);
            if (error != null && !error.isEmpty()) {
                errorMessage = error;
            }
        }
    %>
<%

        boolean hasLocalLoginOptions = false;
        boolean isBackChannelBasicAuth = false;
        List<String> localAuthenticatorNames = new ArrayList<String>();

        if (idpAuthenticatorMapping != null && idpAuthenticatorMapping.get(Constants.RESIDENT_IDP_RESERVED_NAME) != null) {
            String authList = idpAuthenticatorMapping.get(Constants.RESIDENT_IDP_RESERVED_NAME);
            if (authList != null) {
                localAuthenticatorNames = Arrays.asList(authList.split(","));
            }
        }


    %>
<%
        boolean reCaptchaEnabled = false;
        if (request.getParameter("reCaptcha") != null && "TRUE".equalsIgnoreCase(request.getParameter("reCaptcha"))) {
            reCaptchaEnabled = true;
        }
    %>
<%
        String inputType = request.getParameter("inputType");
        String username = null;
    
        if (isIdentifierFirstLogin(inputType)) {
            String authAPIURL = application.getInitParameter(Constants.AUTHENTICATION_REST_ENDPOINT_URL);
            if (StringUtils.isBlank(authAPIURL)) {
                authAPIURL = IdentityUtil.getServerURL("/api/identity/auth/v1.1/", true, true);
            }
            if (!authAPIURL.endsWith("/")) {
                authAPIURL += "/";
            }
            authAPIURL += "context/" + request.getParameter("sessionDataKey");
            String contextProperties = AuthContextAPIClient.getContextProperties(authAPIURL);
            Gson gson = new Gson();
            Map<String, Object> parameters = gson.fromJson(contextProperties, Map.class);
            username = (String) parameters.get("username");
        }
        
    %>
<html>

<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%=AuthenticationEndpointUtil.i18n(resourceBundle, "wso2.identity.server")%></title>
    <!-- <script src="libs/jquery_1.11.3/jquery-1.11.3.js"></script> -->
    <link rel="icon" href="images/favicon.png" type="image/x-icon" />
    <link href="libs/bootstrap_3.3.5/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/Roboto.css" rel="stylesheet">
    <link href="css/custom-common.css" rel="stylesheet">
    <link href="css/ttb-login.css" rel="stylesheet">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.2.0/css/all.css" integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ" crossorigin="anonymous">
    <!--[if lt IE 9]>
        <script src="js/html5shiv.min.js"></script>
        <script src="js/respond.min.js"></script>
        <![endif]-->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js" integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo=" crossorigin="anonymous"></script>
    <style type="text/css">
        a:hover {
            color: #333333;
            text-decoration: underline;
        }
        .ttbHeadingText{
            color: white; 
            font-weight: bold;
            vertical-align: middle; 
            display: inline;
            font-family: Merriweather;
        }
    </style>
    <%
            if (reCaptchaEnabled) {
        %>
    <script src='<%=
        (request.getParameter("reCaptchaAPI"))%>'></script>
    <%
            }
        %>

    <script>

        function checkSessionKey() {
            $.ajax({
                type: "GET",
                url: "/logincontext?sessionDataKey=" + getParameterByName("sessionDataKey") + "&relyingParty=" + getParameterByName("relyingParty") + "&tenantDomain=" + getParameterByName("tenantDomain"),
                success: function (data) {
                    if (data && data.status == 'redirect' && data.redirectUrl && data.redirectUrl.length > 0) {
                        window.location.href = data.redirectUrl;
                    }
                },
                cache: false
            });
        }


        function getParameterByName(name, url) {
            if (!url) {
                url = window.location.href;
            }
            name = name.replace(/[\[\]]/g, '\\$&');
            var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
                results = regex.exec(url);
            if (!results) return null;
            if (!results[2]) return "";
            return decodeURIComponent(results[2].replace(/\+/g, ' '));
        }
    </script>
    <script>
        function toggleIcon(e) {
    $(e.target)
        .prev('.panel-heading')
        .find(".more-less")
        .toggleClass('glyphicon-plus glyphicon-minus');
}
$('.panel-group').on('hidden.bs.collapse', toggleIcon);
$('.panel-group').on('shown.bs.collapse', toggleIcon);
    </script>
</head>

<body onload="checkSessionKey()" class="bkColor">
       <div style="margin: 0px; font-size: small;">
            <div style="width: 100%; height: 90px;" class="headerImage">
            </div>
        <div class="container-fluid">
            <div class="row" style="margin-top: 10px; margin-bottom: 10px;">
              
                    <div class="col-md-6" style="display: flex;">
                            <img src="./images/Flag_banner_icon.png" class="headerFlagClass" alt="usa flag">
                            <div style="top: 50%;"><i>An official website of the United States Government</i></div>      
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
    <header class="header-ttb"  style="background-color: #003A6C;">
        <!-- <div class="container-fluid"><br></div> -->
        <div class="container">
            <div class="row">
                <!-- <a href="#">
                    <img src="images/logo-inverse.svg"
                        alt="<%=AuthenticationEndpointUtil.i18n(resourceBundle, "business.name")%>"
                        title="<%=AuthenticationEndpointUtil.i18n(resourceBundle, "business.name")%>" class="logo">

                    <h1><em><%=AuthenticationEndpointUtil.i18n(resourceBundle, "identity.server")%></em></h1>
                </a> -->
                 <img src="./images/ttb_landing_page.png" class="ttbLogoClass" alt="ttb_logo" style="margin-left: -10px;">
                <h1 class="ttbHeadingText">TTB Online</h1>
                
            </div>
        </div>
    </header>

    <!-- page contentaier start -->
    <div class="container">
        <div class="hidden-sm hidden-xs">
          
        <div class="row">
            <div class="col-xs-12 col-sm-12 col-md-8 col-lg-8">
                   
                <!-- <div style="width: 700px; height: 700px;" class="backImage">
                    
                </div> -->
                <!-- <img src="./images/Background_seal_homepage.png"  alt="ttb_logo_backimage">
                             <div>
                                 <h1 class="subHeading">Welcome to TTB Online</h1>
                   <h2 class="nextTosubHeading">A single, secure access point for all your TTB applications.</h2>
                             </div>
                             <div>
                    <input type="button" name="read more" value="READ MORE" style="background-color: transparent; color: white; height: 40px; margin-top: 30px;">
                 </div>  -->
                 <div style="position: relative; z-index: 1;">
                        
                    <img src="./images/Background_seal_homepage_largefloat.png" style="position: absolute;margin-top: -21px;" />
                    <div id="overlay_text" style="position: relative; top: -10px; z-index: 3;">
                        <h1 class="subHeading">Welcome to TTB Online</h1>
                        <h2 class="nextTosubHeading">A single, secure access point for all your TTB applications.</h2>
                        <input type="button" name="read more" value="READ MORE" style="background-color: transparent; color: white; height: 40px; margin-top: 30px;">
                        
                    </div>
                  </div>
            </div>

           
             <div class="col-xs-12 col-sm-12 col-md-4 col-lg-4" style="background-color: #AEC6F6; top: -30px; z-index: 3" >
                <div>
                    <h3 id="lockSign">Secure Account Log In<span ></span></h3>
               </div>
                <div class="loginStyle" style="margin: -10px;margin-bottom: 5px;">
                
                    <div class="">
                       
                        </div>
                        <div>
                            <div class="login-form">
                            <%
                                if (localAuthenticatorNames.size() > 0) {

                                    if (localAuthenticatorNames.size() > 0 && localAuthenticatorNames.contains(OPEN_ID_AUTHENTICATOR)) {
                                        hasLocalLoginOptions = true;
                            %>

                            <%@ include file="openid.jsp" %>
                            <%
                            } else if (localAuthenticatorNames.size() > 0 && localAuthenticatorNames.contains(IDENTIFIER_EXECUTOR)) {
                                hasLocalLoginOptions = true;
                            %>
                            <%@ include file="identifierauth.jsp" %>
                            <%
                            } else if (localAuthenticatorNames.size() > 0 && localAuthenticatorNames.contains(JWT_BASIC_AUTHENTICATOR) ||
                                    localAuthenticatorNames.contains(BASIC_AUTHENTICATOR)|| 
                                    localAuthenticatorNames.contains("TTBCustomAuthenticator-PONL") || 
                                    localAuthenticatorNames.contains("TTBCustomAuthenticator-FONL")) {
                                hasLocalLoginOptions = true;
                                boolean includeBasicAuth = true;
                                if (localAuthenticatorNames.contains(JWT_BASIC_AUTHENTICATOR)) {
                                    if (Boolean.parseBoolean(application.getInitParameter(ENABLE_AUTHENTICATION_WITH_REST_API))) {
                                        isBackChannelBasicAuth = true;
                                    } else {
                                        String redirectURL = "error.do?" + STATUS + "=" + CONFIGURATION_ERROR + "&" +
                                                STATUS_MSG + "=" + AUTHENTICATION_MECHANISM_NOT_CONFIGURED;
                                        response.sendRedirect(redirectURL);
                                    }
                                } else if (localAuthenticatorNames.contains(BASIC_AUTHENTICATOR)||
                                   localAuthenticatorNames.contains("TTBCustomAuthenticator-PONL") || 
                                   localAuthenticatorNames.contains("TTBCustomAuthenticator-FONL")){
                                    isBackChannelBasicAuth = false;
                                if (TenantDataManager.isTenantListEnabled() && Boolean.parseBoolean(request.getParameter(IS_SAAS_APP))) {
                                    includeBasicAuth = false;
%>
                            <%@ include file="tenantauth.jsp" %>
                            <%
                            }
                                }
                            
                            if (includeBasicAuth) {
                                        %>
                            <%@ include file="basicauth.jsp" %>
                            <%
                                    }
                                }
                            }
                            %>

                            <%if (idpAuthenticatorMapping != null &&
                                    idpAuthenticatorMapping.get(Constants.RESIDENT_IDP_RESERVED_NAME) != null) { %>

                            <%} %>
                            <%
                                if ((hasLocalLoginOptions && localAuthenticatorNames.size() > 1) || (!hasLocalLoginOptions)
                                        || (hasLocalLoginOptions && idpAuthenticatorMapping != null && idpAuthenticatorMapping.size() > 1)) {
                            %>
                            <div class="form-group">
                                <% if (hasLocalLoginOptions) { %>
                                <label class="font-large"><%=AuthenticationEndpointUtil.i18n(resourceBundle,
                                        "other.login.options")%>:</label>
                                <%} %>
                            </div>
                            <div class="form-group">
                                <%
                                    int iconId = 0;
                                    if (idpAuthenticatorMapping != null) {
                                    for (Map.Entry<String, String> idpEntry : idpAuthenticatorMapping.entrySet()) {
                                        iconId++;
                                        if (!idpEntry.getKey().equals(Constants.RESIDENT_IDP_RESERVED_NAME)) {
                                            String idpName = idpEntry.getKey();
                                            boolean isHubIdp = false;
                                            if (idpName.endsWith(".hub")) {
                                                isHubIdp = true;
                                                idpName = idpName.substring(0, idpName.length() - 4);
                                            }
                                %>
                                <% if (isHubIdp) { %>
                                <div>
                                    <a href="#" data-toggle="popover" data-placement="bottom" title="<%=AuthenticationEndpointUtil.i18n(resourceBundle,"sign.in.with")%>
                                    <%=Encode.forHtmlAttribute(idpName)%>" id="popover" id="icon-<%=iconId%>">
                                        <img class="idp-image" src="images/login-icon.png" title="<%=AuthenticationEndpointUtil.i18n(resourceBundle,"sign.in.with")%>
                                         <%=Encode.forHtmlAttribute(idpName)%>" />

                                        <div id="popover-head" class="hide">
                                            <label
                                                class="font-large"><%=AuthenticationEndpointUtil.i18n(resourceBundle,"sign.in.with")%>
                                                <%=Encode.forHtmlContent(idpName)%></label>
                                        </div>
                                        <div id="popover-content" class="hide">
                                            <form class="form-inline">
                                                <div class="form-group">
                                                    <input id="domainName" class="form-control" type="text" placeholder="<%=AuthenticationEndpointUtil.i18n(resourceBundle,
                                                       "domain.name")%>">
                                                </div>
                                                <input type="button" class="btn btn-primary go-btn"
                                                    onClick="javascript: myFunction('<%=idpName%>','<%=idpEntry.getValue()%>','domainName')"
                                                    value="<%=AuthenticationEndpointUtil.i18n(resourceBundle,"go")%>" />
                                            </form>

                                        </div>
                                    </a>
                                    <label for="icon-<%=iconId%>"><%=Encode.forHtmlContent(idpName)%></label>
                                </div>
                                <%} else { %>
                                <div>
                                    <a onclick="javascript: handleNoDomain('<%=Encode.forJavaScriptAttribute(Encode.
                                forUriComponent(idpName))%>',
                                        '<%=Encode.forJavaScriptAttribute(Encode.forUriComponent(idpEntry.getValue()))%>')"
                                        href="#" id="icon-<%=iconId%>">
                                        <img class="idp-image" src="images/login-icon.png" data-toggle="tooltip"
                                            data-placement="top" title="<%=AuthenticationEndpointUtil.i18n(resourceBundle,
                                                       "sign.in.with")%> <%=Encode.forHtmlAttribute(idpName)%>" />
                                    </a>
                                    <label for="icon-<%=iconId%>"><%=Encode.forHtmlContent(idpName)%></label>
                                </div>
                                <%} %>
                                <%
                                } else if (localAuthenticatorNames.size() > 0) {
                                    if (localAuthenticatorNames.contains(IWA_AUTHENTICATOR)) {
                                %>
                                <div>
                                    <a onclick="javascript: handleNoDomain('<%=Encode.forJavaScriptAttribute(Encode.
                                forUriComponent(idpEntry.getKey()))%>',
                                        'IWAAuthenticator')" class="main-link" style="cursor:pointer"
                                        id="icon-<%=iconId%>">
                                        <img class="idp-image" src="images/login-icon.png" data-toggle="tooltip"
                                            data-placement="top" title="<%=AuthenticationEndpointUtil.i18n(resourceBundle,
                                                       "sign.in.with")%> IWA" />
                                    </a>
                                    <label for="icon-<%=iconId%>">IWA</label>
                                </div>
                                <%
                                    }
                                    if (localAuthenticatorNames.contains(X509_CERTIFICATE_AUTHENTICATOR)) {
                                %>
                                <div>
                                    <a onclick="javascript: handleNoDomain('<%=Encode.forJavaScriptAttribute(Encode.
                                forUriComponent(idpEntry.getKey()))%>',
                                            'x509CertificateAuthenticator')" class="main-link" style="cursor:pointer"
                                        id="icon-<%=iconId%>">
                                        <img class="idp-image" src="images/login-icon.png" data-toggle="tooltip"
                                            data-placement="top" title="<%=AuthenticationEndpointUtil.i18n(resourceBundle,
                                                       "sign.in.with")%> X509 Certificate" />
                                    </a>
                                    <label for="icon-<%=iconId%>">x509CertificateAuthenticator</label>

                                </div>
                                <%
                                    }
                                    if (localAuthenticatorNames.contains(FIDO_AUTHENTICATOR)) {
                                %>
                                <div>
                                    <a onclick="javascript: handleNoDomain('<%=Encode.forJavaScriptAttribute(Encode.
                                forUriComponent(idpEntry.getKey()))%>',
                                        'FIDOAuthenticator')" class="main-link" style="cursor:pointer"
                                        id="icon-<%=iconId%>">
                                        <img class="idp-image" src="images/login-icon.png" data-toggle="tooltip"
                                            data-placement="top" title="<%=AuthenticationEndpointUtil.i18n(resourceBundle,
                                                       "sign.in.with")%> FIDO" />
                                    </a>
                                    <label for="icon-<%=iconId%>">FIDO</label>

                                </div>
                                <%
                                            }
                                    if (localAuthenticatorNames.contains("totp")) {
                                %>
                                <div>
                                    <a onclick="javascript: handleNoDomain('<%=Encode.forJavaScriptAttribute(Encode.
                                forUriComponent(idpEntry.getKey()))%>',
                                        'totp')" class="main-link" style="cursor:pointer" id="icon-<%=iconId%>">
                                        <img class="idp-image" src="images/login-icon.png" data-toggle="tooltip"
                                            data-placement="top" title="<%=AuthenticationEndpointUtil.i18n(resourceBundle,
                                                       "sign.in.with")%> TOTP" />
                                    </a>
                                    <label for="icon-<%=iconId%>">TOTP</label>

                                </div>
                                <%
                                            }
                                        }

                                    }
                                    }%>

                            </div>


                            <% } %>

                            <div class="clearfix"></div>

                        </div>
                            
                        </div>
                </div>        
        </div> 

    </div>
    </div>
    <div class="hidden-md hidden-lg">
        <h1>For Small device</h1>      
        <!-- Accordian Start -->
       <!--  <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script> -->
<!------ Include the above in your HEAD tag ---------->

<div class="container demo">

    
    <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">

        <div class="panel panel-default">
            <div class="panel-heading" role="tab" id="headingOne">
                <h4 class="panel-title">
                    <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                        <i class="more-less glyphicon glyphicon-plus"></i>
                        Collapsible Group Item #1
                    </a>
                </h4>
            </div>
            <div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                <div class="panel-body">
                      Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
                </div>
            </div>
        </div>

        <div class="panel panel-default">
            <div class="panel-heading" role="tab" id="headingTwo">
                <h4 class="panel-title">
                    <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                        <i class="more-less glyphicon glyphicon-plus"></i>
                        Collapsible Group Item #2
                    </a>
                </h4>
            </div>
            <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                <div class="panel-body">
                    Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
                </div>
            </div>
        </div>

        <div class="panel panel-default">
            <div class="panel-heading" role="tab" id="headingThree">
                <h4 class="panel-title">
                    <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                        <i class="more-less glyphicon glyphicon-plus"></i>
                        Collapsible Group Item #3
                    </a>
                </h4>
            </div>
            <div id="collapseThree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingThree">
                <div class="panel-body">
                    Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven't heard of them accusamus labore sustainable VHS.
                </div>
            </div>
        </div>

    </div><!-- panel-group -->
    
    
</div><!-- container -->
        <!-- Accordian End -->
       
    </div>
</div>
<!-- page contentaier end -->
<!-- News and Notice start -->
<%@ include file="./htmlFile/News_and_notice_Final.html" %>
<!-- News and Notice End -->
<!-- What is TTB Online Start -->
<%@ include file="./htmlFile/whatisTTBOnline_Final.html" %>
<!-- What is TTB Online End -->
<!-- For New User Start -->
<!-- <%@ include file="./htmlFile/forNewUser.html" %> -->
<!-- For New User End -->
<!-- Learn about TTB Start -->
<!-- <%@ include file="./htmlFile/learnAboutTTB.html" %> -->
<!-- Learn about TTB End -->
<!-- Help and Support Start  -->
<%@ include file="./htmlFile/helpAndSupport_Final.html" %>
<!-- Help and Support End -->
    <!-- footer start-->
    <footer class="ttbfooter">
        <div class="container">
            <div class="row" style="padding-left: 0px; margin-top: 10px; margin-bottom: 10px;">
                <div class="col-md-12">
                    <ul style="padding-left: 0px; margin-bottom: 0px;">
                        <li><a href="https://www.ttb.gov/about-ttb/accessibility">Accessibility</a></li>
                        <li>&bullet; <a href="https://www.ttb.gov/about-ttb/privacy-policy">Privacy Policy</a></li>
                        <li>&bullet; <a href="https://www.treasury.gov/No-Fear-Act/Pages/default.aspx">No FEAR Act</a> </li>
                        <li>&bullet; <a href="https://www.ttb.gov/ttb-tip-line">Report Fraud</a></li>
                    </ul>
                    <ul style="padding-left: 0px;">
                        <li><a href="https://www.ttb.gov/contact-ooc">Contact Webmaster </a></li>
                        <li>&bullet; <a href="https://survey.foreseeresults.com/survey/display?cid=gJJNtM8gkR1AIF10kZ4EwA==&mid=NhgRRMIVN4BJNJs8JUARpA4C">Contact Webmaster </a>&bullet;</li>
                    </ul>
                </div>
            </div>
        </div>
    </footer>
    <!-- footer end -->

    <script src="libs/jquery_1.11.3/jquery-1.11.3.js"></script>
    <script src="libs/bootstrap_3.3.5/js/bootstrap.min.js"></script>

    <script>
        $(document).ready(function () {
            $('.main-link').click(function () {
                $('.main-link').next().hide();
                $(this).next().toggle('fast');
                var w = $(document).width();
                var h = $(document).height();
                $('.overlay').css("width", w + "px").css("height", h + "px").show();
            });
            $('[data-toggle="popover"]').popover();
            $('.overlay').click(function () {
                $(this).hide();
                $('.main-link').next().hide();
            });

            <%
            if (reCaptchaEnabled) {
            %>
            var error_msg = $("#error-msg");
                $("#loginForm").submit(function (e) {
                    var resp = $("[name='g-recaptcha-response']")[0].value;
                    if (resp.trim() == '') {
                        error_msg.text("<%=AuthenticationEndpointUtil.i18n(resourceBundle,"please.select.recaptcha")%>");
                        error_msg.show();
                        $("html, body").animate({ scrollTop: error_msg.offset().top }, 'slow');
                        return false;
                    }
                    return true;
                });
            <%
            }
            %>
        });
        function myFunction(key, value, name) {
            var object = document.getElementById(name);
            var domain = object.value;


            if (domain != "") {
                document.location = "<%=commonauthURL%>?idp=" + key + "&authenticator=" + value +
                    "&sessionDataKey=<%=Encode.forUriComponent(request.getParameter("sessionDataKey"))%>&domain=" +
                        domain;
            } else {
                document.location = "<%=commonauthURL%>?idp=" + key + "&authenticator=" + value +
                    "&sessionDataKey=<%=Encode.forUriComponent(request.getParameter("sessionDataKey"))%>";
            }
        }

        function handleNoDomain(key, value) {
            <%
                String multiOptionURIParam = "";
            if (localAuthenticatorNames.size() > 1 || idpAuthenticatorMapping != null && idpAuthenticatorMapping.size() > 1) {
                multiOptionURIParam = "&multiOptionURI=" + Encode.forUriComponent(request.getRequestURI() +
                    (request.getQueryString() != null ? "?" + request.getQueryString() : ""));
            }
            %>
                document.location = "<%=commonauthURL%>?idp=" + key + "&authenticator=" + value +
                    "&sessionDataKey=<%=Encode.forUriComponent(request.getParameter("sessionDataKey"))%>" +
                        "<%=multiOptionURIParam%>";
        }

        $('#popover').popover({
            html: true,
            title: function () {
                return $("#popover-head").html();
            },
            content: function () {
                return $("#popover-content").html();
            }
        });
        window.onunload = function () { };
    </script>

    <script>
        function changeUsername(e) {
            document.getElementById("changeUserForm").submit();
        }
    </script>

    <%!
        private boolean isIdentifierFirstLogin(String inputType) {
            return "idf".equalsIgnoreCase(inputType);
        }
    %>

</body>

</html>