<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="houseSemi.util.JdbcUtil"%>
<%@page import="java.sql.Connection"%>
<%@page import="houseSemi.beans.OneDto"%>
<%@page import="houseSemi.beans.HouseDto"%>
<%@page import="java.util.*"%>
<%@page import="houseSemi.beans.HouseDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	int member_no = (int)request.getSession().getAttribute("check");
	HouseDao houseDao = new HouseDao();
	List<HouseDto> houseList = houseDao.select(member_no);
	int one_count = 0;
	int villatwo_count = 0;
	int office_count = 0;
%>


<jsp:include page="/template/header.jsp"></jsp:include>
<script>
	$(function(){	     
		$(".update-link").click(function(e){
			e.preventDefault();
 			
 			var confirm = window.confirm("해당 매물을 수정하시겠습니까?")
 			if(confirm){
 				$(location).attr("href", $(this).attr("href"));//기존에 가려고 하는 링크로 간다
 			}
		});
 		$(".delete-link").click(function(e){
 			e.preventDefault();
 			
 			var confirm = window.confirm("해당 매물을 삭제하시겠습니까?")
 			if(confirm){
 				$(location).attr("href", $(this).attr("href"));//기존에 가려고 하는 링크로 간다
 			}
		});
 	});	
</script>
    <h4>등록 매물 리스트</h4>
	<div>
		<div class="row right">
		</div>
		<div class="row">
			<table class="table table-border" border="1" style="width: 1000px;">
				<thead>
					<tr>
						<td class="left" colspan="8">원룸</td>
					</tr>
					<tr>
						<th width="10%">등록 번호</th>
						<th colspan="3" width="45%">주소</th>
						<th width="15%">등록일</th>
						<th colspan="3">등록상태</th>
					</tr>
				</thead>
				<tbody>
					<%for (HouseDto houseDto : houseList){ %>
					<%if(houseDto.getHouse_type().equals("one")){ 
						one_count++;
					%>
						<tr>
							<td class="house_no"><%=houseDto.getHouse_no() %></td>
							<td><%=houseDto.getHouse_type() %></td>
							<td width="15%"><a href="#">대표사진</a></td>
							<td class="left"><a href="#">주소</a></td>
							<td><%=houseDto.getInsert_date()%></td>
							<td></td>				
							<td width="8%">
								<a class="update-link" href="<%=request.getContextPath()%>/member/update-one.jsp?house_no=<%=houseDto.getHouse_no()%>">
									<button class="update-btn">수정</button>
								</a>
							</td>
							<td width="8%">
								<a class="delete-link" href="<%=request.getContextPath()%>/member/delete-room.do?house_no=<%=houseDto.getHouse_no()%>">
									<button>삭제</button>
								</a>
							</td>
						</tr>
					<%}%>
					<%}if(one_count == 0){%>
						<tr>
							<td colspan="8">등록된 매물이 없습니다</td>
						</tr>						
					<%} %>
				</tbody>
			</table>
			<table class="table table-border" border="1" style="width: 1000px;">
				<thead>
					<tr>
						<td class="left" colspan="8">빌라/투룸</td>
					</tr>
					<tr>
						<th width="10%">등록 번호</th>
						<th colspan="3" width="45%">주소</th>
						<th width="15%">등록일</th>
						<th colspan="3">등록상태</th>
					</tr>
				</thead>
				<tbody>
					<%for (HouseDto houseDto : houseList){ %>
					<%if(houseDto.getHouse_type().equals("villatwo")){ 
						villatwo_count++;
					%>
						<tr>
							<td class="house_no"><%=houseDto.getHouse_no() %></td>
							<td><%=houseDto.getHouse_type() %></td>
							<td width="15%"><a href="#">대표사진</a></td>
							<td class="left"><a href="#">주소</a></td>
							<td><%=houseDto.getInsert_date()%></td>
							<td></td>				
							<td width="8%">
								<a class="update-link" href="<%=request.getContextPath()%>/member/update-villatwo.jsp?house_no=<%=houseDto.getHouse_no()%>">
									<button class="update-btn">수정</button>
								</a>
							</td>
							<td width="8%">
								<a class="delete-link" href="<%=request.getContextPath()%>/member/delete-room.do?house_no=<%=houseDto.getHouse_no()%>">
									<button>삭제</button>
								</a>
							</td>
						</tr>
					<%}%>
					<%}if(villatwo_count == 0){%>
						<tr>
							<td colspan="8">등록된 매물이 없습니다</td>
						</tr>						
					<%} %>
				</tbody>
			</table>
			<table class="table table-border" border="1" style="width: 1000px;">
				<thead>
					<tr>
						<td class="left" colspan="8">오피스텔</td>
					</tr>
					<tr>
						<th width="10%">등록 번호</th>
						<th colspan="3" width="45%">주소</th>
						<th width="15%">등록일</th>
						<th colspan="3">등록상태</th>
					</tr>
				</thead>
				<tbody>
					<%for (HouseDto houseDto : houseList){ %>
					<%if(houseDto.getHouse_type().equals("office")){ 
						office_count++;
					%>
						<tr>
							<td class="house_no"><%=houseDto.getHouse_no() %></td>
							<td><%=houseDto.getHouse_type() %></td>
							<td width="15%"><a href="#">대표사진</a></td>
							<td class="left"><a href="#">주소</a></td>
							<td><%=houseDto.getInsert_date()%></td>
							<td></td>				
							<td width="8%">
								<a class="update-link" href="<%=request.getContextPath()%>/member/update-office.jsp?house_no=<%=houseDto.getHouse_no()%>">
									<button class="update-btn">수정</button>
								</a>
							</td>
							<td width="8%">
								<a class="delete-link" href="<%=request.getContextPath()%>/member/delete-room.do?house_no=<%=houseDto.getHouse_no()%>">
									<button>삭제</button>
								</a>
							</td>
						</tr>
					<%}%>
					<%}if(office_count == 0){%>
						<tr>
							<td colspan="8">등록된 매물이 없습니다</td>
						</tr>						
					<%} %>
				</tbody>
			</table>
		</div>
	</div>    
    



<jsp:include page="/template/footer.jsp"></jsp:include>
    