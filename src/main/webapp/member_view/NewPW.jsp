<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/signUpForm.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js" >

</script>

<main class="text-center form-signin">
	<form  action="UpdateNewPW" name="frm" method="post" >
	<h1 class="h3 mb-3 fw-normal">새 비밀번호 입력</h1>
		<div class="form-floating">
		    <input type="password" name="user_pw" class="form-control" id="user_pw" placeholder="비밀번호">
		    <label for="user_pw">새 비밀번호</label>
		</div>
		<div class="form-floating">
		    <input type="password" name="user_pw2" class="form-control" id="user_pw2" placeholder="비밀번호 확인">
		    <label for="user_pw2">새 비밀번호 확인</label>
		</div>
	<button class="w-100 btn btn-lg btn-primary" type="button" onclick="checkform()" >비밀번호 수정</button>
</form>
</main>

<script type="text/javascript">
	function checkform() {
	  	var spacing =  /\s/g; // 띄어쓰기 체크
		var newLine =  /\n/g; // 개행문자 체크 (제거로 만들자) 
		
		var form = document.frm;
		
		var userPw = form.user_pw.value;
		var userPw2 = form.user_pw2.value;
			
			
		if(userPw == ""){
			alert("비밀번호를 입력하세요.");
			form.user_pw.select;
		    return false;
		}
		
		if(spacing.test(userPw)){
			alert("비밀번호에는 빈 칸이 없어야 합니다");
			form.user_pw.select;
		    return false;
		}
		
		if(newLine.test(userPw)){
			alert("입력에러. 다시 입력해주세요.");
			form.user_pw.select;
		    return false;
		}
		
		var regExpPw = /^[A-Za-z\d$@$!%*#?&]{4,15}$/; //최소 8자리, 최대 15자리.
		if(!regExpPw.test(userPw)){
			alert("비밀번호는 영어,숫자,특수문자가 한글자 이상 들어가야 합니다. (최소 4글자, 최대 15글자)");
			form.user_pw.select;
		    return false;
		}
		
		else if(userPw2 == ""){
			alert("비밀번호 확인을 입력해주세요");
			form.user_pw2.select;
			return false;
		}
		
		if(spacing.test(userPw2)){
			alert("비밀번호 확인에는 빈 칸이 없어야 합니다");
			form.user_pw2.select;
		    return false;
		}
		
		if(newLine.test(userPw2)){
			alert("입력에러. 다시 입력해주세요.");
			form.user_pw2.select;
		    return false;
		}
		
		var regExpPw = /^[A-Za-z\d$@$!%*#?&]{8,15}$/; //최소 8자리, 최대 15자리.
		if(!regExpPw.test(userPw2)){
			alert("비밀번호 확인에는 영어,숫자,특수문자가 한글자 이상 들어가야 합니다. (최소 8글자, 최대 15글자)");
			form.user_pw2.select;
		    return false;
		}
		
		if(userPw != userPw2){
			alert("비밀번호가 일치하지 않습니다. 다시 입력해주세요");
			return false;
		}
		
		form.submit();
	}
</script>	

