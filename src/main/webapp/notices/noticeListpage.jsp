<%@page import="model.member.memberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
<br>
<div class="container-box">
<div class="alert alert-success" role="alert">
<h2 align="center">공지</h2>
</div>
<table class="table">
	<thead>
		<tr align="center">
			<th scope="col">번호</th>
			<th scope="col">제목</th>
			<th scope="col">작성자</th>
			<th scope="col">작성일</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="dto" items="${noticeData }" varStatus="no">
			<tr align="center">
				<td>${dto.noticeNo}</td>
				<td><a href="<c:url value="./NoticeDetail?noticeNo=${dto.noticeNo }&page=${nowPage }"/>" style="text-decoration: none; color: black;">${dto.subject }</a></td>
				<td style="color: green">${dto.pname }</td>
				<td><fmt:formatDate value="${dto.reg_date }"
						pattern="yyyy-MM-dd HH:mm" /></td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<div align="center">
	<c:if test="${pageStart>1 }">
		<a href="<c:url value="/notice/NoticeList?page=${pageStart-1 }"/>">[이전]</a>
	</c:if>
	<c:forEach var="i" begin="${pageStart }" end="${pageEnd }" step="1">
		<c:choose>
			<c:when test="${nowPage==i }">
			[${i }]
			</c:when>
			<c:otherwise>
				<a href="<c:url value="/notice/NoticeList?page=${i }"/>">${i }</a>
			</c:otherwise>

		</c:choose>

	</c:forEach>
	<c:if test="${pageEnd<pageTotal }">
		<a href="<c:url value="/notice/NoticeList?page=${pageEnd+1 }"/>">[다음]</a>
	</c:if>
</div>

<%
	if(userStatus != null){
		if(userStatus.equals("관리자")){
%>
<div class="d-grid gap-2 d-md-flex justify-content-md-end">
	<a href="./noticeInsertpage">
		<button type="button" class="btn btn-outline-success">글쓰기</button>
	</a>
</div>
<%}}%>

</div>