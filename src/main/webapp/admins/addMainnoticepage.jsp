<%@page import="model.main.MainNoticeDAO"%>
<%@page import="model.main.MainNoticeDTO"%>
<%@page import="model.notice.NoticeDAO"%>
<%@page import="model.notice.NoticeDTO"%>
<%@page import="model.item.itemDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Arrays"%>
<%@page import="model.order.OrderDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
pageContext.setAttribute("memberNo", memberNo);
%>
<style type="text/css">
td {
	vertical-align: middle !important;
	text-align: center !important;
}
</style>
<title>관리자 페이지</title>
</head>
<body>
	<jsp:include page="../Admintop.jsp" >
		<jsp:param name="URL" value="Mainpage"/>
	</jsp:include>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-4">메인페이지 공지 추가</h1>
		</div>
	</div>

	<div class="container">
		<div class="accordion" id="accordionExample">
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingOne">
					<button class="accordion-button" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapseOne"
						aria-expanded="true" aria-controls="collapseOne">공지사항 목록</button>
				</h2>
				<div id="collapseOne" class="accordion-collapse collapse show"
					aria-labelledby="headingOne" data-bs-parent="#accordionExample">
					<div class="accordion-body">
						<table class="table table-striped">
							<tr>
								<th></th>
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>등록일</th>
								<th>추가여부</th>
							</tr>
							<%
							ArrayList<NoticeDTO> AllNoticeList = (ArrayList<NoticeDTO>) request.getAttribute("AllNoticeList");
							for (int i = 0; i < AllNoticeList.size(); i++) { // 상품 리스트 하나씩 출력하기
								NoticeDTO item = AllNoticeList.get(i);
							%>
							<tr>
								<td></td>
								<td><%=item.getNoticeNo()%></td>
								<td><%=item.getSubject()%></td>
								<td><%=item.getPname()%></td>
								<td><fmt:formatDate value="<%=item.getReg_date()%>"
										pattern="yyyy-MM-dd HH:mm" /></td>
								<td>
									<button type="button" class="btn btn-secondary"
										onclick="location='./AddMainNoticeReg?noticeNo=<%=item.getNoticeNo()%>'">주요공지로 추가</button>
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
						aria-expanded="false" aria-controls="collapseTwo">게시된 공지사항</button>
				</h2>
				<div id="collapseTwo" class="accordion-collapse collapse"
					aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
					<div class="accordion-body">
						<table class="table table-striped">
							<tr>
								<th></th>
								<th>번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>등록일</th>
								<th>추가여부</th>
							</tr>
							<%
							ArrayList<MainNoticeDTO> mainPostList = (ArrayList<MainNoticeDTO>) request.getAttribute("mainPostList");
							for (int i = 0; i < mainPostList.size(); i++) { // 상품 리스트 하나씩 출력하기
								MainNoticeDTO item = mainPostList.get(i);
							%>
							<tr>
								<td></td>
								<td><%=item.getNoticeNo()%></td>
								<td><%=item.getSubject()%></td>
								<td><%=item.getPname()%></td>
								<td><fmt:formatDate value="<%=item.getReg_date()%>"
										pattern="yyyy-MM-dd HH:mm" /></td>
								<td>
									<button type="submit" class="btn btn-danger" onclick="location='./RemoveMainNotice?noticeNo=<%=item.getNoticeNo()%>'">주요공지 내리기</button>
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