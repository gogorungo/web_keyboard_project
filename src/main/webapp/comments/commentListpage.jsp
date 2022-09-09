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
<h1>댓글 리스트</h1>

<table class="table">
	<thead>
		<tr align="center" class="table-secondary">
			<th scope="col">번호</th>
			<th scope="col">제목</th>
			<th scope="col">작성자</th>
			<th scope="col">작성일</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="dto" items="${commentData }" varStatus="no">
			<tr align="center">
				<td>${dto.commentNo}</td>
				<td><a
					href="<c:url value="./CommentDetail?commentNo=${dto.commentNo }&page=${nowPage }"/>">${dto.subject }</a></td>
				<td>${dto.pname }</td>
				<td><fmt:formatDate value="${dto.reg_date }"
						pattern="yyyy-MM-dd HH:mm" /></td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<%
if (userStatus != null) {
	if (userStatus.equals("회원") || userStatus.equals("관리자")) {
%>
<div class="d-grid gap-2 d-md-flex justify-content-md-end">
	<a href="./commentInsertpage">
		<button type="button" class="btn btn-outline-primary">글쓰기</button>
	</a>
</div>
<%
}
}
%>
<div align="center">
	<c:if test="${pageStart>1 }">
		<a href="<c:url value="/comment/CommentList?page=${pageStart-1 }"/>">[이전]</a>
	</c:if>
	<c:forEach var="i" begin="${pageStart }" end="${pageEnd }" step="1">
		<c:choose>
			<c:when test="${nowPage==i }">
			[${i }]
			</c:when>
			<c:otherwise>
				<a href="<c:url value="/comment/CommentList?page=${i }"/>">${i }</a>
			</c:otherwise>
		</c:choose>

	</c:forEach>
	<c:if test="${pageEnd<pageTotal }">
		<a href="<c:url value="/comment/CommentList?page=${pageEnd+1 }"/>">[다음]</a>
	</c:if>
</div>
