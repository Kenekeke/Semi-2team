<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/template/header.jsp"></jsp:include>

<title>중개사 회원가입 추가 정보 입력</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/join.css" type="text/css">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script type="text/javascript">
function idCheck(){
    var regex = /^[a-z][a-z0-9]{7,15}$/;
    var idInput = document.querySelector("input[name=member_id]");
    var idSpan = document.querySelector("input[name=member_id] + span");

    if(regex.test(idInput.value)){//정상
        idSpan.textContent = "올바른 아이디입니다.";
    }
    else{//이상
        idSpan.textContent = "영문 소문자와 숫자를 섞어 8~16자 이내로 작성해주세요.";
    }
}

function pwCheck(){
    var regex = /^[A-Za-z0-9!@#$%^&*()\s]{7,15}$/;
    var pwInput = document.querySelector("input[name=member_pw]");
    var pwSpan = document.querySelector("input[name=member_pw] + span");

    if(regex.test(pwInput.value)){
        pwSpan.textContent = "올바른 비밀번호 형식입니다.";
    }
    else{
        pwSpan.textContent = "영문 대/소문자와 숫자로 구성된 8~16자로 작성해주세요.";
    }
    if(document.getElementById('member_pw').value == document.getElementById('member_pw2').value){
    	document.getElementById('check').innerHTML='비밀번호가 일치합니다.'
    	document.getElementById('check').style.color='blue';
    }
    else{
    	document.getElementById('check').innerHTML='비밀번호가 일치하지 않습니다.'
        document.getElementById('check').style.color='red';
    }
}

function nickCheck(){
    var regex = /^[가-힣]{1,9}$/;
    var nicknameInput = document.querySelector("input[name=member_nickname]");
    var nicknameSpan = document.querySelector("input[name=member_nickname] + span");

    if(regex.test(nicknameInput.value)){
        nicknameSpan.textContent = "올바른 닉네임입니다.";
    }
    else if (!nicknameInput.value){
    	nicknameSpan.textContent = "닉네임을 입력해주세요.";
    }
    else{
        nicknameSpan.textContent = "잘못된 형식입니다.";
    }
}
</script>
<style>
#wrap{
	margin: 0 auto;
}
.join_table{
	margin: 0 auto;
}
.join_row > td{
	margin-left: 0;
}
.join_bt{
	padding-left:405px;
}

</style>
</head>
<body>
	<div id="wrap" style="width:950px; height:600px; ">
		<form class="formCheck" action = "join_broker.do" method="post">
			<h1>회원 가입</h1>
			<table class = "join_table">
				<tbody>
					<tr>
						<div class="join_row">
							<th><label for="member_id">아이디 : </label></th>
								<td><input type="text" id="member_id" name="member_id" required placeholder="8~18자 영문 소문자 또는 숫자 혼합해주세요" onchange="idCheck" class="input" maxlength="18">
								<span></span>
								<button class="idCheck" onclick="idCheck();">중복확인</button></td>
						</div>
					</tr>
					<tr>
						<div class="join_row">
							<th><label for="member_pw">비밀번호 : </label></th>
								<td><input style="width:250px;" type="password" id="member_pw" name="member_pw" required onchange="pwCheck();" class="input" placeholder="비밀번호는 최소 8글자 이상, 최대 16글자 이하로 설정해주세요">
								<span></span>
							</td>
						</div>
						
					</tr>
					<tr>
						<div class="join_row">
							<th><label for="member_pw">비밀번호 확인 : </label></th>
								<td><input type="password" id="member_pw2" name="member_pw" required onchange="pwCheck();" class="input" placeholder="비밀번호를 다시 입력해주세요">
								<span id="check"></span>
							</td>
						</div>
					</tr>
					<tr>
						<div class="join_row">
							<th><label for="member_nick">닉네임 : </label></th>
								<td><input type="text" id="member_nick" name="member_nick" required placeholder="2~10자로 설정해주세요" onchange="nickCheck" class="input" maxlength="30">
								<span></span>
							</td>
						</div>
					</tr>
					<tr>
						<div class="join_row">
							<th><label for="member_email">이메일 : </label></th>
							<td><input type="email" id="member_email" name="member_email" required placeholder="이메일 형식으로 입력해주세요"></td>
						</div>
					</tr>
					<tr>
						<div class="join_row">
							<th><label for="member_phone">휴대 전화 : </label></th>
								<td><input class="phone_bt" type="text" id="member_phone" name="member_phone" required placeholder="XXX-XXXX-XXXX">
								</td>
						</div>
					</tr>
					<tr>
						<div class="join_row">
							<th><label for="broker_name">중개사무소 이름  : </label></th>
							<td><input type="text" id="broker_name" name="broker_name" required class="input" placeholder="공인중개사 상호명을 입력해주세요"></td>
						</div>
					</tr>
					<tr>
						<div class="join_row">
							<th><label for="broker_address">중개사무소 주소 : </label></th>
							<td><input type="text" id="broker_address" name="broker_address" required class="input" placeholder="주소를 입력해주세요"></td>
						</div>
					</tr>
					<tr>
						<div class="join_row">
							<th><label for="broker_address">나머지 주소 : </label></th>
							<td><input type="text" id="broker_address2" name="broker_address2" required class="input" placeholder="나머지 주소를 입력해주세요"></td>
						</div>
					</tr>
					<tr>
						<div class="join_row">
							<th><label for="broker_landline">중개사무소 전화번호 : </label></th>
							<td><input type="text" id="broker_landline" name="broker_laneline" required class="input" placeholder="공인중개사 전화번호가 없을시 휴대폰번호를 다시 입력해주세요."></td>
						</div>
					</tr>
					<input type="hidden" name="member_auth" value="broker">
				</tbody>
				</table>
					<div class="join_row">
					<div class="join_bt" >
						<input type="submit" class="btn_success" id="btn_success" value="회원가입">
						<input type="reset" class="btn_reset" id="btn_reset" value="초기화">
					</div>
					</div>
		</form>
	</div>
<jsp:include page="/template/footer.jsp"></jsp:include>

