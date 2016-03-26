<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*, java.util.*"%>

<%
	int pageNo;
	int pageSize = 3;
	int totalRecords=0;
	String strPageNo = request.getParameter("pageNo");
	if (strPageNo == null || strPageNo.equals("")) {
		pageNo = 1;
	} else {
		try {
			pageNo = Integer.parseInt(strPageNo.trim());
		} catch (NumberFormatException e) {
			pageNo = 1;
		}
		if (pageNo < 1)
			pageNo = 1;
	}

	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	String str = "";

	try {
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost/bbs";
		String usr = "root";
		String password = "root";
		conn = DriverManager.getConnection(url, usr, password);
		stmt = conn.createStatement();

		Statement stmtCounts = null;
		ResultSet rsCounts = null;
		
		try{
			stmtCounts = conn.createStatement();
			rsCounts = stmtCounts
					.executeQuery("select count(*) from article where pid = 0;");
			rsCounts.next();
			int totalCounts = rsCounts.getInt(1);
			totalRecords = totalCounts % pageSize ==0 ? totalCounts / pageSize : totalCounts / pageSize + 1;
			if(pageNo > totalRecords) pageNo = totalRecords;
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			rsCounts.close();
			stmtCounts.close();
		}

		rs = stmt
				.executeQuery("select * from article where pid = 0 limit "
						+ (pageNo - 1)
						* pageSize
						+ ","
						+ pageSize
						+ ";");

		while (rs.next()) {
			str += "<tr><td>" + rs.getString("title") + "</td></tr>";
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
	<table border="1">
		<%=str%>
	</table>
	共 <%=totalRecords %> 第<%=pageNo %>页&nbsp; <a href="ShowArticleFlat.jsp?pageNo=<%=pageNo-1%>"> < </a> <a href="ShowArticleFlat.jsp?pageNo=<%=pageNo+1%>"> > </a>
	<form name="form1">
		<select name="pageNo" onchange="document.form1.submit()">
			<%for(int i=1; i< totalRecords; i++) {%>
				<option value="<%=i %>" <%=(pageNo == i) ? "selected":""%>>第<%=i %>页</option>
			<%}%>
		</select>
	</form>
	<form name="form2">
		<input type="text" name="pageNo" value="<%=pageNo %>" size="4"/>
		<input type="submit" value="go"></input>
	</form>
	
</body>
</html>