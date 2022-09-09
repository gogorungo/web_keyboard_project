<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/signUpForm.css" />



<main class="text-center form-signin">
	<form action="SearchPWReg" name="frm" method="post">
	<h1 class="h3 mb-3 fw-normal">아이디를 입력해주세요</h1>
		<div class="form-floating">
	        <input type="text" name="user_id" class="form-control" id="user_id" placeholder="아이디">
	        <label for="user_id">아이디 입력</label>
		</div>
		<button class="w-100 btn btn-lg btn-primary" type="button" onclick="checkData()" >아이디 확인</button>
	</form>
</main>

<script type="text/javascript">

	function checkData() {
		// * : 0개 이상 반복되는지
		// $ : 그 패턴으로 끝이 나는지
 		var spacing =  /\s/g; // 띄어쓰기 체크
		var newLine =  /\n/g; // 개행문자 체크 (제거로 만들자) 
		
		
		var form = document.frm;
		
		var userId = form.user_id.value;

		if(userId == ""){
			alert("아이디를 입력하세요.");
		    form.user_id.select;
		    return false;
		}
		
		if(spacing.test(userId)){
			alert("아이디에는 빈 칸이 없어야 합니다");
			form.user_id.select;
		    return false;
		}
		
		if(newLine.test(userId)){
			alert("입력에러. 다시 입력해주세요.");
			form.user_id.select;
		    return false;
		}
		
		var regExpId = /^[a-zA-Z0-9]{2,10}$/; //id 체크 영문, 숫자만 가능
		if(!regExpId.test(userId)){
			alert("아이디는 영어와 숫자만 입력 가능합니다. (최소 2글자 최대 10글자)");
			form.user_id.select;
		    return false;
		}

		form.submit();

	}
</script>