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
    padding-left: 0rem;
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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fe6f523576b10aa9e50625a1962d3635&libraries=clusterer,services"></script>
<script>
	$(function(){
		$(".active").hide();
		$("#charter-range").hide();
		$(".listDetail").hide();
		$(".list").show();
	});
</script>
</head>

<body>
<div class="callInfo">
	<div class="callInfodetail">
		<div class="calltitle">문의하기</div>
		<div class="callcontent">등록번호를 꼭 알려주세요</div>
		<div class="call-house-no"></div>
		<div class="call-broker-name"></div>
		<div class="call-broker-landline"></div>
		<div class="call-broker-phone"></div>
		<input type="button" value="닫기" class="call-close">
	</div>
</div>
    <main>
    	<%if(!isLogin){ %>
        <header style="font-family:'samlib'; font-size: 23px;">
            <div class="outbox">
                <div class="logo-wrap">
                    <a href="<%=request.getContextPath()%>">
                        <img class="logo" src="<%=request.getContextPath()%>/img/Logo.jpg">
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
                            <a href="<%=request.getContextPath()%>/board/boardList.jsp">커뮤니티</a>
                        </li>
                    </ul>
                </div>
               <div class="top_right_wrapper">
                	<div class="login-btn">
                    <input type="button" value="로그인 및 회원 가입" onClick="location.href='<%=request.getContextPath()%>/member/login.jsp'">
                </div>
                <div class="ad">
                    <a href="https://www.iei.or.kr/main/main.kh">
                        <span style="display: block;">광고 문의</span>
                        <img class="logo2" src="<%=request.getContextPath()%>/img/KHLogo.jpg" style="width:150;">
                    </a>
                </div>
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
            <%}if(isnormal){%>
            <header style="font-family:'samlib'; font-size: 23px;">
            <div class="outbox">
                <div class="logo-wrap">
                    <a href="<%=request.getContextPath()%>">
                        <img class="logo" src="<%=request.getContextPath()%>/img/Logo.jpg">
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
                            <a href="<%=request.getContextPath()%>/house/insert-one.jsp">방 내놓기</a>
                            <ul class="menu-second">
                                <li><a class="one" href="<%= request.getContextPath() %>/house/insert-one.jsp">원룸</a></li>
                                <li><a class="villatow" href="<%= request.getContextPath() %>/house/insert-villatwo.jsp">빌라 ｜ 투룸</a></li>
                                <li><a class="office" href="<%= request.getContextPath() %>/house/insert-office.jsp">오피스텔</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="<%=request.getContextPath()%>/board/boardList.jsp">커뮤니티</a>
                        </li>
                        <li class="menu-my">
                            <a href="<%=request.getContextPath()%>/member/my.jsp">내 정보</a>
                            <ul class="menu-second" style="left:510px">
                                <li><a href="<%=request.getContextPath()%>/member/my.jsp">내 정보</a></li>
                                <li><a class="room-list" href="<%= request.getContextPath() %>/member/room-list.jsp">등록된 매물</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <div class="top_right_wrapper">
                    <div class="login-btn">
                		<input type="button" value="로그아웃" onClick="location.href='<%=request.getContextPath()%>/member/logout.do'">
               		</div>
                	<div class="ad">
                    	<a href="https://www.iei.or.kr/main/main.kh">
                        <span style="display: block;">광고 문의</span>
                        <img class="logo2" src="<%=request.getContextPath()%>/img/KHLogo.jpg" style="width:150;">
                    	</a>
                	</div>	
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
            <%}if(isBroker){%>
            <header style="font-family:'samlib'; font-size: 23px;">
            <div class="outbox">
                <div class="logo-wrap">
                    <a href="<%=request.getContextPath()%>">
                        <img class="logo" src="<%=request.getContextPath()%>/img/Logo.jpg">
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
                            <a href="<%=request.getContextPath()%>/house/insert-one.jsp">방 내놓기</a>
                            <ul class="menu-second">
                                <li><a class="one" href="<%= request.getContextPath() %>/house/insert-one.jsp">원룸</a></li>
                                <li><a class="villatow" href="<%= request.getContextPath() %>/house/insert-villatwo.jsp">빌라 ｜ 투룸</a></li>
                                <li><a class="office" href="<%= request.getContextPath() %>/house/insert-office.jsp">오피스텔</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="<%=request.getContextPath()%>/board/boardList.jsp">커뮤니티</a>
                        </li>
                        <li class="menu-my">
                            <a href="<%=request.getContextPath()%>/member/my.jsp">내 정보</a>
                            <ul class="menu-second" style="left:510px">
                                <li><a href="<%=request.getContextPath()%>/member/my.jsp">내 정보</a></li>
                                <li><a class="room-list" href="<%= request.getContextPath() %>/member/broker_room-list.jsp">등록된 매물</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <div class="top_right_wrapper">
                <div class="login-btn">
                	<input type="button" value="로그아웃" onClick="location.href='<%=request.getContextPath()%>/member/logout.do'">
                </div>
                <div class="ad">
                    <a href="https://www.iei.or.kr/main/main.kh">
                        <span style="display: block;">광고 문의</span>
                        <img class="logo2" src="<%=request.getContextPath()%>/img/KHLogo.jpg" style="width:150;">
                    </a>
                </div>
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
            <header style="font-family:'samlib'; font-size: 23px;">
            <div class="outbox">
                <div class="logo-wrap">
                    <a href="<%=request.getContextPath()%>">
                        <img class="logo" src="<%=request.getContextPath()%>/img/Logo.jpg">
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
                        <li>
                            <a href="<%=request.getContextPath()%>/admin/home.jsp">관리 메뉴</a>
                        </li>
                        <li class="menu-my">
                            <a href="<%=request.getContextPath()%>/member/my.jsp">내 정보</a>
                        <li>
                            <a href="<%=request.getContextPath()%>/board/boardList.jsp">커뮤니티</a>
                        </li>
                    </ul>
                </div>
                <div class="top_right_wrapper">
                <div class="login-btn">
                	<input type="button" value="로그아웃" onClick="location.href='<%=request.getContextPath()%>/member/logout.do'">
                </div>
                <div class="ad">
                    <a href="https://www.iei.or.kr/main/main.kh">
                        <span style="display: block;">광고 문의</span>
                        <img class="logo2" src="<%=request.getContextPath()%>/img/KHLogo.jpg" style="width:150;">
                    </a>
                </div>
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