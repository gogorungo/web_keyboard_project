<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/signUpForm.css" />

<main class="text-center form-signin">
	<form  action="SearchIDReg" name="frm" method="post" >
	<h1 class="h3 mb-3 fw-normal">정보를 입력하세요</h1>
		<div class="form-floating">
	       <input type="text" name="name" class="form-control" id="name" placeholder="이름">
	       <label for="name">이름</label>
		</div>
		<div class="form-floating">
	       <input type="text" name="email" class="form-control" id="email" placeholder="이메일">
	       <label for="email">이메일</label>
		</div>
		<button class="w-100 btn btn-lg btn-primary" type="button" onclick="javascript:checkData()" >이메일 찾기</button>
	</form>
</main>

<script type="text/javascript">

	function checkData() {
		// * : 0개 이상 반복되는지
		// $ : 그 패턴으로 끝이 나는지
 		var spacing =  /\s/g; // 띄어쓰기 체크
		var newLine =  /\n/g; // 개행문자 체크 (제거로 만들자) 
		
		
		var form = document.frm;
		
		var userName = form.name.value;
		var userEmail = form.email.value;
		
		if(userName == ""){
			alert("이름을 입력하세요.");
		    form.name.select;
		    return false;
		}
		
		if(spacing.test(userName)){
			alert("빈 칸이 없어야 합니다");
			form.member_id.select;
		    return false;
		}
		
 		if(newLine.test(userName)){
			alert("입력에러. 다시 입력해주세요.");
			form.member_id.select;
		    return false;
		}
		
		var regExpName = /^[가-힣a-zA-Z]{2,10}$/; //이름. 한글, 영어만 가능
		if(!regExpName.test(userName)){
			alert("이름은 한글과 영어만 가능합니다. (최소 2글자 최대 10글자)");
			form.name.select;
		    return false;
		}
		
 		if(userEmail == ""){
			alert("이메일을 입력하세요.");
			form.email.select;
		    return false;
		}
		
 		if(spacing.test(userEmail)){
			alert("빈 칸이 없어야 합니다");
			form.email.select;
		    return false;
		}
		
		if(newLine.test(userEmail)){
			alert("입력에러. 다시 입력해주세요.");
			form.email.select;
		    return false;
		}
		
		var regExpEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
		if(!regExpEmail.test(userEmail)){
			alert("이메일의 형식에 맞춰 입력해주세요 (test@test.com)");
			form.email.select;
		    return false;
		}

		form.submit();

	}

</script>