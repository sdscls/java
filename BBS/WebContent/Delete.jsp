<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>

<%!
	private void del(Connection conn, int id) {

		Statement stmt = null;
		ResultSet rs = null;

		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select * from article where pid =" + id);

			while (rs.next()) {
				del(conn, rs.getInt("id"));
			}
			stmt.executeUpdate("delete from article where id = "+id);
			
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
	String admin = (String)session.getAttribute("admin");
	if(admin==null || !admin.equals("true")){
		out.println("Please login first!");
		return;
	}
	
%>

<%

	int id = Integer.parseInt(request.getParameter("id"));
	int pid = Integer.parseInt(request.getParameter("pid"));
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost/bbs";
		String usr = "root";
		String password = "root";
		conn = DriverManager.getConnection(url, usr, password);
		
		conn.setAutoCommit(false);
		del(conn, id);
		stmt = conn.createStatement();
		rs = stmt.executeQuery("select count(*) from article where id = "+pid);
		rs.next();
		int count = rs.getInt(1);
		if(count<=0){
			Statement stmtUpdate = conn.createStatement();
			stmtUpdate.executeUpdate("update article set isleaf = 0 where id =" +pid);
			stmtUpdate.close();
		}
	
		conn.commit();
		conn.setAutoCommit(true);

	} catch (ClassNotFoundException e) {
		e.printStackTrace();
	} catch (SQLException e) {
		if(conn!=null){
			conn.rollback();
			conn.setAutoCommit(true);
		}
		e.printStackTrace();
	} finally {
		rs.close();
		stmt.close();
		conn.close();
	}
	response.sendRedirect("ShowArticleTree.jsp");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
</body>
</html>