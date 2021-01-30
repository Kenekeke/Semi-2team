<%@page import="houseSemi.beans.*"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	session.removeAttribute("read"); // 홈화면.jsp에도 추가!
	boolean isMember = session.getAttribute("check") != null;
	String board_header = request.getParameter("board_header");
	boolean isHeader = board_header != null;
	int n;
	try{
		n = Integer.parseInt(request.getParameter("n"));
		if(n<=0) throw new Exception();
	}
	catch(Exception e){
		n = 1;
	}
	BoardDao boardDao = new BoardDao();
	List<BoardVO> boardlist;
	List<BoardVO> noticelist = boardDao.List("공지사항", 1, 3);
	int boardSize;
	if(isHeader){
		boardSize = 15;
	}
	else{
		boardSize = 12;
	}
	int endB = n * boardSize;
	int startB = endB - boardSize +1;
	
	int pageSize = 10;
	int startN = ((n-1)/pageSize)*pageSize +1;
	int endN = startN + pageSize - 1;
	
	String type = request.getParameter("type");
	String key = request.getParameter("key");
	boolean isSearch = type != null && key != null;
	
	if(isSearch){
		if(isHeader){
			boardlist = boardDao.List(board_header, type, key, startB, endB);
		}
		else{
			boardlist = boardDao.List(type, key, startB, endB);
		}
	}
	else{
		if(isHeader){
			boardlist = boardDao.List(board_header, startB, endB);
		}
		else{
			boardlist = boardDao.List(startB, endB);
		}
	}
	
	int count;
	if(isSearch){
		if(isHeader){
			count = boardDao.count(board_header, type, key);
		}
		else{
			count = boardDao.count(type, key);
		}
	}
	else{
		if(isHeader){
			count = boardDao.count(board_header);
		}
		else{
			count = boardDao.count();
		}
	}
	int pagelast = (count + boardSize -1)/boardSize;
	if(pagelast<=endN){
		endN = pagelast;
	}
	
%>
<jsp:include page="/template/header.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/board.css">
<link rel="stylesheet" type="text/css" href="https://cdn.rawgit.com/moonspam/NanumSquare/master/nanumsquare.css">
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
		$("#board-total").on("input", function(){
			if($(this).prop("checked")){
				location.href = "<%=request.getContextPath()%>/board/boardList.jsp";
				$(this).prop("checked",true);
			}
		});
		$("#board-notice").on("input", function(){
			if($(this).prop("checked")){
				var a = "공지사항";
				location.href = "<%=request.getContextPath()%>/board/boardList.jsp?board_header="+a;
				$(this).prop("checked",true);
			}
		});
		$("#board-inte").on("input", function(){
			if($(this).prop("checked")){
				var a = "인테리어/DIY";
				location.href = "<%=request.getContextPath()%>/board/boardList.jsp?board_header="+a;
				$(this).prop("checked",true);
			}
		});
		$("#board-market").on("input", function(){
			if($(this).prop("checked")){
				var a = "전/월세 장터";
				location.href = "<%=request.getContextPath()%>/board/boardList.jsp?board_header="+a;
				$(this).prop("checked",true);
			}
		});
		$("#board-move").on("input", function(){
			if($(this).prop("checked")){
				var a = "집수리/이사";
				location.href = "<%=request.getContextPath()%>/board/boardList.jsp?board_header="+a;
				$(this).prop("checked",true);
			}
		});
		$("#board-etc").on("input", function(){
			if($(this).prop("checked")){
				var a = "기타";
				location.href = "<%=request.getContextPath()%>/board/boardList.jsp?board_header="+a;
				$(this).prop("checked",true);
			}
		});
	});
</script>
	<div class="board-outbox nanumsquare">
        <div class="rightwritebtn">
        	<input type="button" value="글쓰기" class="board_write_btn boardbtnc">
        </div>
        <div class="type_radio">
        	<input type="radio" name="board_header_check" id="board-total" value="전체" <%if(board_header==null){%>checked<%}%>>
        	<label for="board-total">전체</label>
        	<input type="radio" name="board_header_check" id="board-notice" value="공지사항" <%if(board_header!=null&&board_header.equals("공지사항")){%>checked<%}%>>
        	<label for="board-notice">공지사항</label>
        	<input type="radio" name="board_header_check" id="board-inte" value="인테리어/DIY" <%if(board_header!=null&&board_header.equals("인테리어/DIY")){%>checked<%}%>>
        	<label for="board-inte">인테리어/DIY</label>
        	<input type="radio" name="board_header_check" id="board-market" value="전/월세 장터" <%if(board_header!=null&&board_header.equals("전/월세 장터")){%>checked<%}%>>
        	<label for="board-market">전/월세 장터</label>
        	<input type="radio" name="board_header_check" id="board-move" value="집수리/이사" <%if(board_header!=null&&board_header.equals("집수리/이사")){%>checked<%}%>>
        	<label for="board-move">집수리/이사</label>
        	<input type="radio" name="board_header_check" id="board-etc" value="기타" <%if(board_header!=null&&board_header.equals("기타")){%>checked<%}%>>
        	<label for="board-etc">기타</label>
        </div>
        <div>
            <table class="table-box center">
                <thead>
                    <tr style="height:43px;">
                        <th width="17%">구분</th>
                        <th width="45%">제목</th>
                        <th width="13%">글쓴이</th>
                        <th width="12%">조회</th>
                        <th width="13%">등록일</th>
                    </tr>
                </thead>
                <tbody>
                <%if(!isHeader){
                for(BoardVO noticevo : noticelist){%>
                	<tr class="listItem noticeItem">
                        <td class="headerbold headerboardlist"><%=noticevo.getBoard_header()%></td>
                        <td><a class="boardlisttitle" href="boardDetail.jsp?board_no=<%=noticevo.getBoard_no()%>"><%=noticevo.getBoard_title()%> <%if(noticevo.getReplycount()>0){%>[<%=noticevo.getReplycount()%>]<%}%></a></td>
                        <td><%=noticevo.getMember_nick()%></td>
                        <td><%=noticevo.getBoard_count()%></td>
                        <td style="font-size:13px;"><%=noticevo.getBoard_time()%></td>
                    </tr>
                <%}
                }%>
				<%for(BoardVO boardVO : boardlist){%>
                    <tr class="listItem">
                        <td class="headerbold"><%=boardVO.getBoard_header()%></td>
                        <td><a class="boardlisttitle" href="boardDetail.jsp?board_no=<%=boardVO.getBoard_no()%>"><%=boardVO.getBoard_title()%> <%if(boardVO.getReplycount()>0){%>[<%=boardVO.getReplycount()%>]<%}%></a></td>
                        <td><%=boardVO.getMember_nick()%></td>
                        <td><%=boardVO.getBoard_count()%></td>
                        <td style="font-size:15px;"><%=boardVO.getBoard_time()%></td>
                    </tr>
                <%}%>
                </tbody>
            </table>
        </div>
        <div class="center boardlistPaging">
        	<ul class="paginationb">
        		<%if(isSearch){ %>
        		<%if(isHeader){ %>
        			<%if(startN!=1){%>
        			<li><a href="boardList.jsp?n=<%=startN-1%>&type=<%=type%>&key=<%=key%>&board_header=<%=board_header%>">&lt;</a></li>
        			<%} %>
        		<%} else{%>
        			<%if(startN!=1){%>
        			<li><a href="boardList.jsp?n=<%=startN-1%>&type=<%=type%>&key=<%=key%>">&lt;</a></li>
        			<%} %>
        		<%} 
        		} else{
       			if(isHeader){%>
        			<%if(startN!=1){%>
       				<li><a href="boardList.jsp?n=<%=startN-1%>&board_header=<%=board_header%>">&lt;</a></li>
       				<%} %>
       			<%} else{%>
        			<%if(startN!=1){%>
       				<li><a href="boardList.jsp?n=<%=startN-1%>">&lt;</a></li>
       				<%} %>
       			<%} 
       			}%>
        		
        		<%for(int i=startN; i<=endN; i++){ %>
        		<%if(n==i){ %><li class="active"><%}
        		else{%><li><%}%>
        			<%if(isSearch){ %>
        			<%if(isHeader){ %>
        				<a href="boardList.jsp?n=<%=i%>&type=<%=type%>&key=<%=key%>&board_header=<%=board_header%>"><%=i%></a>
        			<%} else{%>
        				<a href="boardList.jsp?n=<%=i%>&type=<%=type%>&key=<%=key%>"><%=i%></a>
        			<%}%>
        			<%} else{%>
        			<%if(isHeader){ %>
        				<a href="boardList.jsp?n=<%=i%>&board_header=<%=board_header%>"><%=i%></a>
        			<%} else{%>
        				<a href="boardList.jsp?n=<%=i%>"><%=i%></a>
        			<%}%>
        			<%}%>
        			</li>
        		<%} %>
        		<%if(isSearch){ %>
        		<%if(isHeader){ %>
        			<%if(endN!=pagelast){%>
        				<li><a href="boardList.jsp?n=<%=endN+1%>&type=<%=type%>&key=<%=key%>&board_header=<%=board_header%>">&gt;</a></li>
        			<%} %>
        		<%} else{%>
        			<%if(endN!=pagelast){%>
        				<li><a href="boardList.jsp?n=<%=endN+1%>&type=<%=type%>&key=<%=key%>">&gt;</a></li>
        			<%} %>
        		<%} 
        		} else{%>
        		<%if(isHeader){ %>
        			<%if(endN!=pagelast){%>
        				<li><a href="boardList.jsp?n=<%=endN+1%>&board_header=<%=board_header%>">&gt;</a></li>
        			<%} %>
        		<%} else{%>
        			<%if(endN!=pagelast){%>
        				<li><a href="boardList.jsp?n=<%=endN+1%>">&gt;</a></li>
        			<%} %>
        		<%}
        		}%>
        	</ul>
        </div>
        <div class="boardlist-searchbox">
        	<form action="boardList.jsp" method="post">
        		<select name="type" class="board_search_type">
        			<option value="board_title" <%if(type!=null&&type.equals("board_title")){%>selected<%}%>>제목</option>
        			<option value="board_title_content" <%if(type!=null&&type.equals("board_title_content")){%>selected<%}%>>제목+본문</option>
        			<option value="member_nick" <%if(type!=null&&type.equals("member_nick")){%>selected<%}%>>글쓴이</option>
        		</select>
        		<%if(key!=null){ %>
        			<input type="text" name="key" class="board_search_key" required value=<%=key%>>
        		<%} else{%>
        			<input type="text" name="key" class="board_search_key" required>
        		<%} %>
        		<%if(isHeader){%>
        			<input type="hidden" name="board_header" value=<%=board_header%>>
        		<%}%>
        		<input type="submit" value="검색" class="board-searchbtn-typekey">
        	</form>
        </div>
    </div>
<jsp:include page="/template/footer.jsp"></jsp:include>