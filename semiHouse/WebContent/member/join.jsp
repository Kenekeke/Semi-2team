<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SemiProject kh4 Member_Join</title>
 <link rel="stylesheet" type="text/css" href="./css/common.css">
</head>
<script type="text/javascript">
$('#name').val('test');
$('.name').val();
function idCheck() {
	var id = $('#id').val();
	
	$.ajax({
	    url : "서버의 주소", // 아이디 체크를 할 servlet 호출 url
	    type : "post", // id/pw 뜨면안되니깐
	    data : {
	    	keyword:"어쩌구저쩌구", 이름:값, ... // 보낼 파라메터
	    	// ex id : id
	    },
	    success:function(resp){
	        //resp는 서버에서 수신받은 데이터(List<DTO> 형태)
	        //이곳에서 템플릿을 만들어서 추가하는 형태로 코드를 작성하면 됩니다.
	        console.log(resp);
	        // id가 중복되지 않았을경우 alert('확인되었습니다.')
	        // id가 중복일경우 alert('아이디가 중복입니다.')
	    },
	    error:function(){
	        //통신이 실패하면 실행할 코드
	    },
	    complete:function(){
	        //성공 실패 상관없이 무조건 마지막에 실행하고 싶은 코드를 작성하시며 ㄴ됩니다.
	    },
	});	
	
}

</script>
<body>
	<h1 style="color:green; font-size 20px">회원 가입</h1>
	<form action = "http://Localhost:8888/kh4semiDminn/member/join.do" method="post">
	아이디 : <input type="text" id="id" name="member_id" required><button onclick="javascript:idCheck();">중복학인</button><br>
	비밀번호 : <input type="password" name="member_pw" required><br>
	닉네임 : <input type="text" name="member_nick" required><br>
	이메일 : <input type="text" name="member_email" required><br>
	휴대전화 : <input type="text" name="member_phone" required><br>
	회원 구분 :
		<input type="radio" name="member_member" value="일반 회원" checked> <label>일반회원</label>
		<input type="radio" name="member_member" value="중개인"> <label>중개인</label><br>
	<input type="submit" value="회원 가입">
	</form>
</body>
</html>
<!-- create table member(
member_no number primary key,
member_id varchar2(20) not null unique,
member_pw varchar2(18) not null,
member_nick varchar2(100) not null unique,
member_email varchar2(100) not null,
member_phone char(13) not null unique
member_member auth varchar2(12)
	check(member_auth in('관리자', '일반회원', '중개사'))
);
 <script type="text/javascript">
$('#name').val('test');
$('.name').val();
function idCheck() {
	var id = $('#id').val();
	
	$.ajax({
	    url : "서버의 주소", //아이디 체크를 할 servlet 호출 url
	    type : "get" or "post", // 알아서 골라써라
	    data : {
	    	keyword:"어쩌구저쩌구", 이름:값, ... // 보낼 파라메터
	    	// ex id : id
	    },
	    success:function(resp){
	        //resp는 서버에서 수신받은 데이터(List<DTO> 형태)
	        //이곳에서 템플릿을 만들어서 추가하는 형태로 코드를 작성하면 됩니다.
	        console.log(resp);
	        // id가 중복되지 않았을경우 alert('확인되었습니다.')
	        // id가 중복일경우 alert('아이디가 중복입니다.')
	    },
	    error:function(){
	        //통신이 실패하면 실행할 코드
	    },
	    complete:function(){
	        //성공 실패 상관없이 무조건 마지막에 실행하고 싶은 코드를 작성하시며 ㄴ됩니다.
	    },
	});	
	
}

</script>
 -->
   
<!--  BIRTH 
                <div>
                    <h3><label for="yy">생년월일</label></h3>

                    <div id="bir_wrap">
                    
                        <!-- BIRTH_YY -->
                        <div id="bir_yy">
                            <span class="box">
                                <input type="text" id="yy" class="int" maxlength="4" placeholder="년(4자)">
                            </span>
                        </div>

                        <!-- BIRTH_MM -->
                        <div id="bir_mm">
                            <span class="box">
                                <select id="mm">
                                    <option>월</option>
                                    <option value="01">1</option>
                                    <option value="02">2</option>
                                    <option value="03">3</option>
                                    <option value="04">4</option>
                                    <option value="05">5</option>
                                    <option value="06">6</option>
                                    <option value="07">7</option>
                                    <option value="08">8</option>
                                    <option value="09">9</option>                                    
                                    <option value="10">10</option>
                                    <option value="11">11</option>
                                    <option value="12">12</option>
                                </select>
                            </span>
                        </div>

                        <!-- BIRTH_DD -->
                        <div id="bir_dd">
                            <span class="box">
                                <input type="text" id="dd" class="int" maxlength="2" placeholder="일">
                            </span>
                        </div>

                    </div>
                    <span class="error_next_box"></span>    
                </div> -->
<!-- h3 {
    margin: 19px 0 8px;
    font-size: 14px;
    font-weight: 700;
}

.box {

    display: block;
    width: 100%;
    height: 51px;
    border: solid 1px #dadada;
    padding: 10px 14px 10px 14px;
    box-sizing: border-box;
    background: #fff;
    position: relative;
}

.int {
    display: block;
    position: relative;
    width: 100%;
    height: 29px;
    border: none;
    background: #fff;
    font-size: 15px;
    
    비밀번호 입력폼 자물쇠 이미지 
    .pswdImg {
    width: 18px;
    height: 20px;
    display: inline-block;
    position: absolute;
    top: 50%;
    right: 16px;
    margin-top: -10px;
    cursor: pointer;
}
} -->  