<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
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
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/common.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/main_style.css" type="text/css">
    <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <style> 
        section {
            margin: 0;
            padding: 0;
            height: auto;
            width: 100%;
        }
		header{
			height:80px;
			width: 100%;
		}
        article {
            display: inline-block;
            width: calc(100% - 405px);
            height: inherit;
        }

        aside {
            height: inherit;
            display: inline-block;
            width: 400px;
        }
        footer{
       		height: inherit;
            display: inline-block;
            width: 100%;
        }
    </style>
</head>
<body>
    <main>
        <header style="font-family:'samlib'; font-size: 23px;">
        <%if(!isLogin){ %>
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
            <%}if(isnormal){%>
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
                                <li><a class="villatwo" href="<%= request.getContextPath() %>/house/insert-villatwo.jsp">빌라 ｜ 투룸</a></li>
                                <li><a class="office" href="<%= request.getContextPath() %>/house/insert-office.jsp">오피스텔</a></li>

                            </ul>
                         </li>
                        <li class="menu-my">
                            <a href="<%=request.getContextPath()%>/member/my.jsp">내 정보</a>
                            <ul class="menu-second" style="left:380px">
                                <li><a href="<%=request.getContextPath()%>/member/my.jsp">내 정보</a></li>
                                <li><a class="room-list" href="<%= request.getContextPath()%>/member/room-list.jsp">등록된 매물</a></li>

                            </ul>
                        </li>
                        <li> 
                            <a href="<%=request.getContextPath()%>/board/boardList.jsp">커뮤니티</a>
                        </li>
                    </ul>
                </div>
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
            <%}if(isBroker){%>
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
                                <li><a class="villatwo" href="<%= request.getContextPath() %>/house/insert-villatwo.jsp">빌라 ｜ 투룸</a></li>
                                <li><a class="office" href="<%= request.getContextPath() %>/house/insert-office.jsp">오피스텔</a></li>
                            </ul>
                         </li>
                        <li class="menu-my">
                            <a href="<%=request.getContextPath()%>/member/my.jsp">내 정보</a>
                            <ul class="menu-second" style="left:380px">
                                <li><a href="<%=request.getContextPath()%>/member/my.jsp">내 정보</a></li>
                                <li><a class="room-list" href="<%= request.getContextPath()%>/member/broker_room-list.jsp">등록된 매물</a></li>

                            </ul>
                        </li>
                        <li> 
                            <a href="<%=request.getContextPath()%>/board/boardList.jsp">커뮤니티</a>
                        </li>
                    </ul>
                </div>
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
            <%}if(isAdmin){%>
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
                            <a href="<%=request.getContextPath()%>/admin/home.jsp">관리 메뉴</a>
                        </li>
                        <li class="menu-my">
                            <a href="<%=request.getContextPath()%>/member/my.jsp">내 정보</a>
                            
                        <li>
                            <a href="<%=request.getContextPath()%>/board/boardList.jsp">커뮤니티</a>
                        </li>
                        
                    </ul>
                </div>
                <div class="login-btn">
                	<input type="button" value="로그아웃" onClick="location.href='<%=request.getContextPath()%>/member/logout.do'">
                </div>               		
           </div>           
            <%}%> 
        </header>
        <section>