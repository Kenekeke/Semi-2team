<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>

<%
	String password = (String)request.getAttribute("password");
%>

<div class="pw_wrapper" >
	<div class="row">
		<h2>임시 비밀번호 발급 완료</h2>
	</div>
	<div class="row">
		<h2>발급된 비밀번호 :<%=password%></h2>
	</div>
</div>

