<%@page import="houseSemi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../CSS/common.css">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script>
	$(function(){
		$(".cancle_btn").on('click', function(e){
			e.preventDefault();
			window.history.back();
		})
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
			<h3>부동산 이야기</h3>
			<hr>
		</div>
		<form action="#" method="post">
			<label class="board_tit">제목</label><input tpye="text" name="board_title" class="input">
			<label class="board_header">구분</label>
			
			<div class="type_radio">
				<input type="radio" name="board_header" value="interior" id="interior" checked><label for="interior">인테리어</label>
				<input type="radio" name="board_header" value="pre_sale" id="pre_sale"><label for="pre_sale">분양/청약</label>
				<input type="radio" name="board_header" value="monthly" id="monthly"><label for="monthly">전/월세</label>
				<input type="radio" name="board_header" value="repair" id="repair"><label for="repair" >인테리어</label>
				<input type="radio" name="board_header" value="rural"><label for="rural">전원주택</label>
				<input type="radio" name="board_header" value="etc"><label for="etc">기타</label>
			</div>
			
			<div>
				<textarea class="board_content" name="board_content"></textarea>
			</div>
			<input type="submit" value="등록" class="board_btn write_btn"><input class="board_btn cancle_btn" type="button" value="취소">
		</form>
	</div>
</body>
</html>