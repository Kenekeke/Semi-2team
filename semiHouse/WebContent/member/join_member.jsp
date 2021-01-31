<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/template/header.jsp"></jsp:include>

<title>일반 회원 가입</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/join.css" type="text/css">
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script type="text/javascript">

$(function(){
	var joinCheck=1;
	 $("#member_id").blur(function () {
         var regex = /^[a-z][a-z0-9]{4,19}$/;
         var idSpan = $("#idcheckkk");
         if (regex.test($(this).val())) {
             idSpan.text("올바른 아이디 형식입니다.");
             joinCheck=1;
         } else if (!$(this).val()) idSpan.text("아이디를 입력해주세요");
         else {
        	idSpan.text("잘못된 형식입니다.");
         	joinCheck=0;
         }
     });

     $("#member_pw").blur(function () {
         var regex = /^(\w|[!@#$%&*]){5,16}$/;
         var pwSpan = $("#pwcheckkk");
         if (regex.test($(this).val())) {
             if (!$(this).val().search(/[a-z]|[A-Z]/) < 0) {
               	 pwSpan.text("올바른 형식입니다.");
                 joinCheck=1;
             } else {
            	 pwSpan.textContent = "영문자를 포함해주세요.";
            	 joinCheck=0;
             }
         } else if (!$(this).val()) {
             pwSpan.text("비밀번호를 입력해주세요.");
        	 joinCheck=0;
         } else {
        	 pwSpan.text("잘못된 형식입니다.");
        	 joinCheck=0;
         }
         
     })

     $("#member_nick").blur(function () {
         var regex = /^(\w|[가-힣]){2,10}$/;
         var nickSpan = $("#nickcheck");
         if (regex.test($(this).val())) {
             nickSpan.text("올바른 형식입니다.");
             var member_nick=$("#member_nick").val();
     		$.ajax({          
    			async: false,
     			url: "<%=request.getContextPath()%>/member/nickCheck.do",
     			type: "POST",
     			data:{
     				member_nick: member_nick
     			},
     			success: function(result){
     				if(result==="true"){
     					$("#nickcheck").text("이미 존재하는 닉네임입니다.");
     		             joinCheck=0;
     				}
     				else{
     					$("#nickcheck").text("사용 가능한 닉네임입니다.");
     		             joinCheck=1;
     				}
     			},
     			error: function(){
     				console.log("fail");
     			}
     		});
         } else if (!$(this).val()) {
             nickSpan.text("닉네임을 입력해주세요.");
             joinCheck=1;
         } else {
        	 nickSpan.text("잘못된 형식입니다.");
             joinCheck=0;
         }

     })
	$("#member_pw2").on("blur",function(){
		if($("#member_pw").val() == $('#member_pw2').val() && !( $("#member_pw").val()=="")){
	    	$("#check").text("비밀번호가 일치합니다.");
            joinCheck=1;
	    	$("#check").css("color",'blue');
	    }
	    else{
	    	$('#check').text('비밀번호가 일치하지 않습니다.');
            joinCheck=0;
	        $('#check').css("color",'red');
	    };
	});
	$("#member_phone").on("blur",function(){
		if($("#member_phone").val().length <= 13 ){
			joinCheck=1;
		}
		else{
			joinCheck=0;
			alert("번호 형식이 맞지 않습니다.ex)010-1234-5678");
		}
	});
	$(".idCheck").on("click",function(e){
		e.preventDefault();
		var member_id=$("#member_id").val();
		$.ajax({
			async: false,
			url: "<%=request.getContextPath()%>/member/idCheck.do",
			type: "POST",
			data:{
				member_id: member_id
			},
			success: function(result){
				if(result==="true"){
					$("#idcheckkk").text("이미 존재하는 아이디입니다.");
		             joinCheck=0;
				}
				else{
					$("#idcheckkk").text("사용 가능한 아이디입니다.");
		             joinCheck=1;
				}
			},
			error: function(){
				console.log("fail");
			}
		});
	});
	$(".btn_success").on("click",function(e){
		e.preventDefault();
		console.log(joinCheck);
		if(joinCheck==1){
			$(".formCheck").submit();
		}
		else{
			alert("회원가입 양식에 맞지 않습니다.");
		}
	});
});

</script>
	<div id="wrapm">
		<form class="formCheck" action = "join_member.do" method="post">
			<h1>회원 가입</h1>
			<div>
			<div class="join_table">
				<div class="join_row">
					<label for="member_id">아이디 </label>
					<input type="text" id="member_id" name="member_id" required placeholder="8~18자 영문 소문자 또는 숫자 혼합해주세요" class="input" maxlength="18">
					<button class="idCheck">중복확인</button>
				</div>
				<span id="idcheckkk"></span>
				<div class="join_row">
					<label for="member_pw">비밀번호 </label>
					<input type="password" id="member_pw" name="member_pw" required class="input" placeholder="비밀번호는 최소 8글자 이상, 최대 16글자 이하로 설정해주세요">
				</div>
				<span id="pwcheckkk"></span>
				<div class="join_row">
					<label for="member_pw2">비밀번호 확인 </label>
					<input type="password" id="member_pw2" name="member_pw2" required class="input" placeholder="비밀번호를 다시 입력해주세요">
				</div>
				<span id="check"></span>
				<div class="join_row">
					<label for="member_nick">닉네임 </label>
					<input type="text" id="member_nick" name="member_nick" required placeholder="2~10자로 설정해주세요" class="input" maxlength="30">
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

