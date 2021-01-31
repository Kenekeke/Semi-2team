<%@page import="houseSemi.beans.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//session.setAttribute("check", 1);
	int board_no=Integer.parseInt(request.getParameter("board_no"));
	BoardDao boardDao = new BoardDao(); 
	BoardDto boardDto = boardDao.find(board_no);
	String board_header = boardDto.getBoard_header();
	boolean isAdmin = session.getAttribute("auth").equals("admin");

%>
<jsp:include page="/template/header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="../css/board.css">
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">

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
			<h1 class="nanumsquare">커뮤니티</h1>
			<hr>
		</div>
		<form action="boardEdit.do" method="post">
			<input type="hidden" name="board_no" value=<%=board_no%>>
			<div class="boardTitle nanumsquare">
				<div class="board_title board_title_in">제목</div><input type="text" name="board_title" class="boardinput" value="<%=boardDto.getBoard_title()%>" required>
			</div>
			<div class="boardHeader nanumsquare">
				<div class="board_header">구분</div>
				<div class="type_radio">
					<%if(isAdmin) {%>
					<input type="radio" name="board_header" value="공지사항" id="notice" <%if(board_header!=null&&board_header.equals("공지사항")){%>checked<%}%>><label for="notice">공지사항</label>
					<%} %>
					<input type="radio" name="board_header" value="인테리어/DIY" id="interior" <%if(board_header!=null&&board_header.equals("인테리어/DIY")){%>checked<%}%>><label for="interior">인테리어/DIY</label>
					<input type="radio" name="board_header" value="전/월세 장터" id="market" <%if(board_header!=null&&board_header.equals("전/월세 장터")){%>checked<%}%>><label for="market">전/월세 장터</label>
					<input type="radio" name="board_header" value="집수리/이사" id="repair" <%if(board_header!=null&&board_header.equals("집수리/이사")){%>checked<%}%>><label for="repair">집수리/이사</label>
					<input type="radio" name="board_header" value="기타" id="etc" <%if(board_header!=null&&board_header.equals("기타")){%>checked<%}%>><label for="etc" >기타</label>
				</div>
			</div>
			<div>
				<textarea class="board_content nanumsquare" name="board_content" required><%=boardDto.getBoard_content()%></textarea>
			</div>
			<div class="boardwriteBtn center">
				<input type="submit" value="등록" class="write_btn"><input class="cancle_btn" type="button" value="취소">
			</div>
		</form>
	</div>
</body>
</html>