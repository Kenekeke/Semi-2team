<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="houseSemi.beans.*"%>



<jsp:include page="/template/header.jsp"></jsp:include>

<%
	int member_no = (int)session.getAttribute("check");
	String auth = (String)session.getAttribute("auth");
	boolean isBroker = auth.equals("broker");

	MemberDao dao = new MemberDao();
	MemberDto dto = dao.find(member_no);
	
	BrokerDao brokerdao = new BrokerDao(); 
	BrokerMemberVO vo = brokerdao.select(member_no);
	
%>
<script>
	$(function(){
		$(".delete-link").click(function(e){
			e.preventDefault();
			var choice = window.confirm("진짜 떠나시려는건가요???");
			if(choice){
				location.href = $(this).attr("href");
			}
		});
	});
</script>
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
		<div class="left_button">
			<a href="pw.jsp" style="color:white" >비밀번호 변경하기</a>
		</div>
		<div class="right_button">
			<a href="editpw.jsp" style="color:white">정보 변경하기</a>
		</div>
		<div class="last_button">
		최후의 보루, 다음에 만나요 :)
			<a href="delete.do" class="delete_link">회원 탈퇴하기></a>
		</div>
	</div>  
	</div> 
</div>
<%}else{ %>
<div class="all_wrapper">
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
			<label>
				<%if(dto.is("member"))%>일반회원
				<%if(dto.is("broker"))%>중개인
				<%if(dto.is("admin"))%>관리자 
			</label>
		</div>
		<div class="left_button">
			<a href="pw.jsp" style="color:white" >비밀번호 변경하기</a>
		</div>
		<div class="right_button">
			<a href="editpw.jsp" style="color:white">정보 변경하기</a>
		</div>
		<div class="last_button">
		최후의 보루, 다음에 만나요 :)
			<a href="delete.do" class="delete_link">회원 탈퇴하기></a>
		</div>
	</div> 
	</div> 
</div>
<%} %>
<jsp:include page="/template/footer.jsp"></jsp:include>


