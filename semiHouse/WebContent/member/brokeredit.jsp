<%@page import="houseSemi.beans.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int member_no = (int)session.getAttribute("check");
	
	BrokerDao brokerdao = new BrokerDao(); 
	BrokerMemberVO vo = brokerdao.select(member_no);


%>    
<jsp:include page="/template/header.jsp"></jsp:include>

<div class="all_wrapper">
<form action="brokeredit2.do" method="post">
	<div class="info_wrapper">
		<div class="row">
			<div class="member_wrapper">
				<label>중개사무소 이름</label>
			</div>
			<div class="member_info">
				<input type="text" name="broker_name" required class="input" 
						placeholder="" value="<%=vo.getBroker_name()%>">
			</div>
			<div class="member_wrapper">
				<label>주소</label>
			</div>
			<div class="member_info">
				<input type="text" name="broker_address" required class="input" 
						placeholder="" value="<%=vo.getBroker_address()%>">
			</div>
			<div class="member_wrapper">
				<label>나머지주소</label>
			</div>
			<div class="member_info">
				<input type="text" name="broker_address2" required class="input" 
						placeholder="" value="<%=vo.getBroker_address2()%>">
			</div>
			<div class="member_wrapper">
				<label>중개사무소 번호</label>
			</div>
			<div class="member_info">
				<input type="text" name="broker_landline" required class="input" 
						placeholder="" value="<%=vo.getBroker_landline()%>">
			</div>
			
			<div class="editpw_button">
			<input type="submit" value="정보수정" class="input" style="padding:5px; width:100%;">
			</div>
		</div>	
	</div>
</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>