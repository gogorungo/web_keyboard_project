<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page import="model.member.memberDTO"%>
<%	
	int memberNo;
	String name = "비회원";
	HttpSession user = request.getSession();
	String userStatus = null;
	memberDTO dto = (memberDTO) user.getAttribute("inUser");
	if (dto != null) {
		userStatus = dto.getStatus();
		memberNo = dto.getMemberNo();
		name = dto.getName();
	} else {
		memberNo = 0;
	}
	pageContext.setAttribute("memberNo",memberNo);
%>    


<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/signUpForm.css" />
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.6.0.min.js" >

</script>


<main class="text-center form-signin">
	<form  action="SignUpReg?email=${email }" name="frm" method="post" >
	<h1 class="h3 mb-3 fw-normal">회원 가입</h1>
		<div class="form-floating">
	    <input type="text" name="user_id" class="form-control" id="user_id" onkeydown="inputIdCheck()" placeholder="아이디">
	       <label for="user_id">아이디</label>
	    </div>
	    <input type="hidden" name="idDuplication" value="idUncheck">
	    <div style="margin-bottom:20px;">
			<button class="w-100 btn btn-lg btn-primary" type="button" onclick="idTest()" >아이디체크</button>
		</div>
	    <div class="form-floating">
		    <input type="password" name="user_pw" class="form-control" id="user_pw" placeholder="비밀번호">
		    <label for="pwd">비밀번호</label>
		</div>
		<div class="form-floating">
		    <input type="password" name="user_pw2" class="form-control" id="user_pw2" placeholder="비밀번호 확인">
		    <label for="user_pw2">비밀번호 확인</label>
		</div>
		<div class="form-floating">
	       <input type="text" name="name" class="form-control" id="name" placeholder="이름">
	       <label for="name">이름</label>
	    </div>
		<div class="form-floating">
			<input type="date" name="birthdate" class="form-control" id="currentDate" placeholder="생일">
	       	<label for="birthdate">생일</label>
		</div>
		<div class="form-check form-check-inline">
		  <input class="form-check-input" type="radio" name="gender" id="inlineRadio1" value="m" checked>
		  <label class="form-check-label" for="inlineRadio1">남성</label>
		</div>
		<div class="form-check form-check-inline">
		  <input class="form-check-input" type="radio" name="gender" id="inlineRadio2" value="f">
		  <label class="form-check-label" for="inlineRadio2">여성</label>
		</div>
		
		<div class="form-floating">
			<input type="text" name="email" value='${email }' class="form-control" id="email" placeholder="이메일" readonly>
	    		<label for="email">이메일</label>
		</div>
		
		<div class="form-floating">
			<input type="text" name="zip_code" class="form-control" id="member_post" placeholder="주소 입력" readonly onclick="findAddr()">
			<label for="addr">우편번호(클릭)</label>
		</div>
		<div class="form-floating">
			<input type="text" name="addr1" class="form-control" id="member_addr" placeholder="주소 입력" readonly onclick="findAddr()">
			<label for="addr">주소</label>
		</div>
		<div class="form-floating">
			<input type="text" name="addr2" class="form-control"  placeholder="상세 주소" >
			<label for="addr">상세주소</label>
		</div>
		<div class="container" >
			<div class="row" >
				<div class="col">
					<select class="form-control" name = "tel1" id="tel1" display="inline-block">
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="017">017</option>	
						<option value="019">019</option>
					</select>
				</div>
				<div class="col">
					<input type="text" class="form-control" id="tel2" name="tel2" placeholder="예)1234" />
				</div>
				<div class="col">
					<input type="text" class="form-control" name="tel3" id="tel3" placeholder="예)1234" />
				</div>
			</div>
		</div>
		<button class="w-100 btn btn-lg btn-primary" type="button" onclick="checkform()" >회원가입</button>
	</form>
</main>


<script>

	function idTest(){
		
		var form = document.frm;
		
		var userId = form.user_id.value;
		
		//alert(userId);
		
		 $(function(){        ///windows.onload=function(){} 과 같음
		        $.ajax('IdCheck?id='+userId,{    ////접근할 주소
		            
		            success: function(data){    ///ajax 성공 리스너 
		             
		            	var msg = "사용가능";
		            	if(data==1){///data로 html 값을 받아옴
		               msg = "아이디 중복";
		            	}else{
		            		document.frm.idDuplication.value = "idCheck";
		            	}
		            	alert(msg);
		            },
		            
		            error:function(e){    ///실패 리스너
		                alert(e.responseText);///에러메세지
		            }
		        })
		    });
	}
	

  document.getElementById('currentDate').value = new Date().toISOString().substring(0, 10);

  function findAddr(){
  	new daum.Postcode({
          oncomplete: function(data) {
          	
          	console.log(data);
          	
              // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
              // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
              // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
              var roadAddr = data.roadAddress; // 도로명 주소 변수
              var jibunAddr = data.jibunAddress; // 지번 주소 변수
              // 우편번호와 주소 정보를 해당 필드에 넣는다.
              document.getElementById('member_post').value = data.zonecode;
              if(roadAddr !== ''){
                  document.getElementById("member_addr").value = roadAddr;
              } 
              else if(jibunAddr !== ''){
                  document.getElementById("member_addr").value = jibunAddr;
              }
          }
      }).open();
  }
  
  // 중복체크 이후 아이디 변경시 다시 확인하도록
  function inputIdCheck(){
	  document.frm.idDuplication.value = "idUncheck";
  }
  
  //유효성검사
  function checkform() {
	  var spacing =  /\s/g; // 띄어쓰기 체크
		var newLine =  /\n/g; // 개행문자 체크 (제거로 만들자) 
		
		
		var form = document.frm;
		
		var userId = form.user_id.value;
		var userPw = form.user_pw.value;
		var userPw2 = form.user_pw2.value;
		var uName = form.name.value;
		var uAddr2 = form.addr2.value;
		var uTel2 = form.tel2.value;
		var uTel3 = form.tel3.value;
		
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
		
		if(form.idDuplication.value != 'idCheck'){
			alert("아이디 중복체크를 눌러주세요.");
		    return false;
		}
		
		
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
		
		var regExpPw = /^[A-Za-z\d$@$!%*#?&]{8,15}$/; //최소 8자리, 최대 15자리.
		if(!regExpPw.test(userPw)){
			alert("비밀번호는 영어,숫자,특수문자가 한글자 이상 들어가야 합니다. (최소 8글자, 최대 15글자)");
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
		
		if(uName == ""){
			alert("이름을 입력하세요.");
		    form.name.select;
		    return false;
		}
		
		if(spacing.test(uName)){
			alert("이름에는 빈 칸이 없어야 합니다");
			form.name.select;
		    return false;
		}
		
		var regExpName = /^[가-힣a-zA-Z]{2,10}$/; //이름. 한글, 영어만 가능
		if(!regExpName.test(uName)){
			alert("이름은 한글과 영어만 가능합니다. (최소 2글자 최대 10글자)");
			form.name.select;
		    return false;
		}
		
		var regExpAddr2 = /^[가-힣a-zA-Z\d\s]{0,30}$/; //주소
		if(!regExpAddr2.test(uAddr2)){
			alert("주소는 한글과 영어, 숫자만 입력 가능합니다. (최대 30글자)");
			form.addr2.select;
		    return false;
		}
		
		if(uTel2 == ""){
			alert("전화번호를 입력해주세요");
		    form.tel2.select;
		    return false;
		}
		
		if(spacing.test(uTel2)){
			alert("전화번호에는 빈 칸이 없어야 합니다");
			form.tel2.select;
		    return false;
		}
		
		var regExpTel2 = /^[0-9]{4}$/; //숫자만 가능. 4자리
		if(!regExpTel2.test(uTel2)){
			alert("전화번호는 4자리의 숫자만 입력 가능합니다.");
			form.tel2.select;
		    return false;
		}
		
		if(uTel3 == ""){
			alert("전화번호를 입력해주세요");
		    form.tel3.select;
		    return false;
		}
		
		if(spacing.test(uTel3)){
			alert("전화번호에는 빈 칸이 없어야 합니다");
			form.tel3.select;
		    return false;
		}
		var regExpTel3 = /^[0-9]{4}$/; //숫자만 가능. 4자리
		if(!regExpTel3.test(uTel3)){
			alert("전화번호는 4자리의 숫자만 입력 가능합니다.");
			form.tel3.select;
		    return false;
		}

		form.submit();

	}
</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

