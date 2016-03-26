<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<% 
	request.setCharacterEncoding("UTF-8");
	int id = Integer.parseInt(request.getParameter("id"));
	int rootid =Integer.parseInt(request.getParameter("rootid"));
	
	String title = request.getParameter("title");
	if(title.trim()=="" || title.trim()==null){
		out.println("The title should not be empty! Please enter the title!");
	}
	
	String content = request.getParameter("content").replace("\n", "<br>");
	if(content.trim()=="" || content.trim()==null){
		out.println("The content should not be empty! Please enter the content!");
	}
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	Statement stmt = null;
	
	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost/bbs";
		String usr = "root";
		String password = "root";
		conn = DriverManager.getConnection(url, usr, password);

		conn.setAutoCommit(false);
		String sql = "insert into article values (null, ?, ?, ?, ?, now(), 0)";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, id);
		pstmt.setInt(2, rootid);
		pstmt.setString(3, title);
		pstmt.setString(4, content);
		pstmt.executeUpdate();
		
		stmt = conn.createStatement();
		stmt.executeUpdate("update article set isleaf =1 where id="+id);
		
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
		stmt.close();
		pstmt.close();
		conn.close();
	}
	response.sendRedirect("ShowArticleTree.jsp");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<font color="Red" size="7">
	Ok!
</font>
</body>
</html>