<%@page import="houseSemi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	
	int board_no=Integer.parseInt(request.getParameter("board_no"));
	BoardDao boardDao = new BoardDao(); 
	BoardDto boardDto = boardDao.find(board_no);
%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../css/common.css">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script>
	$(function(){
		$(".cancle_btn").on('click', function(e){
			e.preventDefault();
			window.history.back();
		});
	})
</script>
<style>
	.input{
		width:700px;
		margin: 15px 0 0 0;
	}
	.board_tit,
	.board_header{
		margin: 15px 55px 0 0;
	}
	.type_radio{
		display: inline-block;
		width: 700px;
		margin: 15px 0 0 0;
	}
	input[name=board_header]+label{
		margin: 0 33px 0 0;
	}
	.board_content{
		width: 100%;
		height: 500px;
		resize: none;
		padding: 30px;
		margin: 30px 0 0 5px;
	}
	.board_btn.write_btn{
		margin: 30px 20px 0 0;
		font-weight: bold;
	}
	.outbox{
		padding: 0 0 40px 0;
	}
	.board_btn{
		width: 70px;
		height: 30px;
		font-size: 16px;
	}
</style>
</head>
<body>
	<div class="outbox border center" style="width:800px")>
		<div class="left">
			<h3>커뮤니티</h3>
			<hr>
		</div>
		<form action="<%=request.getContextPath()%>/board/edit.do" method="post">
			<input type="hidden" name="board_no" value="<%=boardDto.getBoard_no()%>">
			<label class="board_tit">제목</label><input type="text" name="board_title" class="input" value="<%=boardDto.getBoard_title()%>">
			<label class="board_header">구분</label>
			
			<div class="type_radio">
				<input type="radio" name="board_header" value="인테리어/DIY" id="interior"><label for="interior">인테리어/DIY</label>
				<input type="radio" name="board_header" value="전/월세 장터" id="market"><label for="market">전/월세 장터</label>
				<input type="radio" name="board_header" value="집수리/이사" id="repair"><label for="repair">집수리/이사</label>
				<input type="radio" name="board_header" value="기타" id="etc"><label for="etc">기타</label>
			</div>
			
			<div>
				<textarea class="board_content" name="board_content" ><%=boardDto.getBoard_content()%></textarea>
			</div>
			<input type="submit" value="수정" class="board_btn write_btn"><input class="board_btn cancle_btn" type="button" value="취소">
		</form>
	</div>
</body>
</html>