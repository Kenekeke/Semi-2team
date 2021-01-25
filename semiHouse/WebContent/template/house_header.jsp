<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	boolean isLogin = session.getAttribute("check") != null; 
	
	String auth = (String)session.getAttribute("auth");
	boolean isAdmin = isLogin && auth.equals("admin");
	boolean isBroker = isLogin && auth.equals("broker");
	boolean isnormal = isLogin && auth.equals("member");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Document</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/range.css" type="text/css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/search.css" type="text/css">
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/house_style.css" type="text/css">
<style>

html, body{
    margin: 0;
    padding: 0;
    width:100%;
    height:100%;
}
* {
    box-sizing: border-box;
}
main{
    width: 100%;
    height:100%;
}
header{
    height:80px;
}
nav{
    height:50px;
    padding-left: 3rem;
    display: flex;
    align-items: center;
    border-bottom: 1px solid #bdc3c7;
}
section{
    height: calc(100% - 130px);
    display:flex;
}
article{
    width: calc(100% - 400px);
    height:100%;
}
aside{
    width:400px;
    height:calc(100vh - 130px);
}
.callInfo{
	display:none;
}
</style>
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="<%=request.getContextPath()%>/js/pricechoice.js"></script>	
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=724a7918d5c20b6b105ff0bdad826269&libraries=clusterer,services"></script>
</head>

<body>
<div class="callInfo">
	<div class="callInfodetail">
		<div class="calltitle">문의하기</div>
		<div>등록번호를 꼭 알려주세요</div>
		<div class="call-house-no"></div>
		<div class="call-broker-name"></div>
		<div class="call-broker-landline"></div>
		<div class="call-broker-phone"></div>
		<input type="button" value="닫기" class="call-close">
	</div>
</div>
    <main>
    	<%if(!isLogin){ %>
        <header>
            <div class="outbox">
                <div class="logo-wrap">
                    <a href="<%=request.getContextPath()%>">
                        <img class="logo" src="https://via.placeholder.com/200x70" alt="홈으로">
                    </a>
                </div>
                <div class="menu-bar">
                    <ul class="menu">
                        <li class="menu-find">
                            <a href="<%=request.getContextPath()%>/house/one.jsp">방 찾기</a>
                            <ul class="menu-second">
                                <li><a href="<%=request.getContextPath()%>/house/one.jsp">원룸</a></li>
                                <li><a href="<%=request.getContextPath()%>/house/villatwo.jsp">빌라 ｜ 투룸</a></li>
                                <li><a href="<%=request.getContextPath()%>/house/office.jsp">오피스텔</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="<%=request.getContextPath()%>/member/login.jsp">찜한 매물</a>
                        </li>
                        <li class="menu-regist">
                            <a href="<%=request.getContextPath()%>/member/login.jsp">방 내놓기</a>
                            <ul class="menu-second">
                                <li><a href="<%=request.getContextPath()%>/member/login.jsp">원룸</a></li>
                                <li><a href="<%=request.getContextPath()%>/member/login.jsp">빌라 ｜ 투룸</a></li>
                                <li><a href="<%=request.getContextPath()%>/member/login.jsp">오피스텔</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="<%=request.getContextPath()%>/board/boardList.jsp">게시판</a>
                        </li>
                    </ul>
                </div>
                <div class="login-btn">
                    <input type="button" value="로그인 및 회원 가입" onClick="location.href='<%=request.getContextPath()%>/member/login.jsp'">
                </div>
                <div class="ad">
                    <a href="#">
                        <span style="display: block;">개발자문의</span>
                        <img class="logo" src="https://via.placeholder.com/200x40" alt="홈으로">
                    </a>
                </div>
            </div>
            </header>
            <nav>
            	<div class="second-menubar">
                <ul>
                    <li><a href="<%=request.getContextPath()%>/house/one.jsp">원룸</a></li>
                    <li><a href="<%=request.getContextPath()%>/house/villatwo.jsp">빌라 ｜ 투룸</a></li>
                    <li><a href="<%=request.getContextPath()%>/house/office.jsp">오피스텔</a></li>
                </ul>
            </div>
            </nav>
            <%}if(isnormal || isBroker){%>
            <header>
            <div class="outbox">
                <div class="logo-wrap">
                    <a href="<%=request.getContextPath()%>">
                        <img class="logo" src="https://via.placeholder.com/200x70" alt="홈으로">
                    </a>
                </div>
                <div class="menu-bar">
                    <ul class="menu">
                        <li class="menu-find">
                            <a href="<%=request.getContextPath()%>/house/one.jsp">방 찾기</a>
                            <ul class="menu-second">
                                <li><a href="<%=request.getContextPath()%>/house/one.jsp">원룸</a></li>
                                <li><a href="<%=request.getContextPath()%>/house/villatwo.jsp">빌라 ｜ 투룸</a></li>
                                <li><a href="<%=request.getContextPath()%>/house/office.jsp">오피스텔</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="<%=request.getContextPath()%>/like/zzim.jsp">찜한 매물</a>
                        </li>
                        <li class="menu-regist">
                            <a href="<%=request.getContextPath()%>/house/insert.jsp">방 내놓기</a>
                            <ul class="menu-second">
                                <li><a class="one" href="<%= request.getContextPath() %>/house/insert-one.jsp">원룸</a></li>
                                <li><a class="villatow" href="<%= request.getContextPath() %>/house/insert-villatwo.jsp">빌라 ｜ 투룸</a></li>
                                <li><a class="office" href="<%= request.getContextPath() %>/house/insert-office.jsp">오피스텔</a></li>
                            </ul>
                        </li>
                        <li class="menu-my">
                            <a href="<%=request.getContextPath()%>/member/my.jsp">내 정보</a>
                            <ul class="menu-second" style="left:380px">
                                <li><a href="<%=request.getContextPath()%>/member/my.jsp">내 정보</a></li>
                                <li><a class="room-list" href="<%= request.getContextPath() %>/member/room-list.jsp">등록된 매물</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="<%=request.getContextPath()%>/board/boardList.jsp">게시판</a>
                        </li>
                    </ul>
                </div>
                <div class="login-btn">
                    <input type="button" value="로그아웃" onClick="location.href='<%=request.getContextPath()%>/member/logout.do'">
                </div>
                <div class="ad">
                    <a href="#">
                        <span style="display: block;">개발자문의</span>
                        <img class="logo" src="https://via.placeholder.com/200x40" alt="홈으로">
                    </a>
                </div>
            </div>
            </header>
            <nav>
            	<div class="second-menubar">
                <ul>
                    <li><a href="<%=request.getContextPath()%>/house/one.jsp">원룸</a></li>
                    <li><a href="<%=request.getContextPath()%>/house/villatwo.jsp">빌라 ｜ 투룸</a></li>
                    <li><a href="<%=request.getContextPath()%>/house/office.jsp">오피스텔</a></li>
                </ul>
            </div>
            </nav>
            <%}if(isAdmin){%>
            <header>
            <div class="outbox">
                <div class="logo-wrap">
                    <a href="<%=request.getContextPath()%>">
                        <img class="logo" src="https://via.placeholder.com/200x70" alt="홈으로">
                    </a>
                </div>
                <div class="menu-bar">
                    <ul class="menu">
                        <li>
                            <a href="<%=request.getContextPath()%>/admin/home.jsp">관리 메뉴</a>
                        </li>
                        <li class="menu-my">
                            <a href="<%=request.getContextPath()%>/member/my.jsp">내 정보</a>
                        <li>
                            <a href="<%=request.getContextPath()%>/board/boardList.jsp">게시판</a>
                        </li>
                    </ul>
                </div>
                <div class="login-btn">
                    <input type="button" value="로그아웃" onClick="location.href='<%=request.getContextPath()%>/member/logout.do'">
                </div>
            </div>
            </header>
            <nav>
            	<div class="second-menubar">
                <ul>
                    <li><a href="<%=request.getContextPath()%>/house/one.jsp">원룸</a></li>
                    <li><a href="<%=request.getContextPath()%>/house/villatwo.jsp">빌라 ｜ 투룸</a></li>
                    <li><a href="<%=request.getContextPath()%>/house/office.jsp">오피스텔</a></li>
                </ul>
            </div>
            </nav>
            <%}%>
        <section>