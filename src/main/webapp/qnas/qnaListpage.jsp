<%@page import="model.member.memberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%	
	int memberNo;
	HttpSession user = request.getSession();
	String userStatus = null;
	memberDTO dto = (memberDTO) user.getAttribute("inUser");
	if (dto != null) {
		userStatus = dto.getStatus();
		memberNo = dto.getMemberNo();
	} else {
		memberNo = 0;
	}
	pageContext.setAttribute("memberNo",memberNo);
%>

<link href="../css/qna.css" rel="stylesheet" type="text/css">
<br>
<div class="container-box">
<div class="alert alert-warning" role="alert">
<h2 align="center">고객센터</h2>
</div>
<form name="qnaList" class="row g-3 needs-validation" novalidate>
<table class="table">
	<thead>
		<tr align="center">
			<th scope="col">번호</th>
			<th scope="col">제목</th>
			<th scope="col">상태</th>
			<th scope="col">작성자</th>
			<th scope="col">작성일</th>
		</tr>
	</thead>
	<tbody>
	<c:choose>
	<c:when test="${process eq '답변' }">
	<c:forEach var="dto" items="${answer }" varStatus="no">
			<tr align="center">
				<td>${dto.qnaNo}</td>
				<td><a href="<c:url value="./QnaDetail?qnaNo=${dto.qnaNo }&page=${nowPage }"/>">${dto.subject }</a></td>
				<td style="color: green">답변완료</td>
				<td>${dto.pname }</td>
				<td><fmt:formatDate value="${dto.reg_date }"
						pattern="yyyy-MM-dd HH:mm" /></td>
			</tr>
		</c:forEach>
	</c:when>
	<c:when test="${process eq '미답변' }">
	<c:forEach var="dto" items="${answer }" varStatus="no">
			<tr align="center">
				<td>${dto.qnaNo}</td>
				<td><a href="<c:url value="./QnaDetail?qnaNo=${dto.qnaNo }&page=${nowPage }"/>">${dto.subject }</a></td>
				<td style="color: orange">답변대기</td>
				<td>${dto.pname }</td>
				<td><fmt:formatDate value="${dto.reg_date }"
						pattern="yyyy-MM-dd HH:mm" /></td>
			</tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
		<c:forEach var="dto" items="${qnaDataTotal }" varStatus="no">
			<tr align="center">
				<td>${dto.qnaNo}</td>
				<td>
				<a href="<c:url value="./QnaDetail?qnaNo=${dto.qnaNo }&page=${nowPage }"/>">${dto.subject }</a>
				</td>
				<c:choose>
				<c:when test="${dto.answerCnt > 0 }"><td style="color: green">답변완료</td></c:when>
				<c:otherwise><td style="color: orange">답변대기</td></c:otherwise>
				</c:choose>
				<td>${dto.pname }</td>
				<td><fmt:formatDate value="${dto.reg_date }"
						pattern="yyyy-MM-dd HH:mm" /></td>
			</tr>
		</c:forEach>
		</c:otherwise>
		</c:choose>
	</tbody>
</table>

<div align="center">
	<c:if test="${pageStart>1 }">
		<a href="<c:url value="/qna/QnaList?page=${pageStart-1 }"/>">[이전]</a>
	</c:if>
	<c:forEach var="i" begin="${pageStart }" end="${pageEnd }" step="1">
		<c:choose>
			<c:when test="${nowPage==i }">
			[${i }]
			</c:when>
			<c:otherwise>
				<a href="<c:url value="/qna/QnaList?page=${i }"/>">${i }</a>
			</c:otherwise>

		</c:choose>

	</c:forEach>
	<c:if test="${pageEnd<pageTotal }">
		<a href="<c:url value="/qna/QnaList?page=${pageEnd+1 }"/>">[다음]</a>
	</c:if>
</div>

<div class="d-grid gap-2 d-md-flex justify-content-md-end">
<%
if (userStatus != null) {
	if (userStatus.equals("관리자")) {
%>
<!-- <div class="btn-group" role="group" aria-label="Basic example">
	<button type="button" class="btn btn-success" onclick="location='../qna/QnaListSwitch?qnaStatus=답변'">답변완료</button>
	<button type="button" class="btn btn-primary" onclick="location='./QnaList'">전체</button>
	<button type="button" class="btn btn-warning" onclick="location='../qna/QnaListSwitch?qnaStatus=미답변'">답변대기</button>
	</div> -->
	<div class="btn-group dropstart" role="group">
    <button id="btnGroupDrop1" type="button" class="btn btn-outline-success dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
      상태
    </button>
	<ul class="dropdown-menu" aria-labelledby="btnGroupDrop1">
      <li><a class="dropdown-item" href="./QnaList">전체</a></li>
      <li><a class="dropdown-item" href="../qna/QnaListSwitch?qnaStatus=답변">답변완료</a></li>
      <li><a class="dropdown-item" href="../qna/QnaListSwitch?qnaStatus=미답변">답변대기</a></li>
    </ul>
    </div>
<%
}
}
%>

<%
if (userStatus != null) {
	if (userStatus.equals("회원") || userStatus.equals("관리자")) {
%>
<div class="d-grid gap-2 d-md-flex justify-content-md-end">
	<a href="./qnaInsertpage">
		<button type="button" class="btn btn-outline-primary">글쓰기</button>
	</a>
</div>
</div>
<%
}
}
%>

</form>
</div>
