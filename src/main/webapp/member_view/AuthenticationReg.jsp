<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/signUpForm.css" />
	

<main class="text-center form-signin">
	<form action="AuthenticationReg" name="frm" method="post">
	<h1 class="h3 mb-3 fw-normal">코드를 입력해주세요</h1>
	<input type="hidden" name="email" value="${email }" />
		<div class="form-floating">
	        <input type="text" name="AuthenticationUser" class="form-control" id="AuthenticationUser" placeholder="인증번호">
	        <label for="AuthenticationUser">코드 입력</label>
		</div>
		<button class="w-100 btn btn-lg btn-primary" type="button" onclick="checkData()" >인증코드 보내기</button>
		<h1>
			<div>
			  <span> </span><span id="timer"></span>
			</div>
		</h1>
	</form>
</main>



<script type="text/javascript">


	function $ComTimer(){
	    //prototype extend
	}
	
	$ComTimer.prototype = {
	    comSecond : ""
	    , fnCallback : function(){}
	    , timer : ""
	    , domId : ""
	    , fnTimer : function(){
	        var m = Math.floor(this.comSecond / 60) + "분 " + (this.comSecond % 60) + "초";	// 남은 시간 계산
	        this.comSecond--;					// 1초씩 감소
	        console.log(m);
	        this.domId.innerText = m;
	        if (this.comSecond < 0) {			// 시간이 종료 되었으면..
	            clearInterval(this.timer);		// 타이머 해제
	            alert("인증시간이 초과하였습니다. 다시 인증해주시기 바랍니다.")
	            location.href = "<c:url value="./Login"/>";
	        }
	    }
	    ,fnStop : function(){
	        clearInterval(this.timer);
	    }
	}
	
	 var AuthTimer = new $ComTimer()
	
	  AuthTimer.comSecond = 180;
	  AuthTimer.fnCallback = function(){alert("다시인증을 시도해주세요.")}
	  AuthTimer.timer =  setInterval(function(){AuthTimer.fnTimer()},1000);
	  AuthTimer.domId = document.getElementById("timer");
	 
	  
	
  function checkData() {
		// * : 0개 이상 반복되는지
		// $ : 그 패턴으로 끝이 나는지
 		var spacing =  /\s/g; // 띄어쓰기 체크
		var newLine =  /\n/g; // 개행문자 체크 (제거로 만들자) 
		
		
		var form = document.frm;
		
		var userAuthenticationUserCode = form.AuthenticationUser.value;

 		if(userAuthenticationUserCode == ""){
			alert("코드를 입력하세요.");
			form.AuthenticationUser.select;
		    return false;
		}
		
 		if(spacing.test(userAuthenticationUserCode)){
			alert("빈 칸이 없어야 합니다");
			form.AuthenticationUser.select;
		    return false;
		}
		
		if(newLine.test(userAuthenticationUserCode)){
			alert("입력에러. 다시 입력해주세요.");
			form.AuthenticationUser.select;
		    return false;
		}
		
		var regExpuserAuthenticationUserCode = /^[A-Z\d]{10}$/;
		if(!regExpuserAuthenticationUserCode.test(userAuthenticationUserCode)){
			alert("코드를 정확하게 입력해주세요");
			form.AuthenticationUser.select;
		    return false;
		}

		checkCode();

	}
  
  
	function checkCode() {
		var AuthenticationKeyCheck = '${AuthenticationKey }';
		var AuthenticationUser = document.getElementById('AuthenticationUser').value;
		
		var form = document.frm;
		
		if(AuthenticationKeyCheck == AuthenticationUser){
			form.submit();
		}else{
			alert("코드가 틀립니다");
		}
	}  

</script>

