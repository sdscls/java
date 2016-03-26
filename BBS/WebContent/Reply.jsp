<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	int id = Integer.parseInt(request.getParameter("id"));
	int rootid =Integer.parseInt(request.getParameter("rootid"));
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
		if(Trim(document.reply.title.value) == ""){
			alert("please input the title!");
			document.reply.title.focus();
			return false;
		}
		if(Trim(document.reply.content.value)==""){
			alert("please input the content!");
			document.reply.content.focus();
			return false;
		}
		return true;
	}
</script>

</head>

<body>

<form name=reply action="ReplyOk.jsp" method="post" onsubmit="return check()">
<input type="hidden" name="id" value="<%=id %>"/>
<input type="hidden" name="rootid" value="<%=rootid%>"/>
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