<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<% 
	String post = request.getParameter("action");
	if(post!=null && post.equals("post")){
		
		request.setCharacterEncoding("UTF-8");
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
			String sql = "insert into article values (null, 0, ?, ?, ?, now(), 0)";
			
			pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
			pstmt.setInt(1, -1);
			pstmt.setString(2, title);
			pstmt.setString(3, content);
			pstmt.executeUpdate();
			
			ResultSet rsKeys = pstmt.getGeneratedKeys();
			rsKeys.next();
			int key = rsKeys.getInt(1);
			
			
			stmt = conn.createStatement();
			stmt.executeUpdate("update article set id = "+ key +" where id="+key);
			
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
//		response.sendRedirect("ShowArticleTree.jsp");
		response.sendRedirect("ShowArticleFlat.jsp");
		
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script>
	function LTrim(str) { //去掉字符串的头空格
		var i;
		for(i=0; i<str.length; i++){
			if(str.charAt(i) != " ") break;
		}
		str = str.substring(i, str.length);
		return str;
	}
	
	function RTrim(str){
		var i;
		for(i = str.length-1; i>=0; i--){
			if(str.charAt(i)!=" ") break;
		}
		str = str.substring(0, i+1);
		return str;
	}
	
	function Trim(str){
		return LTrim(RTrim(str));
	}
	
	function check(){
		if(Trim(document.post.title.value) == ""){
			alert("please input the title!");
			document.post.title.focus();
			return false;
		}
		if(Trim(document.post.content.value)==""){
			alert("please input the content!");
			document.post.content.focus();
			return false;
		}
		return true;
	}
</script>

</head>

<body>
<form name="post" action="Post.jsp" method="post" onsubmit="return check()">
<input type="hidden" name="action" value="post"/>
<table>
	<tr>
		<td>
			<input type="text" name="title" size ="65"/>
		</td>
	</tr>
	<tr>
		<td>
			<textarea cols="50" rows="10" name="content"></textarea>
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