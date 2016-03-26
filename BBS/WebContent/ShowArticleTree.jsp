<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>

<% 
	String admin = (String)session.getAttribute("admin");
	if(admin!=null && admin.equals("true")){
		login = true;
	}
	
%>

<%!
	String str = "";
	boolean login = false;

	private void tree(Connection conn, int id, int level) {

		Statement stmt = null;
		ResultSet rs = null;
		String preStr = "";

		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select * from article where pid =" + id);

			for (int i = 0; i < level; i++) {
				preStr += "----";
			}
			
			

			while (rs.next()) {
				String strLogin = "";
				
				if(login){
					strLogin = "<td><a href = 'Delete.jsp?id="
							+ rs.getInt("id") + "&pid=" + rs.getInt("pid")
							+ "'>Delete</a></td>";
				}
				
				str += "<tr><td>" + rs.getInt("id") + "</td><td>" + preStr
						+ "<a href='ShowArticleDetail.jsp?id="
						+ rs.getInt("id") + "'>" + rs.getString("title")
						+ "</a></td>" +strLogin + "</tr>";

				if (rs.getInt("isleaf") != 0) {
					tree(conn, rs.getInt("id"), level + 1);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
					rs = null;
				}
				if (stmt != null) {
					stmt.close();
					stmt = null;
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}%>

<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost/bbs";
		String usr = "root";
		String password = "root";
		conn = DriverManager.getConnection(url, usr, password);
		stmt = conn.createStatement();
		rs = stmt.executeQuery("select * from article where pid = 0;");

		str = "";
		String strLogin = "";
		while (rs.next()) {
			
			if(login){
				strLogin = "<td><a href = 'Delete.jsp?id="
						+ rs.getInt("id") + "&pid=" + rs.getInt("pid")
						+ "'>Delete</a></td>";
			}
			
			str += "<tr><td>" + rs.getInt("id") + "</td><td>"
					+ "<a href='ShowArticleDetail.jsp?id="
					+ rs.getInt("id") + "'>" + rs.getString("title")
					+ "</a></td>" + strLogin+ "</tr>";
			if (rs.getInt("isleaf") != 0) {
				tree(conn, rs.getInt("id"), 1);
			}
		}

	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		rs.close();
		stmt.close();
		conn.close();
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<a href="Post.jsp">Post new topic</a>
	<table border="1"><%=str%>
	<%login=false; %>
	</table>
	
</body>
</html>