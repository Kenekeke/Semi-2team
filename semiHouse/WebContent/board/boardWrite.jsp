<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	boolean isMember = session.getAttribute("check") != null;
	boolean isAdmin = session.getAttribute("auth").equals("admin");
	
%>
<jsp:include page="/template/header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/board.css">
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">

<script>
	$(function(){
		$(".cancle_btn").on('click', function(e){
			e.preventDefault();
			window.history.back();
		})
	})
</script>
	<div class="board-outbox">
		<div class="left">
			<h1 class="nanumsquare">커뮤니티</h1>
			<hr>
		</div>
		<form action="boardWrite.do" method="post">
			<div class="boardTitle nanumsquare">
				<div class="board_title board_title_in">제목</div><input type="text" name="board_title" class="boardinput" required>
			</div>
			<div class="boardHeader nanumsquare">
				<div class="board_header">구분</div>
				<div class="type_radio">
					<%if(isAdmin) {%>
					<input type="radio" name="board_header" value="공지사항" id="notice" checked><label for="notice">공지사항</label>
					<%} %>
					<input type="radio" name="board_header" value="인테리어/DIY" id="interior" checked><label for="interior">인테리어/DIY</label>
					<input type="radio" name="board_header" value="전/월세 장터" id="market"><label for="market">전/월세 장터</label>
					<input type="radio" name="board_header" value="집수리/이사" id="repair"><label for="repair">집수리/이사</label>
					<input type="radio" name="board_header" value="기타" id="etc"><label for="etc" >기타</label>
				</div>
			</div>
			<div>
				<textarea class="board_content nanumsquare" name="board_content" required></textarea>
			</div>
			<div class="boardwriteBtn center">
				<input type="submit" value="등록" class="write_btn"><input class="cancle_btn" type="button" value="취소">
			</div>
		</form>
	</div>
<jsp:include page="/template/footer.jsp"></jsp:include>