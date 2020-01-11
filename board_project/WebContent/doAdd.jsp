<%@ page import="board_project.Article" %>
<%@ page import="board_project.ArticleManager" %>

<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String title = request.getParameter("title");
	String body = request.getParameter("body");
	String nick = request.getParameter("nick");
	
	Article a = new Article();
		
	
	a.setTitle(title);
	a.setBody(body);
	a.setNick(nick);
	
	ArticleManager am = new ArticleManager();
	am.insertArticle(a);
	
	RequestDispatcher dispatcher = request.getRequestDispatcher("list.jsp");
	dispatcher.forward(request, response);
%>
