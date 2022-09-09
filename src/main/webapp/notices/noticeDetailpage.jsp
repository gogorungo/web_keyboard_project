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
pageContext.setAttribute("memberNo", memberNo);
%>

<link href="../css/notice.css" rel="stylesheet" type="text/css">
<div class="container-box">
<div class="alert alert-success" role="alert">
<h2 align="center">공지</h2>
</div>
<form name="noticeDetail" class="row g-3 needs-validation" novalidate>
	
	 <div class="col-md-9">
    <label for="validationServer01" class="form-label">제목</label>
    <input type="text" class="form-control" id="validationCustom01" value="${dto.subject }" name="subject" disabled="disabled">
  </div>
	
	<div class="col-md-5">
		<label for="exampleFormControlInput1" class="form-label">작성자</label>
		<input type="text" class="form-control" id="exampleFormControlInput1"
			value="${dto.pname }" disabled="disabled">
	</div>
	<div class="mb-3">
		<label for="validationServer02" class="form-label">내용</label>
		<textarea class="form-control" id="exampleFormControlTextarea1"
			rows="20" name="content" disabled="disabled">${dto.content }</textarea>
	</div>
	<div class="btn-group" role="group" aria-label="Basic example">
	<%
	if(userStatus != null){
		if(userStatus.equals("관리자")){
%>
	<button type="button" class="btn btn-warning" onclick="location='./NoticeModifyForm?noticeNo=${dto.noticeNo }'">수정하기</button>
	<%}}%>
	<button type="button" class="btn btn-secondary" onclick="location='NoticeList'">목록으로</button>
	</div>
</form>
	</div>
