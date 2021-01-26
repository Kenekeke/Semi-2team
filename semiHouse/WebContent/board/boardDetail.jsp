<%@page import="houseSemi.beans.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int board_no = Integer.parseInt(request.getParameter("board_no"));
	
	BoardDao boardDao = new BoardDao();
	boolean isMember = session.getAttribute("check") != null;
	boolean isBoardOwner;
	if(isMember){
		isBoardOwner = (int)session.getAttribute("check") == boardDao.find(board_no).getMember_no();;
	}
	else{
		isBoardOwner = false;
	}
	if(!isBoardOwner){
		if(session.getAttribute("read")!=null&&(int)session.getAttribute("read")==board_no){
			
		}
		else{
			boardDao.plusCount(board_no);
			session.setAttribute("read", board_no);
		}
	}
	
	BoardVO boardVO = boardDao.detail(board_no);
	ReplyDao replyDao = new ReplyDao();
	List<ReplyDto> replylist = replyDao.List(board_no);
	
	MemberDao memberDao = new MemberDao();
	SimpleDateFormat f = new SimpleDateFormat("yyyy.MM.dd H:mm");
	int n;
	try{
		n = Integer.parseInt(request.getParameter("n"));
		if(n<=0) throw new Exception();
	}
	catch(Exception e){
		n = 1;
	}
	int boardSize = 10;
	int endB = n * boardSize;
	int startB = endB - boardSize +1;
	
	int pageSize = 10;
	int startN = ((n-1)/pageSize)*pageSize +1;
	int endN = startN + pageSize - 1;
	int count = boardVO.getReplycount();
	int pagelast = (count + boardSize -1)/boardSize;
	if(pagelast<endN){
		endN = pagelast;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/board.css">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script>
	$(function(){
		$(".board_write_btn").click(function(){
			if(<%=isMember%>){
				location.href = "<%=request.getContextPath()%>/board/boardWrite.jsp";
			}
			else{
				location.href = "<%=request.getContextPath()%>/member/login.jsp";
			}
		});
		$(".board_edit_btn").click(function(){
			location.href = "<%=request.getContextPath()%>/board/boardEdit.jsp?board_no=<%=board_no%>";
		});
		$(".board_delete_btn").click(function(){
			var conf = confirm("게시글을 삭제하시겠습니까?");
			if(conf){
				location.href = "<%=request.getContextPath()%>/board/boardDelete.do?board_no=<%=board_no%>";
			}
		});
		$("#reply-form").submit(function(e){
			e.preventDefault();
			if(<%=isMember%>){
				this.submit();
			}
			else{
				var choice = confirm("먼저 로그인을 하셔야합니다.\n로그인페이지로 이동하시겠습니까?");
				if(choice){
					location.href = "<%=request.getContextPath()%>/member/login.jsp";
				}
			}
		});
		$(".reply-delete").click(function(e){
			var conf = confirm("댓글을 삭제하시겠습니까?");
			if(!conf){
				e.preventDefault();
			}
		});
	});
</script>
</head>
<body>
	<header></header>
    <div class="board-outbox">
        <div class="row">
            <input type="button" value="글쓰기" class="board_write_btn">
            <%if(isBoardOwner){%>
            <input type="button" value="수정" class="board_edit_btn">
            <input type="button" value="삭제" class="board_delete_btn">
            <%}%>
            <a href="boardList.jsp" style="float:right;">≡목록</a>
        </div>
        <div class="row">
            <div>[<%=boardVO.getBoard_header()%>]<%=boardVO.getBoard_title()%></div>
            <div class="board-detail-info">
            	<div><%=boardVO.getMember_nick()%></div>
            	<div class="board-cbt">
            		<div class="board-count">조회 <%=boardVO.getBoard_count()%></div>
	            	<div class="bar">|</div>
	            	<div class="board-time"><%=f.format(boardVO.getBoard_time())%></div>
            	</div>
            </div>
        </div>
        <div class="row board-content center">
        <%
        	String board_content = boardVO.getBoard_content();
        	board_content = board_content.replace("\r\n", "<br>");
        %>
            <%=board_content%>
        </div>
        <hr>
        <div class="row">
            <div>댓글 <%=boardVO.getReplycount()%>개</div>

            <form id="reply-form" action="replywrite.do" method="post">
                <div class="reply">
                	<input type="hidden" name="board_no" value=<%=board_no%>>
                	<%if(isMember){%>
                		<input type="hidden" name="member_no" value=<%=(int)session.getAttribute("check")%>>
                	<%} else{%>
                		<div>로그인 후 작성 가능합니다.</div>
                	<%}%>
                    <textarea class="reply-textarea" name="reply_content" required cols="100" rows="5" placeholder="함께 만들어가는 공간입니다. 댓글 작성 시 타인에 대한 배려를 해주세요."></textarea>
                    <input type="submit" value="등록">
                </div>
            </form>
            
            <%if(boardVO.getReplycount()>0){%>
            <%for(ReplyDto replyDto : replylist){ %>
            <%	
            boolean isReplyOwner;
            	if(isMember){
            		isReplyOwner = (int)session.getAttribute("check") == replyDto.getMember_no();
            	}
            	else{
            		isReplyOwner = false;
            	}
            %>
            	<hr>
            	<div><%=replyDto.getReply_content()%> <%if(isReplyOwner){%><a href="<%=request.getContextPath()%>/board/replyDelete.do?reply_no=<%=replyDto.getReply_no()%>&board_no=<%=board_no%>" class="reply-delete">Ⅹ</a><%}%></div>
            	<div>
            		<%=memberDao.find(replyDto.getMember_no()).getMember_nick()%>
            		<div><%=f.format(replyDto.getReply_time())%></div>
            	</div>
            <%}%>
            <%}%>
            
        </div>
        <div class="center boardlistPaging">
        	<ul class="pagination">
       			<li><a href="boardList.jsp?n=<%=startN-1%>">&lt;</a></li>
        		<%for(int i=startN; i<=endN; i++){ %>
        		<%if(n==i){ %><li class="active"><%}
        		else{%><li><%}%>
        			<a href="boardList.jsp?n=<%=i%>"><%=i%></a>
        			</li>
        		<%} %>
      			<%if(endN==pagelast){ %>
      				<li><a href="boardList.jsp?n=<%=endN%>">&gt;</a></li>
      			<%} else{%>
      				<li><a href="boardList.jsp?n=<%=endN+1%>">&gt;</a></li>
      			<%} %>
        	</ul>
        </div>
    </div>
</body>
</html>