<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/template/header.jsp"></jsp:include>

<title>일반 회원 가입</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/join.css" type="text/css">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script type="text/javascript">
function idCheck(){
    var regex = /^[a-z][a-z0-9]{7,15}$/;
    var idInput = document.querySelector("input[name=member_id]");
    var idSpan = document.querySelector("#idcheckkk");

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
    var pwSpan = document.querySelector("#pwcheckkk");

    if(regex.test(pwInput.value)){
        pwSpan.textContent = "올바른 비밀번호 형식입니다.";
    }
    else{
        pwSpan.textContent = "영문 대/소문자와 숫자로 구성된 8~16자로 작성해주세요.";
    }
    if(document.getElementById('member_pw').value == document.getElementById('member_pw2').value && !(pwInput.value=="")){
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
    var nicknameSpan = document.querySelector("#nickcheck");

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

	<div id="wrapm">
		<form class="formCheck" action = "join_member.do" method="post">
			<h1>회원 가입</h1>
			<div>
			<div class="join_table">
				<div class="join_row">
					<label for="member_id">아이디 </label>
					<input type="text" id="member_id" name="member_id" required placeholder="8~18자 영문 소문자 또는 숫자 혼합해주세요" onchange="idCheck" class="input" maxlength="18">
					<button class="idCheck" onclick="idCheck();">중복확인</button>
				</div>
				<span id="idcheckkk"></span>
				<div class="join_row">
					<label for="member_pw">비밀번호 </label>
					<input type="password" id="member_pw" name="member_pw" required onchange="pwCheck();" class="input" placeholder="비밀번호는 최소 8글자 이상, 최대 16글자 이하로 설정해주세요">
				</div>
				<span id="pwcheckkk"></span>
				<div class="join_row">
					<label for="member_pw2">비밀번호 확인 </label>
					<input type="password" id="member_pw2" name="member_pw2" required onchange="pwCheck();" class="input" placeholder="비밀번호를 다시 입력해주세요">
				</div>
				<span id="check"></span>
				<div class="join_row">
					<label for="member_nick">닉네임 </label>
					<input type="text" id="member_nick" name="member_nick" required placeholder="2~10자로 설정해주세요" onchange="nickCheck" class="input" maxlength="30">
				</div>
				<span id="nickcheck"></span>
				<div class="join_row">
					<label for="member_email">이메일 </label>
					<input type="email" id="member_email" name="member_email" class="input" required placeholder="이메일 형식으로 입력해주세요">
				</div>
				<div class="join_row">
					<label for="member_phone">휴대 전화 </label>
					<input class="phone_bt input" type="text" id="member_phone" name="member_phone" required placeholder="XXX-XXXX-XXXX">
				</div>
				<input type="hidden" name="member_auth" value="member">
			</div>
			<div class="join_row">
				<div class="join_bt" >
					<input type="submit" class="btn_success" id="btn_success" value="회원가입">
					<input type="reset" class="btn_reset" id="btn_reset" value="초기화">
				</div>
			</div>
			</div>
		</form>
	</div>
<jsp:include page="/template/footer.jsp"></jsp:include>

