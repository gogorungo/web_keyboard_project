<%@page import="model.comment.CommentDAO"%>
<%@page import="model.qna.QnaDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Arrays"%>
<%@page import="model.order.OrderDTO"%>
<%@page import="model.notice.NoticeDTO"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
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
<style type="text/css">
td {
	vertical-align: middle !important;
	text-align: center !important;
}
input {
	width: 100%;
	text-align: center !important;
}
</style>
<title>관리자 페이지</title>
</head>
<body>
	<jsp:include page="../Admintop.jsp" >
		<jsp:param name="URL" value="qna"/>
	</jsp:include>
	<div class="jumbotron">
		<div class="container">
			<h2 class="display-3">고객센터 관리</h2>
		</div>
	</div>
	<div class="container">
		<div class="accordion" id="accordionExample">
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingOne">
					<button class="accordion-button" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapseOne"
						aria-expanded="true" aria-controls="collapseOne">
						게시된 문의사항 ${PostList.size() }개</button>
				</h2>
				<div id="collapseOne" class="accordion-collapse collapse show"
					aria-labelledby="headingOne" data-bs-parent="#accordionExample">
					<div class="accordion-body">
						<table class="table">
							<tr>
								<th></th>
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>조회수</th>
								<th>작성일</th>
								<th>처리</th>
							</tr>
							<%
								ArrayList<QnaDTO> PostList = (ArrayList<QnaDTO>) request.getAttribute("PostList");
							for (int i = 0; i < PostList.size(); i++) { // 상품 리스트 하나씩 출력하기
								QnaDTO item = PostList.get(i);
							%>
							<tr>
								<td></td>
								<td><%=item.getQnaNo()%></td>
								<td><%=item.getSubject()%></td>
								<td><%=item.getPname()%></td>
								<td><%=item.getHits() %></td>
								<td><fmt:formatDate value="<%=item.getReg_date() %>" pattern="yyyy-MM-dd HH:mm" /></td>
								<td>
									<button type="button" class="btn btn-outline-primary" onclick="location='../qna/QnaDetail?qnaNo=<%=item.getQnaNo()%>'">답변하기</button>
									<button type="button" class="btn btn-outline-danger" onclick="location='../qna/RemoveQna?qnaNo=<%=item.getQnaNo()%>'">삭제하기</button>
								</td>
							</tr>
							<%
								}
							%>
						</table>
					</div>
				</div>
			</div>
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingTwo">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapseTwo"
						aria-expanded="false" aria-controls="collapseTwo">
						답변된 문의사항 ${EndList.size() }개</button>
				</h2>
				<div id="collapseTwo" class="accordion-collapse collapse"
					aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
					<div class="accordion-body">
						<table class="table">
							<tr>
								<th></th>
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>조회수</th>
								<th>작성일</th>
								<th>처리</th>
							</tr>
							<%
								ArrayList<QnaDTO> EndList = (ArrayList<QnaDTO>) request.getAttribute("EndList");
							for (int i = 0; i < EndList.size(); i++) { // 상품 리스트 하나씩 출력하기
								QnaDTO item = EndList.get(i);
							%>
							<tr>
								<td></td>
								<td><%=item.getQnaNo()%></td>
								<td><%=item.getSubject()%></td>
								<td><%=item.getPname()%></td>
								<td><%=item.getHits() %></td>
								<td><fmt:formatDate value="<%=item.getReg_date() %>" pattern="yyyy-MM-dd HH:mm" /></td>
								<td>
									<button type="button" class="btn btn-success" onclick="location='../qna/QnaDetail?qnaNo=<%=item.getQnaNo()%>'">답변완료</button>
								</td>
							</tr>
							<%
								}
							%>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>