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

<%@ page import="org.apache.cxf.jaxrs.client.JAXRSClientFactory" %>
<%@ page import="org.apache.cxf.jaxrs.provider.json.JSONProvider" %>
<%@ page import="org.apache.cxf.jaxrs.client.WebClient" %>
<%@ page import="org.apache.http.HttpStatus" %>
<%@ page import="org.owasp.encoder.Encode" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.endpoint.client.SelfUserRegistrationResource" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.endpoint.util.AuthenticationEndpointUtil" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.endpoint.util.bean.ResendCodeRequestDTO" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.endpoint.util.bean.UserDTO" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="javax.ws.rs.core.Response" %>
<%@ page import="static org.wso2.carbon.identity.core.util.IdentityUtil.isSelfSignUpEPAvailable" %>
<%@ page import="static org.wso2.carbon.identity.core.util.IdentityUtil.isRecoveryEPAvailable" %>
<%@ page import="static org.wso2.carbon.identity.core.util.IdentityUtil.getServerURL" %>
<%@ page import="org.apache.commons.codec.binary.Base64" %>
<%@ page import="java.nio.charset.Charset" %>
<%@ page import="org.wso2.carbon.base.ServerConfiguration" %>
<%@ page import="org.wso2.carbon.identity.application.authentication.endpoint.util.EndpointConfigManager" %>


<jsp:directive.include file="init-loginform-action-url.jsp"/>
<style type="text/css">
  
  .field-icon {
  float: right;
  background-image: url('./image/eye.png');
  margin-left: -25px;
  margin-top: -25px;
  position: relative;
  z-index: 2;
}
.margin-top-20{
    margin-top: 20px;
}

</style>



<script src="js/jquery-2.1.0.min.js"></script>
<script src="js/bootstrap.min.js"></script>

<script>
    
   function RegisterNow() {
           $("#registerNow").modal('show');
    }
   
   //   window.onload = function() {
   //     var spName = "<%=request.getParameter("sp")%>";
   //      if ( spName == 'PermitIdP2Post' || spName == 'travelocity.com' || spName == 'avis.com') {
             
   //          document.getElementById("selectedAppId").style.display = "none";
   //      } else {
         
   //        document.getElementById("selectedAppId").style.display = "block";
   //      }
   // }
          
        function submitCredentials (e) {
            e.preventDefault();
            var userName = document.getElementById("username");
             // var password = document.getElementById("password").value;
            //  alert('username....'+userName);
// Added By Hemal -----------------------------------------------------------------------
            var selectedApplication = document.getElementById("selectedApplication").value;
             alert('selectedApplication....'+selectedApplication);
// --------------------------------------------------------------
             var sp = document.getElementById("sp"); 
                   
              

              if(sp.value.trim() == "PermitIdP2Post") 
               { 
                
                if(selectedApplication == 'local'){
                    // userName.value = "ttb" + "/" + userName.value.trim();
                  userName.value =  userName.value.trim();  // Hemal
                  alert('local........'+userName.value);
             
                } else {
                    // userName.value = "ttb" + "/" + userName.value.trim();  
                      userName.value = "ponl" + "/" + userName.value.trim();  
                  // userName.value = selectedApplication + "/" + userName.value.trim();  // Hemal
                  alert('Another user then local.....'+userName.value);
                }
                
               }
               else if (sp.value.trim() == "travelocity.com") { 
                  // userName.value = selectedApplication + "/" + userName.value.trim();  
                    userName.value =  "fonl" + "/" + userName.value.trim();           // Hemal
                    alert('Travelocity.......'+ userName.value);
                     // userName.value = "Fonl"+"/" + userName.value.trim();
                } else if(sp.value.trim() == "avis.com") {
                    userName.value = "fonl" + "/" + userName.value.trim();  
                    // userName.value =  selectedApplication + "/" + userName.value.trim();   // Hemal
                    alert('Avis.......'+ userName.value);
                    // userName.value = "Fonl"+"/" + userName.value.trim();
               } 
              else 
               { 
                // userName.value = selectedApplication + "/" + userName.value.trim(); // Hemal
                
                userName.value = userName.value.trim();
                  
                //  alert('Else user.....'+userName.value);
               } 
            if(userName.value){
                alert('Submit.....'+userName.value);
                document.getElementById("loginForm").submit();
            }
        }


        function goBack() {
            window.history.back();
        }

        function showPassword() {
             var x = document.getElementById("password");
            
         
            if (x.type === "password") {
              x.type = "text";
             document.getElementById("showPass").innerHTML = "Hide";
             
            } else {
              x.type = "password";
             document.getElementById("showPass").innerHTML = "Show";
            
            }
      }

     

   //   function submitCredentials (e) {
   //          e.preventDefault();
   //          var userName = document.getElementById("username");
   //           var sp = document.getElementById("sp"); 
   //            if(sp.value.trim() == "PermitIdP2Post") 
   //             { 
   //              userName.value = "ttb" + "/" + userName.value.trim();
   //             else if
   //              (sp.value.trim() == "travelocity.com") { 
   //     userName.value = "ttb" + userName.value.trim()
   // } else if(sp.value.trim() == "avis.com") {
   //     userName.value = "ttb" + userName.value.trim();
   //             } 
   //            else 
   //             { 
   //              userName.value = userName.value.trim();
   //             } 
   //          if(userName.value){
   //              document.getElementById("loginForm").submit();
   //          }
   //      }

   //      function goBack() {
   //          window.history.back();
   //      }

   //  }

</script>
<div class="container">
    <!-- Modal -->
    <div class="modal fade" id="registerNow" role="dialog">
      <div class="modal-dialog">
      
        <!-- Modal content-->
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal">&times;</button>
            <h4 class="modal-title">TTB Online</h4>
          </div>
          <div class="modal-body">
            <p>You have access only for FONL and COLA Application</p>
          </div>
          <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
          </div>
        </div>
        
      </div>
    </div>
    
  </div>

<%!
    private static final String JAVAX_SERVLET_FORWARD_REQUEST_URI = "javax.servlet.forward.request_uri";
    private static final String JAVAX_SERVLET_FORWARD_QUERY_STRING = "javax.servlet.forward.query_string";
    private static final String UTF_8 = "UTF-8";
    private static final String TENANT_DOMAIN = "tenant-domain";
%>
<%
    String resendUsername = request.getParameter("resend_username");
    String sp = request.getParameter("sp");
    if (StringUtils.isNotBlank(resendUsername)) {

        ResendCodeRequestDTO selfRegistrationRequest = new ResendCodeRequestDTO();
        UserDTO userDTO = AuthenticationEndpointUtil.getUser(resendUsername);
        selfRegistrationRequest.setUser(userDTO);

        String path = config.getServletContext().getInitParameter(Constants.ACCOUNT_RECOVERY_REST_ENDPOINT_URL);
        String proxyContextPath = ServerConfiguration.getInstance().getFirstProperty(IdentityCoreConstants
                .PROXY_CONTEXT_PATH);
        if (proxyContextPath == null) {
            proxyContextPath = "";
        }
        String url;
        if (StringUtils.isNotBlank(EndpointConfigManager.getServerOrigin())) {
            url = EndpointConfigManager.getServerOrigin() + proxyContextPath + path;
        } else {
            url = IdentityUtil.getServerURL(path, true, false);
        }
        url = url.replace(TENANT_DOMAIN, userDTO.getTenantDomain());

        List<JSONProvider> providers = new ArrayList<JSONProvider>();
        JSONProvider jsonProvider = new JSONProvider();
        jsonProvider.setDropRootElement(true);
        jsonProvider.setIgnoreNamespaces(true);
        jsonProvider.setValidateOutput(true);
        jsonProvider.setSupportUnwrapped(true);
        providers.add(jsonProvider);

        String toEncode = EndpointConfigManager.getAppName() + ":" + String
                .valueOf(EndpointConfigManager.getAppPassword());
        byte[] encoding = Base64.encodeBase64(toEncode.getBytes());
        String authHeader = new String(encoding, Charset.defaultCharset());
        String header = "Client " + authHeader;

        SelfUserRegistrationResource selfUserRegistrationResource = JAXRSClientFactory
                .create(url, SelfUserRegistrationResource.class, providers);
        WebClient.client(selfUserRegistrationResource).header("Authorization", header);
        Response selfRegistrationResponse = selfUserRegistrationResource.regenerateCode(selfRegistrationRequest);
        if (selfRegistrationResponse != null &&  selfRegistrationResponse.getStatus() == HttpStatus.SC_CREATED) {
%>
<div class="alert alert-info">
    <%=AuthenticationEndpointUtil.i18n(resourceBundle,Constants.ACCOUNT_RESEND_SUCCESS_RESOURCE)%>
</div>
<%
} else {
%>
<div class="alert alert-danger">
    <%=AuthenticationEndpointUtil.i18n(resourceBundle,Constants.ACCOUNT_RESEND_FAIL_RESOURCE)%>
</div>
<%
        }
    }
%>

<form action="<%=loginFormActionURL%>" method="post" id="loginForm">
<input id="sp" name="sp" type="hidden" value="<%=sp%>">
    <%
        if (loginFormActionURL.equals(samlssoURL) || loginFormActionURL.equals(oauth2AuthorizeURL)) {
    %>
    <input id="tocommonauth" name="tocommonauth" type="hidden" value="true">
    <%
        }
    %>

    <% if (Boolean.parseBoolean(loginFailed)) { %>
    <div class="alert alert-danger" id="error-msg"><%= AuthenticationEndpointUtil.i18n(resourceBundle, errorMessage) %>
    </div>
    <%}else if((Boolean.TRUE.toString()).equals(request.getParameter("authz_failure"))){%>
    <div class="alert alert-danger" id="error-msg">
        <%=AuthenticationEndpointUtil.i18n(resourceBundle, "unauthorized.to.login")%>
    </div>
    <%}%>

    <% if (!isIdentifierFirstLogin(inputType)) { %> 
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 form-group">
        <label for="username"><%=AuthenticationEndpointUtil.i18n(resourceBundle, "Username or email address")%></label>
        <input id="username" name="username" type="text" class="form-control" tabindex="0" placeholder="" required>
    </div>
    <% } else {%>
        <input id="username" name="username" type="hidden" value="<%=username%>">
    <% }%>
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 form-group">
        <label for="password"><%=AuthenticationEndpointUtil.i18n(resourceBundle, "password")%></label>
        <span class="pull-right">
          <input type="checkbox" onclick="showPassword()" class="float-right"> show Password
        </span>
        
        <input id="password" name="password" type="password" class="form-control" placeholder="" autocomplete="off">
         <!-- <p class="form-control-feedback glyphicon glyphicon-eye-open" onmousedown="mouseDown()" onmouseup="mouseUp()">Test</p> -->
       <!--  <div class="input-group">
           <input id="password" name="password" type="password" class="form-control" placeholder="" autocomplete="off">
          <  <i class="form-control-feedback glyphicon glyphicon-eye-open" id="showPass" onmousedown="mouseDown()" onmouseup="mouseUp()"></i> --
               <div class="input-group-append">
                  <button class="btn btn-default" id="showPass" type="button" onmousedown="mouseDown()" onmouseup="mouseUp()"><i class="form-control-feedback glyphicon glyphicon-eye-open" id="showPass"></i></button>
              </div>
        </div> -->

    
    </div>
    <div>
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 form-group margin-top-20" >
            <!-- <label for="application">Select Your Userstore Domain</label> -->
            <select class="form-control" id="selectedApplication">
              <option>Select An Account</option>  
              <option value="ttb">ttb</option>
              <option value="Ponl">ponl</option>
              <option value="Fonl">fonl</option>
              <option>local</option>
            </select>
        </div>
         </div>
    <%
        if (reCaptchaEnabled) {
    %>
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 form-group">
        <div class="g-recaptcha"
             data-sitekey="<%=Encode.forHtmlContent(request.getParameter("reCaptchaKey"))%>">
        </div>
    </div>
    <%
        }
    %>
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 form-group">
        <div class="checkbox">
            <label>
                <input type="checkbox" id="chkRemember" name="chkRemember">
                <%=AuthenticationEndpointUtil.i18n(resourceBundle, "remember.me")%>
            </label>
        </div>
    </div>
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <input type="hidden" name="sessionDataKey" value='<%=Encode.forHtmlAttribute
            (request.getParameter("sessionDataKey"))%>'/>
    </div>
    <!-- <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 padding-double">
        <div class="alert alert-warning margin-bottom-3 padding-10" role="alert">
            <div>
                <%=AuthenticationEndpointUtil.i18n(resourceBundle, "privacy.policy.cookies.short.description")%>
                <a href="cookie_policy.do" target="policy-pane">
                    <%=AuthenticationEndpointUtil.i18n(resourceBundle, "privacy.policy.cookies")%>
                </a>
                <%=AuthenticationEndpointUtil.i18n(resourceBundle, "privacy.policy.for.more.details")%>
            </div>
        </div>
        <div class="alert alert-warning margin-none padding-10" role="alert">
            <div>
                <%=AuthenticationEndpointUtil.i18n(resourceBundle, "privacy.policy.privacy.short.description")%>
                <a href="privacy_policy.do" target="policy-pane">
                    <%=AuthenticationEndpointUtil.i18n(resourceBundle, "privacy.policy.general")%>
                </a>
            </div>
        </div>
    </div> -->
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 form-group">
        <div class="form-actions">
            <button
                    class="ttb-btn col-xs-6 col-md-4 col-lg-4 uppercase font-extra-large margin-bottom-double"
                    type="submit" onclick="submitCredentials(event)">
                    <%=AuthenticationEndpointUtil.i18n(resourceBundle, "log In")%>
            </button>
        </div>
    </div>
        <%
            String recoveryEPAvailable = application.getInitParameter("EnableRecoveryEndpoint");
            String enableSelfSignUpEndpoint = application.getInitParameter("EnableSelfSignUpEndpoint");
            Boolean isRecoveryEPAvailable;
            Boolean isSelfSignUpEPAvailable;

            if (StringUtils.isNotBlank(recoveryEPAvailable)) {
                isRecoveryEPAvailable = Boolean.valueOf(recoveryEPAvailable);
            } else {
                isRecoveryEPAvailable = isRecoveryEPAvailable();
            }

            if (StringUtils.isNotBlank(enableSelfSignUpEndpoint)) {
                isSelfSignUpEPAvailable = Boolean.valueOf(enableSelfSignUpEndpoint);
            } else {
                isSelfSignUpEPAvailable = isSelfSignUpEPAvailable();
            }

            if (isRecoveryEPAvailable || isSelfSignUpEPAvailable) {
                String scheme = request.getScheme();
                String serverName = request.getServerName();
                int serverPort = request.getServerPort();
                String uri = (String) request.getAttribute(JAVAX_SERVLET_FORWARD_REQUEST_URI);
                String prmstr = (String) request.getAttribute(JAVAX_SERVLET_FORWARD_QUERY_STRING);
                String urlWithoutEncoding = scheme + "://" +serverName + ":" + serverPort + uri + "?" + prmstr;
                String urlEncodedURL = URLEncoder.encode(urlWithoutEncoding, UTF_8);

                String identityMgtEndpointContext =
                        application.getInitParameter("IdentityManagementEndpointContextURL");
                if (StringUtils.isBlank(identityMgtEndpointContext)) {
                    identityMgtEndpointContext = getServerURL("/accountrecoveryendpoint", true, true);
                }

                if (isRecoveryEPAvailable) {
        %>
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 form-group">
            <div class="form-actions">
                <%=AuthenticationEndpointUtil.i18n(resourceBundle, "forgot.username.password")%>
                <% if (!isIdentifierFirstLogin(inputType)) { %>
                    <a id="usernameRecoverLink" href="<%=getRecoverAccountUrl(identityMgtEndpointContext, urlEncodedURL, true)%>">
                        <%=AuthenticationEndpointUtil.i18n(resourceBundle, "forgot.username")%>
                    </a>
                    <%=AuthenticationEndpointUtil.i18n(resourceBundle, "forgot.username.password.or")%>
                <% } %>
                <a id="passwordRecoverLink" href="<%=getRecoverAccountUrl(identityMgtEndpointContext, urlEncodedURL, false)%>">
                    <%=AuthenticationEndpointUtil.i18n(resourceBundle, "forgot.password")%>
                </a>
                ?
            </div>
    
            <div class="form-actions">
                <% if (isIdentifierFirstLogin(inputType)) { %>
                <a id="backLink" onclick="goBack()">
                    <%=AuthenticationEndpointUtil.i18n(resourceBundle, "sign.in.different.account")%>
                </a>
                <% } %>
            </div>
        </div>
        <%
                }
                if (isSelfSignUpEPAvailable && !isIdentifierFirstLogin(inputType)) {
        %>
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 form-group">
            <div class="form-actions">
            <%=AuthenticationEndpointUtil.i18n(resourceBundle, "no.account")%>
            <a id="registerLink" onclick="RegisterNow()" href="<%=getRegistrationUrl(identityMgtEndpointContext, urlEncodedURL)%>">
                <%=AuthenticationEndpointUtil.i18n(resourceBundle, "register.now")%>
            </a>
            </div>
        </div>
       
        <%
                }
            }
        %>
    <% if (Boolean.parseBoolean(loginFailed) && errorCode.equals(IdentityCoreConstants.USER_ACCOUNT_NOT_CONFIRMED_ERROR_CODE) && request.getParameter("resend_username") == null) { %>
        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12 form-group">
            <div class="form-actions">
                <%=AuthenticationEndpointUtil.i18n(resourceBundle, "no.confirmation.mail")%>
                <a id="registerLink"
                   href="login.do?resend_username=<%=Encode.forHtml(request.getParameter("failedUsername"))%>&<%=AuthenticationEndpointUtil.cleanErrorMessages(request.getQueryString())%>">
                    <%=AuthenticationEndpointUtil.i18n(resourceBundle, "resend.mail")%>
                </a>
            </div>
        </div>
        <%}%>
    </div>

    <div class="clearfix"></div>
    <%!
    
        private String getRecoverAccountUrl(String identityMgtEndpointContext, String urlEncodedURL, boolean isUsernameRecovery) {
        
            return identityMgtEndpointContext + "/recoveraccountrouter.do?callback=" +
                    Encode.forHtmlAttribute(urlEncodedURL) + "&isUsernameRecovery=" + isUsernameRecovery;
        }
    
        private String getRegistrationUrl(String identityMgtEndpointContext, String urlEncodedURL) {
            return identityMgtEndpointContext + "/register.do?callback=" + Encode.forHtmlAttribute(urlEncodedURL);
        }
    %>
</form>
