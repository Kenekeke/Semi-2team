<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/template/header.jsp"></jsp:include>

<title>SemiProject kh4 Join</title>
<link rel="stylesheet" type="text/css" href="./css/common.css">

<style>
  div.join_page {
  	padding:10% 45%;
  }
.button {
 	width:270px;
	border:none;
 	border-radius:20px;
	background-color:#7b9acc;
	color:white;
	text-align:center;
	font-size:20px;
  	padding:60px 30px;
	cursor:pointer;
}
  .button:hover{
    background:white;
    color:#7b9acc;
    box-shadow: 0 12px 16px 0 rgba(0,0,0,0.24),0 17px 50px 0 rgba(0,0,0,0.19);
  }
</style>

	<div class="join_page">
		<input type="button" class="button" value="일반 회원가입" onclick="location.href='join_member.jsp'">
    	<br><br><br>
   		<input type="button" class="button" value="중개사 회원가입" onclick="location.href='join_broker.jsp'">
    </div>

<jsp:include page="/template/footer.jsp"></jsp:include>
