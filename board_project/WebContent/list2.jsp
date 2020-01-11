<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="board_project.Article"%>
<%@ page import="board_project.ArticleManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	// JDBC의 명령을 받아 실제로 DBMS와 통신할 실무자를 선택한다.
	String dbDriver = "com.mysql.jdbc.Driver";

	// 내(JSP)가 통신할 DB서버의 위치와 DB의 이름, 그리고 연결 옵션들 세팅
	String dbUrl = "jdbc:mysql://localhost:3306/a1?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false";
	// DB서버의 사용자명
	String dbUser = "sbsst";
	// DB서버의 사용자 비번
	String dbPass = "sbsst";

	// DB연결객체 변수
	Connection con = null;
	// SQL 작성양식 변수
	Statement stmt = null;
	// SQL 쿼리 응답 변수
	ResultSet rs = null;

	// 실제로 DB서버에 이야기할 내용
	String sql = "SELECT * FROM article ORDER BY id DESC";

	// DB서버에 쿼리를 날리면 결과가 리턴되는데, 그 결과는 압축되어 있어서 바로 쓰기가 곤란하다.
	// 그래서 사용하기 편한 용기(?)에 담을 계획이다.
	// 여러가지 면에서 봤을 때 게시물 데이터들을 담을 용기로 리스트가 선정되었다.
	// 그리고 각각의 게시물은 DTO (Article)fh 저장하기로 결정했다. 
	ArrayList<Article> articles = new ArrayList<Article>();

	try {
		// DB연결을 하기 전에 실무자를 선택한다.
		// 즉 DB 드라이버 활성화
		Class.forName(dbDriver);

		// DB와 연결
		con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
		// DB연결객체에게 빈 양식 하나를 만들어서 달라고 한다.
		stmt = con.createStatement();
		// 양식을 실행(?)하면 결과가 온다. 단 압축되어 있다.
		rs = stmt.executeQuery(sql);

		// rs.next() rs 라는 책을 다음 장으로 넘긴다.
		// 만약에 쿼리 결과 행이 4개(줄이 4개)가 나왔다면 rs 안의 페이지는 총 (0, 1, 2, 3) 4페이지로 구성된다.
		// 다음장이 있으면 true, 없으면 false를 리턴한다.
		// 이 작업은 rs에 압축되어 있는 데이터를 압축해제해서 articles에 담기위한 것이다.
		while (rs.next()) {
			int id = rs.getInt("id"); // rs가 현재 선택한 페이지에서 id를 읽어간다.
			String regDate = rs.getString("regDate");
			String title = rs.getString("title");
			String body = rs.getString("body");

			// 각각의 게시물 정보를 담을 해시맵 객체를 만든다.
			Article article = new Article();
			article.setId(id);
			article.setRegDate(regDate);
			article.setTitle(title);
			article.setBody(body);

			// 게시물들(list)에 게시물(article)을 추가한다.
			articles.add(article);
		}

	} catch (SQLException e) {
		// 위 try 구문에서 SQLException이 발생했다면 여기가 실행한다.
		System.out.println("SQLException : " + e.getMessage());
	} catch (ClassNotFoundException e) {
		// 위 try 구문에서 ClassNotFoundException 발생했다면 여기가 실행한다.
		System.out.println("ClassNotFoundException : " + e.getMessage());
	} finally {
		// 자원해제 순서는 무조건 rs => stmt => con 이다.
		// rs 변수에 객체가 할당 되었다면 자원해제 작업을 한다.
		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		// stmt 변수에 객체가 할당 되었다면 자원해제 작업을 한다.
		if (stmt != null) {
			try {
				stmt.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		// con 변수에 객체가 할당 되었다면 자원해제 작업을 한다.
		if (con != null) {
			try {
				con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시물 리스트</title>
</head>
<body>
	<h1>게시물 리스트</h1>

	<div>
		<a href="./add.jsp">작성하기</a>
	</div>

	<h2>일반 for문 버전</h2>

	<%
		for (int i = 0; i < articles.size(); i++) {
			Article article = articles.get(i);
	%>
	<div>
		<div>
			번호 :
			<%=article.getId()%>
		</div>
		<div>
			제목 :
			<%=article.getTitle()%>
		</div>
		<div>
			내용 :
			<%=article.getBody()%>
		</div>
		<hr>
	</div>
	<%
		}
	%>

	<h2>향상된 for문 버전</h2>

	<%
		for (Map<String, Object> article : articles) {
	%>
	<div>
		<div>
			번호 :
			<%=article.getId()%>
		</div>
		<div>
			제목 :
			<%=article.getTitle()%>
		</div>
		<div>
			내용 :
			<%=article.getBody()%>
		</div>
		<hr>
	</div>
	<%
		}
	%>

	<div>
		<a href="./add.jsp">작성하기</a>
	</div>
</body>
</html>