<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<jsp:include page="/template/header.jsp"></jsp:include>
<div class="all_wrapper">
<form action="login.do" method="post">
<div class="login_wrapper">
	<div style="padding: 30px;margin-left: 122px;font-size: 23px;">	
		<label class="login_gubun"> 
			<input type="radio" name="flag" value="m" checked="checked">
			일반회원
		</label>
		<label class="login_gubun"> 
			<input type="radio" name="flag" value="b">
			중개사
		</label>
	</div>
	<div class="row">
		<input class="login_text" type="text" name="id" class="input" placeholder="ID" required >
	</div>
	<div class="row">
		<input class="login_text" type="password" name="pw"  class="input" placeholder="PASSWORD" required>
	</div>
	<%if(request.getParameter("error")!=null){ %>
	<div class="row center" style="color:red;">
		입력하신 정보가 맞지 않습니다
	</div>
	<%} %>
	<div class="row">
		<input class="login_input" type="submit" value="로그인" class="input">
	</div>
	<div class="row">
		<input class="login_input" type="button" value="회원가입" class="input" onClick="location.href='<%=request.getContextPath()%>/member/join.jsp'">
	</div>
</div> 
</form>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>
