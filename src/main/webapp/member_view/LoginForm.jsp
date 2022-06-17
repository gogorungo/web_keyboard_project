<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="model.member.memberDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

<body class="text-center">
	<main class="form-signin">
		<form action="./LoginReg" name="frm" method="post">
			<h1 class="h3 mb-3 fw-normal">로그인</h1>
			<div class="form-floating">
		       <input type="text" name="member_id" class="form-control" id="member_id" placeholder="ID" >
		       <label for="member_id">아이디</label>
		    </div>
		    <div class="form-floating">
			    <input type="password" name="member_pw" class="form-control" id="member_pw" placeholder="Password">
			    <label for="member_pw">비밀번호</label>
			</div>
			<button class="w-100 btn btn-lg btn-primary" type="button" onclick="javascript:checkLogin()" >로그인</button>
			<div class="form-button">
				<button type="button"
				class="btn btn-outline-primary" onclick="location.href='SignUp'">회원가입</button>
				<button type="button"
				class="btn btn-outline-primary" onclick="location.href='SearchIDForm'">아이디 찾기</button>
				<button type="button"
				class="btn btn-outline-primary" onclick="location.href='SearchPWForm'">비밀번호 찾기</button>
			</div>
		</form>
	</main>
</body>

<script type="text/javascript">

	function checkLogin() {
		// * : 0개 이상 반복되는지
		// $ : 그 패턴으로 끝이 나는지
 		var spacing =  /\s/g; // 띄어쓰기 체크
		var newLine =  /\n/g; // 개행문자 체크 (제거로 만들자) 
		
		
		var form = document.frm;
		
		var userId = form.member_id.value;
		var userPw = form.member_pw.value;
		
		if(userId == ""){
			alert("아이디를 입력하세요.");
		    form.member_id.select;
		    return false;
		}
		
		if(spacing.test(userId)){
			alert("빈 칸이 없어야 합니다");
			form.member_id.select;
		    return false;
		}
		
 		if(newLine.test(userId)){
			alert("입력에러. 다시 입력해주세요.");
			form.member_id.select;
		    return false;
		}
		
 		var regExpId = /^[a-zA-Z0-9]{2,10}$/; //id 체크 영문, 숫자만 가능
		if(!regExpId.test(userId)){
			alert("아이디는 영어와 숫자만 입력 가능합니다. (최소 2글자 최대 10글자)");
			form.member_id.select;
		    return false;
		}
		
 		if(userPw == ""){
			alert("비밀번호를 입력하세요.");
			form.member_pw.select;
		    return false;
		}
		
 		if(spacing.test(userPw)){
			alert("빈 칸이 없어야 합니다");
			form.member_pw.select;
		    return false;
		}
		
		if(newLine.test(userPw)){
			alert("입력에러. 다시 입력해주세요.");
			form.member_pw.select;
		    return false;
		}
		
		var regExpPw = /^[A-Za-z\d@!%*#?&]{4,15}$/; //최소 8자리, 최대 15자리.
		if(!regExpPw.test(userPw)){
			alert("비밀번호는 영어,숫자,특수문자사용 가능합니다.(특수문자는 @!%*#?& 만 사용가능) (최소 4글자, 최대 15글자)");
			form.member_pw.select;
		    return false;
		}

		form.submit();

	}

</script>