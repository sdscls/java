<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*" %>

<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	int id = Integer.parseInt(request.getParameter("id"));
	Map tm = null;
	
	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost/bbs";
		String usr = "root";
		String password = "root";
		conn = DriverManager.getConnection(url, usr, password);
		stmt = conn.createStatement();
		tm = new TreeMap();
		rs = stmt.executeQuery("select * from article where id = "+id+";");
		
		if(rs.next()) {
			tm.put("id", rs.getInt("id"));
			tm.put("pid", rs.getInt("pid"));
			tm.put("rootid", rs.getInt("rootid"));
			tm.put("title", rs.getString("title"));
			tm.put("cont", rs.getString("cont"));
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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

<table border="1">
	<tr>
		<td>ID</td>
		<td><%=tm.get("id") %></td>
	</tr>
	<tr>
		<td>Title</td>
		<td><%=tm.get("title") %></td>
	</tr>
	<tr>
		<td>Content</td>
		<td><%=tm.get("cont") %></td>
	</tr>
	
</table>

<a href ="Reply.jsp?id=<%=tm.get("id")%>&rootid=<%=tm.get("rootid") %>">Reply</a>

</body>
</html>