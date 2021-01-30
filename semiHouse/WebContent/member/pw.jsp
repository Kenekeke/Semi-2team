<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>
<div class="all_wrapper">
<form action="pw.do" method="post">
	<div class="pw_wrapper">
	<div class="row">
		<div class="member_wrapper">
			<label>비밀번호</label>
		</div>
		<div class="member_info">
			<input type="password" name="member_pw" required class="input">
		</div>
		<div class="member_wrapper">
			<label>변경할 비밀번호</label>
		</div>	
		<div class="member_info">
			<input type="password" name="change_pw" required class="input">
		</div>	
		<div class="pw_button">
			<input class="button_pw" type="submit" value="비밀번호 변경" class="input">
		</div>
		<%if(request.getParameter("error") != null){ %>
		<div class="row" style="color:red;">
			현재 비밀번호가 일치하지 않습니다
		</div>
		<%} %>
	</div>
	</div>
</form>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>