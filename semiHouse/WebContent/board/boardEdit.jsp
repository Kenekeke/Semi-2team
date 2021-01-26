<%@page import="houseSemi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//session.setAttribute("check", 1);
	int board_no=Integer.parseInt(request.getParameter("board_no"));
	BoardDao boardDao = new BoardDao(); 
	BoardDto boardDto = boardDao.find(board_no);
	String board_header = boardDto.getBoard_header();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/board.css">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script>
	$(function(){
		$(".cancle_btn").on('click', function(e){
			e.preventDefault();
			window.history.back();
		})
	})
</script>
</head>
<body>
	<div class="board-outbox">
		<div class="left">
			<h3>커뮤니티</h3>
			<hr>
		</div>
		<form action="boardEdit.do" method="post">
			<input type="hidden" name="board_no" value=<%=board_no%>>
			<div class="boardTitle">
				<div class="board_title">제목</div><input type="text" name="board_title" class="boardinput" value=<%=boardDto.getBoard_title()%>>
			</div>
			<div class="boardHeader">
				<div class="board_header">구분</div>
				<div class="type_radio">
					<input type="radio" name="board_header" value="인테리어/DIY" id="interior" <%if(board_header!=null&&board_header.equals("인테리어/DIY")){%>checked<%}%>><label for="interior">인테리어/DIY</label>
					<input type="radio" name="board_header" value="전/월세 장터" id="market" <%if(board_header!=null&&board_header.equals("전/월세 장터")){%>checked<%}%>><label for="market">전/월세 장터</label>
					<input type="radio" name="board_header" value="집수리/이사" id="repair" <%if(board_header!=null&&board_header.equals("집수리/이사")){%>checked<%}%>><label for="repair">집수리/이사</label>
					<input type="radio" name="board_header" value="기타" id="etc" <%if(board_header!=null&&board_header.equals("기타")){%>checked<%}%>><label for="etc" >기타</label>
				</div>
			</div>
			<div>
				<textarea class="board_content" name="board_content"><%=boardDto.getBoard_content()%></textarea>
			</div>
			<div class="boardwriteBtn center">
				<input type="submit" value="등록" class="write_btn"><input class="cancle_btn" type="button" value="취소">
			</div>
		</form>
	</div>
</body>
</html>