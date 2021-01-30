<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="houseSemi.beans.*"%>

<%
	int member_no = Integer.parseInt(request.getParameter("member_no"));
	String auth = request.getParameter("member_auth");
	boolean isBroker = auth.equals("broker");
	
	MemberDao dao = new MemberDao();
	MemberDto dto = dao.find(member_no); 
	 
	BrokerDao brokerdao = new BrokerDao(); 
	BrokerMemberVO vo = brokerdao.select(member_no);
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<%if(isBroker){ %>
<div class="all_wrapper">
<div class="brokerinfo_wrapper">
	<div class="row"> 
		<div class="member_wrapper">
			<label>아이디</label>
		</div>
		<div class="member_info">
			<label><%=vo.getMember_id()%></label>
		</div>
		<div class="member_wrapper">
			<label>이메일</label>
		</div>
		<div class="member_info">
			<label><%=vo.getMember_email()%></label>
		</div>
		<div class="member_wrapper">
			<label>번호</label>
		</div>
		<div class="member_info">
			<label><%=vo.getMember_phone()%></label>
		</div>
		<div class="member_wrapper">
			<label>닉네임</label>
		</div>
		<div class="member_info">
			<label><%=vo.getMember_nick()%></label>
		</div>
		<div class="member_wrapper">
			<label>주소</label>
		</div>
		<div class="member_info">
			<label><%=vo.getBroker_address()%></label>
		</div>
		<div class="member_wrapper">
			<label>나머지 주소</label>
		</div>
		<div class="member_info">
			<label><%=vo.getBroker_address2()%></label>
		</div>
		<div class="member_wrapper">
			<label>중개소이름</label>
		</div>
		<div class="member_info">
			<label><%=vo.getBroker_name()%></label>
		</div>
		<div class="member_wrapper">
			<label>중개소번호</label>
		</div>
		<div class="member_info">
			<label><%=vo.getBroker_landline()%></label>
		</div>	
		<div class="member_wrapper">
			<label>권한</label>
		</div>
		<div class="member_info">
			<label><%=vo.getMember_auth()%></label>
		</div>
		<input type="hidden" name="member_no" value="<%=vo.getMember_no()%>">
		<a href="list.jsp?type=member_auth&key=broker">목록</a>
		<a href="delete.do?member_no=<%=vo.getMember_no()%>">탈퇴</a>
		<a href="pw.do?member_no=<%=vo.getMember_no()%>">임시</a>
	</div>  
	</div> 
</div>
<%}else{ %>
<div class="all_wrapper">
<form action="edit.do" method="post">
<div class="info_wrapper">
	<div class="row">
		<div class="member_wrapper">
			<label>아이디</label>
		</div>
		<div class="member_info">
			<label><%=dto.getMember_id()%></label>
		</div>
		<div class="member_wrapper">
			<label>닉네임</label>
		</div>
		<div class="member_info">
			<label><%=dto.getMember_nick()%></label>
		</div>
		<div class="member_wrapper">
			<label>이메일</label>
		</div>
		<div class="member_info">
			<label><%=dto.getMember_email()%></label>
		</div>
		<div class="member_wrapper">
			<label>번호</label>
		</div>
		<div class="member_info">
			<label><%=dto.getMember_phone()%></label>
		</div>		
		<div class="member_wrapper">
			<label>권한</label>
		</div>
		<div class="member_info"> 
			<select name="member_auth" class="input">
				<option selected value="<%=dto.getMember_auth()%>">
				 <%if(dto.is("member"))%>일반회원</option>
				 <%if(dto.is("admin"))%>관리자</option> 
				<option value="member">일반회원</option>
				<option value="admin">관리자</option>
			</select>
			</div>
			<input type="hidden" name="member_no" value="<%=dto.getMember_no()%>">
		<input type="submit" value="수정">
		<a href="list.jsp">목록</a>
		<a href="delete.do?member_no=<%=dto.getMember_no()%>">탈퇴</a>
		<a href="pw.do?member_no=<%=dto.getMember_no()%>">임시</a>
	</div> 
	</div> 
</form>
</div>
<%} %>

