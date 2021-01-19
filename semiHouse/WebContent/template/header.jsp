<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Document</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/common.css" type="text/css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/main_style.css" type="text/css">
    <style> 
        /*   **자리 테스트**  전부 다 만들고 없애기   */
        main, header, nav, section,
        aside, article, footer, div {
            border: 1px dotted lightgray
        }  
        /*section 영역*/
        section {
            margin: 0;
            padding: 0;
            border: 1px solid red;
            height: 5000px;
        }

        article {
            display: inline-block;
            border: 1px solid blue;
            width: calc(100% - 405px);
            height: inherit;
        }

        aside {
            height: inherit;
            display: inline-block;
            border: 1px solid green;
            width: 400px;
        }
    </style>
</head>

<body>
    <main>
        <header>
            <div class="outbox">

                <div class="logo-wrap">
                    <a href="#">
                        <img class="logo" src="https://via.placeholder.com/200x70" alt="홈으로">
                    </a>
                </div>
                <div class="menu-bar">
                    <ul class="menu">
                        <li class="menu-find">
                            <a href="#">방 찾기</a>
                            <ul class="menu-second">
                                <li><a href="#">원룸</a></li>
                                <li><a href="#">빌라 ｜ 투룸</a></li>
                                <li><a href="#">오피스텔</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="#">찜한 매물</a>
                        </li>
                        <li class="menu-regist">
                            <a href="#">방 내놓기</a>
                            <ul class="menu-second">
                                <li><a href="#">원룸</a></li>
                                <li><a href="#">빌라 ｜ 투룸</a></li>
                                <li><a href="#">오피스텔</a></li>
                            </ul>
                        </li>
                        <li>
                            <a href="#">게시판</a>
                        </li>
                    </ul>
                </div>
                <div class="login-btn">
                    <input type="button" value="로그인 및 회원 가입">
                </div>
                <div class="ad">
                    <a href="#">
                        <span style="display: block;">개발자문의</span>
                        <img class="logo" src="https://via.placeholder.com/200x40" alt="홈으로">
                    </a>
                </div>
            </div>
        </header>
        <section>