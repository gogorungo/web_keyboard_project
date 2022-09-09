<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
pageContext.setAttribute("memberNo", memberNo);
%>

<link href="../css/notice.css" rel="stylesheet" type="text/css">
<div class="container-box">
<div class="alert alert-success" role="alert">
<h2 align="center">공지사항을 적는 부분입니다 :-)</h2>
</div>

<script>
function checkEmpty() {
	var form = document.notice;
	if (form.subject.value == "") {
		alert("제목을 입력하세요.");
		form.subject.focus();
		return false;
	} else if (form.content.value == ""){
		alert("내용을 입력하세요.");
		form.content.focus();
		return false;
		}
	form.submit();
	}
</script>

<form action="./NoticeInsertReg" method="post" name="notice" class="row g-3 needs-validation" novalidate>
	<input type="hidden" name="pname" value="관리자" />
	<input type="hidden" name="user_id" value="${dto.user_id }">
	
	 <div class="col-md-9">
    <label for="validationServer01" class="form-label">제목</label>
    <input type="text" class="form-control" id="validationCustom01" placeholder="제목을 입력하세요." name="subject" required>
    <div class="invalid-feedback">
      제목을 입력해주세요.
    </div>
  </div>
	
	<div class="col-md-5">
		<label for="exampleFormControlInput1" class="form-label">작성자</label>
		<input type="text" class="form-control" id="exampleFormControlInput1"
			value="관리자" disabled="disabled">
	</div>
	<div class="mb-3">
		<label for="validationServer02" class="form-label">내용</label>
		<textarea class="form-control" id="exampleFormControlTextarea1"
			rows="20" placeholder="내용을 입력하세요." name="content" required></textarea>
			<div class="invalid-feedback">
      내용을 입력해주세요.
    </div>
	</div>
	<div class="btn-group" role="group" aria-label="Basic example">
	<button type="reset" class="btn btn-warning">초기화</button>
	<button type="button" class="btn btn-primary" onclick="checkEmpty()">작성하기</button>
	<button type="button" class="btn btn-secondary" onclick="location='NoticeList'">목록으로</button>
	</div>
</form>
	</div>