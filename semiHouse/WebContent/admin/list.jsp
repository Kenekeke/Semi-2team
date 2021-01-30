<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="houseSemi.beans.*"%>
<%@ page import="java.util.*" %>

<jsp:include page="/template/header.jsp"></jsp:include>

<%
	request.setCharacterEncoding("UTF-8");

	int boardSize = 15;
	int p;
	try{
		p = Integer.parseInt(request.getParameter("p"));
		if(p <= 0) throw new Exception();
	}
	catch(Exception e){
		p = 1;
	}
	
	int endRow = p * boardSize;
	int startRow = endRow - boardSize + 1;
	
	String type = request.getParameter("type");
	String key = request.getParameter("key");
	
	boolean isSearch = type != null && key != null;
	MemberDao dao = new MemberDao();
	List<MemberDto> list;
	
	 if(isSearch){
		list = dao.select(type, key, startRow, endRow);  
	} 
	else{	
		list = dao.select(startRow, endRow);
	} 
	
	int blockSize = 10;

	int startBlock = (p-1) / blockSize * blockSize + 1;
	int endBlock = startBlock + blockSize - 1;
	
	int count; 
	if(isSearch){
		count = dao.getCount(type, key); 
	}
	else{
		count = dao.getCount();
	}

	int pageSize = (count + boardSize - 1) / boardSize;
	
	if(endBlock > pageSize){
		endBlock = pageSize;
	}
%>
<div class="all_wrapper">
<div class="adminlist_wrapper">
	<div class="row center">
		<h2>회원 검색</h2>
	</div>
	<form action="list.jsp" method="get">
		<div class="row center">
			<select name="type" class="input input-inline" required>
				<option value="">분류 선택</option>
				<option value="member_no" <%if(type!=null&&type.equals("member_no")){%>selected<%}%>>번호</option>
				<option value="member_id" <%if(type!=null&&type.equals("member_id")){%>selected<%}%>>아이디</option>
				<option value="member_nick" <%if(type!=null&&type.equals("member_nick")){%>selected<%}%>>닉네임</option>
				<option value="member_auth" <%if(type!=null&&type.equals("member_auth")){%>selected<%}%>>등급</option>
			</select>
			<%if(isSearch){ %>
			<input type="text" name="key" placeholder="검색어 입력" required class="input input-inline" value="<%=key%>">
			<%}else{ %>
			<input type="text" name="key" placeholder="검색어 입력" required class="input input-inline">
			<%} %>
			<input type="submit" value="검색" class="input input-inline">
		</div>
	</form>

	<%if(list == null){ %>
	<div class="row center">
		<h4>누굴 찾을텐가..?</h4>
	</div>
	<%} else if (list.isEmpty()){ %>
	<div class="row center">
		<h4>아무도 없는걸요..?</h4>
	</div>
	<%} else { %>
	<div class="row">
		<table class="table table-border">
			<thead>
				<tr>
					<th>회원번호</th>
					<th>아이디</th>
					<th>닉네임</th>
					<th>등급</th>
					<th>관리메뉴</th>
				</tr>
			</thead> 
			<tbody>
				<%for(MemberDto dto : list){ %>
				<tr>
					<td><%=dto.getMember_no()%></td>
					<td><a href="detail.jsp?member_no=<%=dto.getMember_no()%>&member_auth=<%=dto.getMember_auth()%>"><%=dto.getMember_id()%></a></td>
					<td><%=dto.getMember_nick()%></td>
					<%if(dto.is("member"))%><td>일반회원</td>
				 	<%if(dto.is("broker"))%><td>중개인</td>
				 	<%if(dto.is("admin"))%><td>관리자</td>
				</tr>
				<%} %>
			</tbody>
		</table>
	</div>
	<div class="row">
		<ul class="pagination">
			<%if(isSearch){ %>
				<li><a href="list.jsp?p=<%=startBlock-1%>&type=<%=type%>&key=<%=key%>">&lt;</a></li>
			<%}else{ %>
				<li><a href="list.jsp?p=<%=startBlock-1%>">&lt;</a></li>
			<%} %>
			
			<%for(int i=startBlock; i<=endBlock; i++){ %>
				<%if(i == p){ %>
				<li class="active">
				<%}else{ %>
				<li>
				<%} %>
				<%if(isSearch){ %>
					<a href="list.jsp?p=<%=i%>&type=<%=type%>&key=<%=key%>"><%=i%></a>
				<%}else{ %>
					<a href="list.jsp?p=<%=i%>"><%=i%></a>
				<%} %>
				</li>
			<%} %>
			
			<%if(isSearch){ %>
				<li><a href="list.jsp?p=<%=endBlock+1%>&type=<%=type%>&key=<%=key%>">&gt;</a></li>
			<%}else{ %>
				<li><a href="list.jsp?p=<%=endBlock+1%>">&gt;</a></li>
			<%} %>
		</ul>
	</div>
	<%} %>
</div>
</div>

