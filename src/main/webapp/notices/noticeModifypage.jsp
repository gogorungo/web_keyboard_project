<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<link href="../css/notice.css" rel="stylesheet" type="text/css">
<div class="container-box">
<div class="alert alert-success" role="alert">
<h2 align="center">공지사항을 수정하는 부분입니다</h2>
</div>

<script>
function checkEmpty() {
	var form = document.noticeModify;
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
<!-- <div class="container"> -->
<form action="./NoticeModifyReg" method="post" name="noticeModify" class="row g-3 needs-validation" novalidate>
	<input type="hidden" name="noticeNo" value="${dto.noticeNo }" />
	<input type="hidden" name="pname" value="관리자" />

	<%-- <div class="col-md-6">
		<label for="exampleFormControlInput1" class="form-label">번호</label>
		<input type="text" class="form-control" id="exampleFormControlInput1"
			value="${dto.noticeNo}" disabled="disabled">
	</div> --%>
	<div class="col-md-9">
		<label for="exampleFormControlInput1" class="form-label">제목</label>
		<input type="text" class="form-control" id="exampleFormControlInput1"
			value="${dto.subject }" name="subject">
	</div>
	<div class="col-md-5">
		<label for="exampleFormControlInput1" class="form-label">작성자</label> 
		<input type="text" class="form-control" id="exampleFormControlInput1"
			value="관리자" disabled="disabled">
	</div>
	<div class="mb-3">
		<label for="exampleFormControlTextarea1" class="form-label">내용</label>
		<textarea class="form-control" id="exampleFormControlTextarea1"
			rows="20" name="content">${dto.content }</textarea>
	</div>
<div class="btn-group" role="group" aria-label="Basic example">
	<button type="reset" class="btn btn-warning">초기화</button>
	<button type="button" class="btn btn-primary" onclick="checkEmpty()">수정하기</button>
	<button type="button" class="btn btn-secondary" onclick="location='NoticeList'">목록으로</button>
	</div>
</form>
<!-- </div> -->
</div>