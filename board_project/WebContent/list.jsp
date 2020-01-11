<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="board_project.ArticleManager"%>
<%@ page import="board_project.Article"%>
<%@ page import="java.util.ArrayList"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		ArticleManager am = new ArticleManager();
		ArrayList<Article> list = am.getAllArticles();
		if (list.isEmpty()) {
			am.init();
		}
	%>


	<h2>게시판</h2>
	<hr>
	<table border="1">
		<tr>
			<td>번호</td>
			<td>제목</td>
			<td>작성자</td>
			<td>작성일</td>
		</tr>
		<%
			for (int i = 0; i < list.size(); i++) {
		%>
		<tr>
			<td><%=list.get(i).getId()%></td>
			<td><%=list.get(i).getTitle()%></td>
			<td><%=list.get(i).getNick()%></td>
			<td><%=list.get(i).getRegDate()%></td>
		</tr>
		<%
			}
		%>
	</table>
	<a href="addForm.jsp">게시물 등록</a>

</body>
</html>