<%@page import="houseSemi.beans.*"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	//session.setAttribute("check", 1);
	boolean isMember = session.getAttribute("check") != null;
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
	
	String type = request.getParameter("type");
	String key = request.getParameter("key");
	boolean isSearch = type != null && key != null;
	
	String board_header = request.getParameter("board_header");
	boolean isHeader = board_header != null;
	
	BoardDao boardDao = new BoardDao();
	List<BoardVO> boardlist;
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
				location.href = "<%=request.getContextPath()%>/semi-project/boardWrite.jsp";
			}
			else{
				location.href = "<%=request.getContextPath()%>/semi-project/login.jsp";
			}
		});
		$("#board-total").on("input", function(){
			if($(this).prop("checked")){
				location.href = "<%=request.getContextPath()%>/semi-project/boardList.jsp";
				$(this).prop("checked",true)
			}
		});
		$("#board-inte").on("input", function(){
			if($(this).prop("checked")){
				var a = "인테리어/DIY";
				location.href = "<%=request.getContextPath()%>/semi-project/boardList.jsp?board_header="+a;
				$(this).prop("checked",true)
			}
		});
		$("#board-market").on("input", function(){
			if($(this).prop("checked")){
				var a = "전/월세 장터";
				location.href = "<%=request.getContextPath()%>/semi-project/boardList.jsp?board_header="+a;
				$(this).prop("checked",true)
			}
		});
		$("#board-move").on("input", function(){
			if($(this).prop("checked")){
				var a = "집수리/이사";
				location.href = "<%=request.getContextPath()%>/semi-project/boardList.jsp?board_header="+a;
				$(this).prop("checked",true)
			}
		});
		$("#board-etc").on("input", function(){
			if($(this).prop("checked")){
				var a = "기타";
				location.href = "<%=request.getContextPath()%>/semi-project/boardList.jsp?board_header="+a;
				$(this).prop("checked",true)
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
        </div>
        <div class="row">
        	<input type="radio" name="board_header_check" id="board-total" value="전체" <%if(board_header==null){%>checked<%}%>>
        	<label for="board-total">전체</label>
        	<input type="radio" name="board_header_check" id="board-inte" value="인테리어/DIY" <%if(board_header!=null&&board_header.equals("인테리어/DIY")){%>checked<%}%>>
        	<label for="board-inte">인테리어/DIY</label>
        	<input type="radio" name="board_header_check" id="board-market" value="전/월세 장터" <%if(board_header!=null&&board_header.equals("전/월세 장터")){%>checked<%}%>>
        	<label for="board-market">전/월세 장터</label>
        	<input type="radio" name="board_header_check" id="board-move" value="집수리/이사" <%if(board_header!=null&&board_header.equals("집수리/이사")){%>checked<%}%>>
        	<label for="board-move">집수리/이사</label>
        	<input type="radio" name="board_header_check" id="board-etc" value="기타" <%if(board_header!=null&&board_header.equals("기타")){%>checked<%}%>>
        	<label for="board-etc">기타</label>
        </div>
        <div class="row">
            <table class="table-box center">
                <thead>
                    <tr>
                        <th width="20%">구분</th>
                        <th width="50%">제목</th>
                        <th width="10%">글쓴이</th>
                        <th width="10%">조회</th>
                        <th width="10%">등록일</th>
                    </tr>
                </thead>
                <tbody>
				<%for(BoardVO boardVO : boardlist){%>
                    <tr>
                        <td><%=boardVO.getBoard_header()%></td>
                        <td><a href="boardDetail.jsp?board_no=<%=boardVO.getBoard_no()%>"><%=boardVO.getBoard_title()%><%if(boardVO.getReplycount()>0){%>[<%=boardVO.getReplycount()%>]<%}%></a></td>
                        <td><%=boardVO.getMember_nick()%></td>
                        <td><%=boardVO.getBoard_count()%></td>
                        <td><%=boardVO.getBoard_time()%></td>
                    </tr>
                <%}%>
                </tbody>
            </table>
        </div>
        
        <!-- 페이징 -->
        <div class="row center">
        	<ul class="pagination">
        		<%if(isSearch){ %>
        		<%if(isHeader){ %>
        			<li><a href="boardList.jsp?n=<%=startN-1%>&type=<%=type%>&key=<%=key%>&board_header=<%=board_header%>">&lt;</a></li>
        		<%} else{%>
        			<li><a href="boardList.jsp?n=<%=startN-1%>&type=<%=type%>&key=<%=key%>">&lt;</a></li>
        		<%} 
        		} else{
       			if(isHeader){%>
       				<li><a href="boardList.jsp?n=<%=startN-1%>&board_header=<%=board_header%>">&lt;</a></li>
       			<%} else{%>
       				<li><a href="boardList.jsp?n=<%=startN-1%>">&lt;</a></li>
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
        			<%if(endN==pagelast){ %>
        				<li><a href="boardList.jsp?n=<%=endN%>&type=<%=type%>&key=<%=key%>&board_header=<%=board_header%>">&gt;</a></li>
        			<%} else{%>
        				<li><a href="boardList.jsp?n=<%=endN+1%>&type=<%=type%>&key=<%=key%>&board_header=<%=board_header%>">&gt;</a></li>
        			<%} %>
        		<%} else{%>
        			<%if(endN==pagelast){ %>
        				<li><a href="boardList.jsp?n=<%=endN%>&type=<%=type%>&key=<%=key%>">&gt;</a></li>
        			<%} else{%>
        				<li><a href="boardList.jsp?n=<%=endN+1%>&type=<%=type%>&key=<%=key%>">&gt;</a></li>
        			<%} %>
        		<%} 
        		} else{%>
        		<%if(isHeader){ %>
        			<%if(endN==pagelast){ %>
        				<li><a href="boardList.jsp?n=<%=endN%>&board_header=<%=board_header%>">&gt;</a></li>
        			<%} else{%>
        				<li><a href="boardList.jsp?n=<%=endN+1%>&board_header=<%=board_header%>">&gt;</a></li>
        			<%} %>
        		<%} else{%>
        			<%if(endN==pagelast){ %>
        				<li><a href="boardList.jsp?n=<%=endN%>">&gt;</a></li>
        			<%} else{%>
        				<li><a href="boardList.jsp?n=<%=endN+1%>">&gt;</a></li>
        			<%} %>
        		<%}
        		}%>
        	</ul>
        </div>
        
        <!-- 검색창 -->
        <div class="row center">
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
        		<input type="submit" value="검색">
        	</form>
        </div>
    </div>
</body>
</html>