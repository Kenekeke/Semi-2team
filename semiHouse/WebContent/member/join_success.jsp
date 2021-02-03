<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/common.css">


<style>
h3{
	color:#7b9acc;
	font-size:40px;
	text-align:center;
  padding-left:80px;
}
.button_login{
	width:400;
	border:none;
	border-radius:20px;
	background-color:#7b9acc;
	text-align:center;
	color:white;
	font-size:30px;
	font-weight:bold;
	padding:0.1% 30%;
	cursor:pointer;
	margin:0 auto;
}
div.button{
	padding:10% 47%;
  margin:0 auto;
}
.button_login:hover{
	background:white;
	color:#7b9acc;
	box-shadow:0 12px 16px 0 rgba(0,0,0,0.24), 0 17px 40px 0 rgba(0,0,0,0.19);
}
</style>

		<div calss="empty" style="height:926px"; width=100%">
		<div class="row center">
			<h3>회원 가입이 완료되었습니다.</h3>
		</div>
			
		<div class="button">
			<input type="button" class="button_login" value="로그인" onclick="location.href='login.jsp'">
		</div>
		</div>
	


<jsp:include page="/template/footer.jsp"></jsp:include>


    