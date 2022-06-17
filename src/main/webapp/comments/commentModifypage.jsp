<%@page import="model.qna.QnaDTO"%>
<%@page import="model.member.memberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<meta charset="UTF-8">
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%	
	int memberNo;
	HttpSession user = request.getSession();
	String userStatus = null;
	memberDTO dto = (memberDTO) user.getAttribute("inUser");
	QnaDTO qDTO = (QnaDTO) user.getAttribute("qnaNum");
	if (dto != null) {
		userStatus = dto.getStatus();
		memberNo = dto.getMemberNo();
	} else {
		memberNo = 0;
	}
	pageContext.setAttribute("memberNo",memberNo);
	int no = qDTO.getQnaNo();
	request.setAttribute("no", no);
%>

<link href="../css/comment.css" rel="stylesheet" type="text/css">
<div class="container-box">
<div class="alert alert-success" role="alert">
<h2 align="center">댓글을 수정합니다</h2>
</div>

<script>
function checkEmpty() {
	var form = document.commentModify;
	if (form.subject.value == "") {
		alert("제목을 입력하세요.");
		form.subject.focus();
		return false;
	} else if (form.comment.value == ""){
		alert("내용을 입력하세요.");
		form.comment.focus();
		return false;
		}
	form.submit();
	}
</script>

<form action="./CommentModifyReg" method="post" name="commentModify" class="row g-3 needs-validation" novalidate>
	<input type="hidden" name="commentNo" value="${dto.commentNo }" />
	<input type="hidden" name="pname" value="${dto.pname }" />
	<input type="hidden" name="user_id" value="${dto.user_id }" />

	<div class="mb-3">
		<label for="exampleFormControlInput1" class="form-label">번호</label>
		<input type="text" class="form-control" id="exampleFormControlInput1" value="${dto.commentNo}" disabled="disabled">
	</div>
	<div class="mb-3">
		<label for="exampleFormControlInput1" class="form-label">제목</label>
		<input type="text" class="form-control" id="exampleFormControlInput1" value="${dto.subject }" name="subject">
	</div>
	<div class="mb-3">
		<label for="exampleFormControlInput1" class="form-label">작성자</label>
		<input type="text" class="form-control" id="exampleFormControlInput1" value="${dto.pname }" disabled="disabled">
	</div>
	<div class="mb-3">
		<label for="exampleFormControlTextarea1" class="form-label">내용</label>
		<textarea class="form-control" id="exampleFormControlTextarea1" rows="20" name="comment">${dto.comment }</textarea>
	</div>
		<div class="btn-group" role="group" aria-label="Basic example">
	<button type="reset" class="btn btn-warning">초기화</button>
	<button type="button" class="btn btn-primary" onclick="checkEmpty()">수정하기</button>
	<button type="button" class="btn btn-secondary" onclick="location='../qna/QnaDetail?qnaNo=${no}'">본문으로</button>
	</div>
</form>
</div>