<%@page import="houseSemi.beans.BrokerDto"%>
<%@page import="houseSemi.beans.BrokerDao"%>
<%@page import="houseSemi.beans.HouseVillatwoPhotoVO"%>
<%@page import="houseSemi.beans.HouseOfficePhotoVO"%>
<%@page import="houseSemi.beans.HouseOnePhotoVO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="houseSemi.util.JdbcUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="houseSemi.beans.OneDto"%>
<%@page import="java.util.*"%>
<%@page import="houseSemi.beans.HouseDao"%>
<%@page import="houseSemi.beans.HouseOnePhotoVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	int member_no = (int)request.getSession().getAttribute("check");
	BrokerDao brokerDao = new BrokerDao();
	BrokerDto brokerDto = brokerDao.find(member_no);
	int broker_no = brokerDto.getBroker_no();
	
	HouseDao houseDao = new HouseDao();
	List<HouseOnePhotoVO> houseOneList = houseDao.selectOneBroker(broker_no);
	List<HouseOfficePhotoVO> houseOfficeList = houseDao.selectOfficeBroker(broker_no);
	List<HouseVillatwoPhotoVO> houseVillatwoList = houseDao.selectVillatwoBroker(broker_no);
	int one_count = 0;
	int villatwo_count = 0;
	int office_count = 0;
	int house_no_save = 0;
%>

<link rel="stylesheet" href="<%=request.getContextPath() %>/css/room-list.css" type="text/css">
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_twelve@1.0/BinggraeMelona.woff">
<jsp:include page="/template/header.jsp"></jsp:include>
<script>
	$(function(){	     
		$(".agree-link").click(function(e){
			e.preventDefault();
 			
 			var confirm = window.confirm("해당 매물을 등록하시겠습니까?")
 			if(confirm){
 				$(location).attr("href", $(this).attr("href"));//기존에 가려고 하는 링크로 간다
 			}
		});
 		$(".cancel-link").click(function(e){
 			e.preventDefault();
 			
 			var confirm = window.confirm("해당 매물을 취소하시겠습니까?")
 			if(confirm){
 				$(location).attr("href", $(this).attr("href"));//기존에 가려고 하는 링크로 간다
 			}
		});
 		$("#one-all").change(function(){
		     var all = $(this).prop("checked");
           $(".one-check").prop("checked", all);
           
		});
		$("#villatwo-all").change(function(){
		     var all = $(this).prop("checked");
          $(".villatwo-check").prop("checked", all);
          
		});
		$("#office-all").change(function(){
		     var all = $(this).prop("checked");
          $(".office-check").prop("checked", all);
          
		});
 	});	
</script>

<div class="main-title">
    <h2>등록된 방 리스트</h2>
    <p>등록된 매물 중 광고가 가능한 매물일 경우 확인 후 매물 등록 완료를 눌러주세요</p>
</div>
<div class="container">
		<h3 class="table-title">원룸</h3>
		<table class="table-com">
			<thead>
				<tr class="table-header">
					<th><input type="checkbox" id="one-all"></th>
					<th width="10%">등록 번호</th>
					<th colspan="2" width="48%">주소</th>
					<th width="14%">등록일</th>
					<th width="14%">등록상태</th>
					<th width="15%" colspan="2"></th>
				</tr>
			</thead>
			<tbody>
				<%for (HouseOnePhotoVO oneVo : houseOneList){ %>
				<%if(oneVo.getHouse_type().equals("one")){ 
					one_count++;
					if(house_no_save != oneVo.getHouse_no()){
						house_no_save = oneVo.getHouse_no();
				%>
					<tr>
						<td><input type="checkbox" class="one-check"></td>
						<td class="house_no"><%=oneVo.getHouse_no() %></td>
						<td width="15%"><img src="D:/upload/kh42/<%=oneVo.getSave_name()%>" alt="대표사진" width="80px" height="80px"></td>
						<td class="left"><a href="<%=request.getContextPath()%>/member/broker_room-detail.jsp?house_no=<%=oneVo.getHouse_no()%>"><%=oneVo.getAddress()%> / <%=oneVo.getAddress2() %></a></td>
						<td><%=oneVo.getInsert_date()%></td>
							<%if(oneVo.getBroker_agree().equals("0")) {%>
							<td>등록 중</td>
							<%}else{ %>				
							<td>등록 완료</td>
							<%} %>
						<td width="8%">
							<a class="agree-link" href="<%=request.getContextPath()%>/member/update-agree.do?house_no=<%=oneVo.getHouse_no()%>">
								<%if(oneVo.getBroker_agree().equals("0")) {%>
									<input type="button" value="등록">
								<%}else{ %>				
									<input type="button" value="등록" disabled>
								<%} %>
							</a>
						</td>
						<td width="8%">
							<a class="cancel-link" href="<%=request.getContextPath()%>/member/update-cancel.do?house_no=<%=oneVo.getHouse_no()%>">
								<%if(oneVo.getBroker_agree().equals("0")) {%>
									<input type="button" value="취소" disabled>
								<%}else{ %>				
									<input type="button" value="취소">
								<%} %>
							</a>
						</td>
					</tr>
				<%		}
					}
				} 
				if(one_count == 0){%>
					<tr>
						<td colspan="8">등록된 매물이 없습니다</td>
					</tr>						
				<%} %>
			</tbody>
		</table>
		<br>
		<br>
		<h3 class="table-title">빌라/투룸</h3>
		<table class="table-com">
			<thead>
				<tr class="table-header">
					<th><input type="checkbox" id="villatwo-all"></th>				
					<th width="10%">등록 번호</th>
					<th colspan="2" width="48%">주소</th>
					<th width="14%">등록일</th>
					<th width="14%">등록상태</th>
					<th width="15%" colspan="2"></th>
				</tr>
			</thead>
			<tbody>
				<%for (HouseVillatwoPhotoVO villatwoVo : houseVillatwoList){ %>
				<%if(villatwoVo.getHouse_type().equals("villatwo")){ 
					villatwo_count++;
					if(house_no_save != villatwoVo.getHouse_no()){
						house_no_save = villatwoVo.getHouse_no();
				%>
					<tr>
						<td><input type="checkbox" class="villatwo-check"></td>
						<td class="house_no"><%=villatwoVo.getHouse_no() %></td>
						<td width="15%"><img src="D:/upload/kh42/<%=villatwoVo.getSave_name()%>" alt="대표사진" width="80px" height="80px"></td>
						<td class="left"><a href="<%=request.getContextPath()%>/member/broker_room-detail.jsp?house_no=<%=villatwoVo.getHouse_no()%>"><%=villatwoVo.getAddress()%> / <%=villatwoVo.getAddress2() %></a></td>
						<td><%=villatwoVo.getInsert_date()%></td>
							<%if(villatwoVo.getBroker_agree().equals("0")) {%>
							<td>등록 중</td>
							<%}else{ %>				
							<td>등록 완료</td>
							<%} %>
						<td width="8%">
							<a class="agree-link" href="<%=request.getContextPath()%>/member/update-agree.do?house_no=<%=villatwoVo.getHouse_no()%>">
								<%if(villatwoVo.getBroker_agree().equals("0")) {%>
									<input type="button" value="등록">
								<%}else{ %>				
									<input type="button" value="등록" disabled>
								<%} %>
							</a>
						</td>
						<td width="8%">
							<a class="cancel-link" href="<%=request.getContextPath()%>/member/update-cancel.do?house_no=<%=villatwoVo.getHouse_no()%>">
								<%if(villatwoVo.getBroker_agree().equals("0")) {%>
									<input type="button" value="취소" disabled>
								<%}else{ %>				
									<input type="button" value="취소">
								<%} %>
							</a>
						</td>
					</tr>
				<%}
					}%>
				<%} 
				if(villatwo_count == 0){%>
					<tr>
						<td colspan="8">등록된 매물이 없습니다</td>
					</tr>						
				<%}%>
			</tbody>
		</table>
		<br>
		<br>
		<h3 class="table-title">오피스텔</h3>
		<table class="table-com">
			<thead>
				<tr class="table-header">
					<th><input type="checkbox" id="office-all"></th>				
					<th width="10%">등록 번호</th>
					<th colspan="2" width="48%">주소</th>
					<th width="14%">등록일</th>
					<th width="14%">등록상태</th>
					<th width="15%" colspan="2"></th>
				</tr>
			</thead>
			<tbody>
				<%for (HouseOfficePhotoVO officeVo : houseOfficeList){ %>
				<%if(officeVo.getHouse_type().equals("office")){ 
					office_count++;
					if(house_no_save != officeVo.getHouse_no()){
						house_no_save = officeVo.getHouse_no();
				%>
					<tr>
						<td><input type="checkbox" class="office-check"></td>
						<td class="house_no"><%=officeVo.getHouse_no() %></td>
						<td width="15%"><img src="D:/upload/kh42/<%=officeVo.getSave_name()%>" alt="대표사진" width="80px" height="80px"></td>
						<td class="left"><a href="<%=request.getContextPath()%>/member/broker_room-detail.jsp?house_no=<%=officeVo.getHouse_no()%>"><%=officeVo.getAddress()%> / <%=officeVo.getAddress2() %></a></td>
						<td><%=officeVo.getInsert_date()%></td>
							<%if(officeVo.getBroker_agree().equals("0")) {%>
							<td>등록 중</td>
							<%}else{ %>				
							<td>등록 완료</td>
							<%} %>
						<td width="8%">
							<a class="agree-link" href="<%=request.getContextPath()%>/member/update-agree.do?house_no=<%=officeVo.getHouse_no()%>">
								<%if(officeVo.getBroker_agree().equals("0")) {%>
									<input type="button" value="등록">
								<%}else{ %>				
									<input type="button" value="등록" disabled>
								<%} %>
							</a>
						</td>
						<td width="8%">
							<a class="cancel-link" href="<%=request.getContextPath()%>/member/update-cancel.do?house_no=<%=officeVo.getHouse_no()%>">
								<%if(officeVo.getBroker_agree().equals("0")) {%>
									<input type="button" value="취소" disabled>
								<%}else{ %>				
									<input type="button" value="취소">
								<%} %>
							</a>
						</td>
					</tr>
				<%}
					}%>
				<%} 
				if(office_count == 0){%>
					<tr>
						<td colspan="8">등록된 매물이 없습니다</td>
					</tr>						
				<%}%>
			</tbody>
		</table>
	</div>    
    



<jsp:include page="/template/footer.jsp"></jsp:include>
    