<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	String login = request.getParameter("login");
	if(login!=null && login.equals("login")){
		
		String uname = request.getParameter("uname");
		String pwd = request.getParameter("pwd");
		if(uname==null || !uname.equals("admin")){
			out.println("usename is not correct");
		} else if(pwd ==null || !pwd.equals("admin")){
			out.println("password is not correct");
		}else {
			session.setAttribute("admin", "true");
			response.sendRedirect("ShowArticleTree.jsp");
		}
	}
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>

<body>
<form action="Login.jsp" method="post">
<input type="hidden" name="login" value="login"/>
<table>
	<tr>
		<td>
			<input type="text" name="uname" size ="40"/>
		</td>
	</tr>
	<tr>
		<td>
			<input type="password" name="pwd" size ="40"/>
		</td>
	</tr>
	<tr>
		<td>
			<input type="submit" value ="Submit"/>
		</td>
	</tr>
	
	
</table>	
</form>
</body>
</html>