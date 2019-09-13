<% 
String relyingParty = request.getParameter("relyingParty");
 
if (relyingParty.equals("travelocity.com")) {
 RequestDispatcher dispatcher = request.getRequestDispatcher("travelocity_login.jsp");
 dispatcher.forward(request, response);
} else if (relyingParty.equals("avis.com")){
 RequestDispatcher dispatcher = request.getRequestDispatcher("avis_app_login.jsp");
 dispatcher.forward(request, response);
} else {
	RequestDispatcher dispatcher = request.getRequestDispatcher("default_login.jsp");	
 	dispatcher.forward(request, response);
} 

  %>