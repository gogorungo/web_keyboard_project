<%@page import="model.qna.QnaDTO"%>
<%@page import="model.comment.CommentDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.comment.CommentDTO"%>
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

pageContext.setAttribute("memberNo", memberNo);

int no = qDTO.getQnaNo();
ArrayList<CommentDTO> dataQnoList = new CommentDAO().qnaNoList(no);
request.setAttribute("commentDataList", dataQnoList);

int count = new CommentDAO().answerCount(no);
%>
<link href="../css/qna.css" rel="stylesheet" type="text/css">
<div class="container-box">
<div class="alert alert-warning" role="alert">
<h2 align="center">고객센터</h2>
</div>
<form name="qnaDetail" class="row g-3 needs-validation" novalidate>

<div class="col-md-4">
	<label for="exampleFormControlInput1" class="form-label">제목</label>
	<input type="text" class="form-control" id="exampleFormControlInput1" value="${dto.subject }" disabled="disabled">
</div>
<div class="col-md-5">
	<label for="exampleFormControlInput1" class="form-label">번호</label>
	<input type="text" class="form-control" id="exampleFormControlInput1" value="${dto.qnaNo}" disabled="disabled">
</div>
<div class="col-md-7">
	<label for="exampleFormControlInput1" class="form-label">작성자</label>
	<input type="text" class="form-control" id="exampleFormControlInput1" value="${dto.pname }" disabled="disabled">
</div>
<div class="col-md-2">
	<label for="exampleFormControlInput1" class="form-label">작성일</label>
	<input type="text" class="form-control" id="exampleFormControlInput1" value="<fmt:formatDate value="${dto.reg_date }" pattern="yyyy-MM-dd HH:mm" />"
		disabled="disabled">
</div>
<div class="mb-3">
	<label for="exampleFormControlInput1" class="form-label">주문번호</label>
	<input type="text" class="form-control" id="exampleFormControlInput1" value="${dto.ordered_num }" disabled="disabled">
</div>
<div class="mb-3">
	<label for="exampleFormControlTextarea1" class="form-label">내용</label>
	<textarea class="form-control" id="exampleFormControlTextarea1"
		rows="20" disabled="disabled">${dto.content }</textarea>
</div>

<div class="btn-group" role="group" aria-label="Basic example">
<c:if test="${inUser != null && inUser.user_id == dto.user_id }">
		<button type="button" class="btn btn-warning" onclick="location='./QnaModifyForm?qnaNo=${dto.qnaNo }'">수정하기</button>
</c:if>
<%
if (userStatus != null) {
	if (userStatus.equals("관리자")) {
%>
	<button type="button" class="btn btn-success" onclick="location='../comment/commentInsertpage'">답변하기</button>
<%
}
}
%>
<button type="button" class="btn btn-secondary" onclick="location='QnaList'">목록으로</button>
</div>
</form>
</div>

<%
if(count > 0){
%>
<c:forEach var="dto" items="${commentDataList }" varStatus="no">
<div class="container-box">
<div class="alert alert-success" role="alert">
<h2 align="center">댓글</h2>
</div>
<form name="qnaDetail" class="row g-3 needs-validation" novalidate>
<div class="mb-3">
	<label for="exampleFormControlInput1" class="form-label">제목</label>
	<input type="text" class="form-control" id="exampleFormControlInput1" value="${dto.subject }" disabled="disabled">
</div>
<div class="col-md-7">
	<label for="exampleFormControlInput1" class="form-label">작성자</label>
	<input type="text" class="form-control" id="exampleFormControlInput1" value="${dto.pname }" disabled="disabled">
</div>
<div class="col-md-7">
	<label for="exampleFormControlInput1" class="form-label">작성일</label>
	<input type="text" class="form-control" id="exampleFormControlInput1" value="<fmt:formatDate value="${dto.reg_date }" pattern="yyyy-MM-dd HH:mm" />"
		disabled="disabled">
</div>
<div class="mb-3">
	<label for="exampleFormControlTextarea1" class="form-label">내용</label>
	<textarea class="form-control" id="exampleFormControlTextarea1"
		rows="20" disabled="disabled">${dto.comment }</textarea>
</div>

<div class="btn-group" role="group" aria-label="Basic example">
<%
if (userStatus != null) {
	if (userStatus.equals("관리자")) {
%>
		<button type="button" class="btn btn-warning" onclick="location='../comment/CommentModifyForm?commentNo=${dto.commentNo }'">수정하기</button>
	<%}} %>
	<button type="button" class="btn btn-secondary" onclick="location='QnaList'">목록으로</button>
	</div>
</form>
</div>
</c:forEach>
<%	
}
%>
