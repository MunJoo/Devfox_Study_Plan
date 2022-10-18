<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MunJoo_Project</title>

 <!-- CSS -->
 <link href="/resources/css/bootstrap.min.css" rel="stylesheet">
 <link href="/resources/css/summernote.min.css" rel='stylesheet'>
 <link href="/resources/css/font-awesome.min.css" rel="stylesheet">
 <link href="/resources/css/common.css" rel="stylesheet">
 <link href="/resources/css/layout.css" rel='stylesheet'>

 <!-- JS -->
 <script src="/resources/js/jquery-3.3.1.min.js"></script>
 <script src="/resources/js/bootstrap.min.js"></script>
 <script src="/resources/js/summernote.min.js"></script>

</head>
<body>

	<div class="top_navigation">
	
		<header class="header">
			<nav class="top_left">
			  <ul>
			  	<li class="first"><a href="#">HOME</a></li>
			  </ul>
			</nav>
			<nav class="top_right">
				<ul>
					<sec:authorize access="isAnonymous()"> <!-- スペルに注意 -->
						<li class="first"><a href="/member/login.do">Login</a></li>
						<li><a href="/member/member.do">Join</a></li>
					</sec:authorize>
					<sec:authorize access="isAuthenticated()">
						<li class="first">
							<form name="logout" method="post" action="/member/logout.do">
				        		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				        		<button type="submit" style="border:0 none; backgroung:transparent;">Logout</button>
				        	</form>
						</li>
						<li><a href="mypage.do">Mypage</a></li>
					</sec:authorize>
				</ul>
			</nav>
			
			<div class="moon_group">
				<h1 class="logo">MunJoo_Project</h1>
				<nav class="moon">
					<ul class="nav_1depth">
						<li><a href="/notice/notice.do">Notice</a></li>
					</ul>
				</nav>
			</div>
		</header>

		<div class="line">
		</div>
	</div>
