<%@page import="houseSemi.beans.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int member_no = (int)session.getAttribute("check");
	String auth = (String)session.getAttribute("auth");
	boolean isBroker = auth.equals("broker");
	
	MemberDao dao = new MemberDao();
	MemberDto dto = dao.find(member_no);
	
%>    
<jsp:include page="/template/header.jsp"></jsp:include>

<%if(isBroker){ %>
<div class="all_wrapper">
<form action="brokeredit.do" method="post">
<div class="brokerinfo_wrapper">
	<div class="row">
		<div class="member_wrapper">
			<label>닉네임</label>
		</div>
		<div class="member_info">
			<input type="text" name="member_nick" required class="input" 
					placeholder="한글 2~10자" value="<%=dto.getMember_nick()%>">
		</div>
		<div class="member_wrapper">
			<label>이메일</label>
		</div>
		<div class="member_info">
			<input type="text" name="member_email" required class="input" 
					placeholder="@ 포함하여 기재할 것" value="<%=dto.getMember_email()%>">
		</div>
		<div class="member_wrapper">
			<label>번호</label>
		</div>
		<div class="member_info">
			<input type="text" name="member_phone" required class="input" 
					placeholder="000-0000-0000" value="<%=dto.getMember_phone()%>">
		</div>
		<div class="member_wrapper">
				<label>비밀번호</label>
		</div>
		<div class="member_info">
				<input type="password" name="member_pw" required class="input">
		</div>	
			<%if(request.getParameter("error") != null){ %>
		<div class="row" style="color:red;">
				현재 비밀번호가 일치하지 않습니다
		</div>
			<%} %>
		<div class="editpw_button">
		<input type="submit" value="정보수정" class="input" style="padding:5px; width:100%;">
		</div>
	</div>
</div>
</form>
</div>
<%}else{ %>
<div class="all_wrapper">
<form action="edit.do" method="post">
	<div class="info_wrapper">
		<div class="row">
			<div class="member_wrapper">
				<label>닉네임</label>
			</div>
			<div class="member_info">
				<input type="text" name="member_nick" required class="input" 
						placeholder="한글 2~10자" value="<%=dto.getMember_nick()%>">
			</div>
			<div class="member_wrapper">
				<label>이메일</label>
			</div>
			<div class="member_info">
				<input type="text" name="member_email" required class="input" 
						placeholder="@ 포함하여 기재할 것" value="<%=dto.getMember_email()%>">
			</div>
			<div class="member_wrapper">
				<label>번호</label>
			</div>
			<div class="member_info">
				<input type="text" name="member_phone" required class="input" 
						placeholder="000-0000-0000" value="<%=dto.getMember_phone()%>">
			</div>
			<div class="member_wrapper">
				<label>비밀번호</label>
			</div>
			<div class="member_info">
				<input type="password" name="member_pw" required class="input">
			</div>	
			<%if(request.getParameter("error") != null){ %>
			<div class="row" style="color:red;">
				현재 비밀번호가 일치하지 않습니다
			</div>
			<%} %>
			<div class="editpw_button">
			<input type="submit" value="정보수정" class="input" style="padding:5px; width:100%;">
			</div>
		</div>	
	</div>
</form>
</div>
<%} %>
<jsp:include page="/template/footer.jsp"></jsp:include>