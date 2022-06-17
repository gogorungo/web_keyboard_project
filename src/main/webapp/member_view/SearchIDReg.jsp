<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/signUpForm.css" />

<body class="text-center">
	<main class="form-signin">
		<form action="./LoginReg" name="frm" method="post">
		<h1 class="h3 mb-3 fw-normal">아이디 찾기 결과 <br><br><br>${userID }</h1>
		<button type="button"
				class="btn btn-outline-primary" onclick="location.href='Login'">로그인으로 돌아가기</button>
		</form>
	</main>
</body>

