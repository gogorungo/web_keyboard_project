<%@page import="model.notice.NoticeDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Arrays"%>
<%@page import="model.order.OrderDTO"%>
<%@page import="model.item.itemDTO"%>
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
	pageContext.setAttribute("memberNo",memberNo);
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
			<h2 class="display-4">메인페이지 관리</h2>
			<a href="./AddMainItem"><button class="btn btn-warning" type="button">메인 페이지 상품 추가</button></a>
			<a href="./AddMainNotice"><button class="btn btn-warning" type="button">메인 페이지 공지 관리</button></a>
		</div>
	</div>
	<div class="container">
		<div class="accordion" id="accordionExample">
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingOne">
					<button class="accordion-button" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapseOne"
						aria-expanded="true" aria-controls="collapseOne">추천상품 리스트 ${GList.size() }개</button>
				</h2>
				<div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
					<div class="accordion-body">
						<form action="./RemoveMainItem?" method="get">
						<table class="table table-striped">
							<tr>
								<th></th>
								<th>상품 번호</th>
								<th>상품명</th>
								<th>재고</th>
								<th>가격</th>
								<th>등록일</th>
								<th>처리</th>
							</tr>
							<%
								ArrayList<itemDTO> GList = (ArrayList<itemDTO>) request.getAttribute("GList");
							for (int i = 0; i < GList.size(); i++) { // 상품 리스트 하나씩 출력하기
								itemDTO item = GList.get(i);
							%>
							<c:set var="imgthumb" value="<%=item.getItem_img1()%>" />
							<input type="hidden" name="itemNo" value="<%=item.getItemNo()%>">
							<input type="hidden" name="status" value="추천상품">
							<tr>
								<td><img src="<c:url value="/source/${imgthumb }"/>" alt=""
									width=150 height=150 /></td>
								<td><%=item.getItemNo()%></td>
								<td><%=item.getItem_name()%></td>
								<td><%=item.getStock()%></td>
								<td><%=item.getPrice()%></td>
								<td><%=item.getReg_date()%></td>
								<td>
									<button type="submit" class="btn btn-danger">상품 내리기</button>
								</td>
							</tr>
							<%
								}
							%>
						</table>
						</form>
					</div>
				</div>
			</div>
			<div class="accordion-item">
				<h2 class="accordion-header" id="headingTwo">
					<button class="accordion-button" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapseTwo"
						aria-expanded="true" aria-controls="collapseTwo">신상품 리스트 ${NList.size() }개</button>
				</h2>
				<div id="collapseTwo" class="accordion-collapse collapse show" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
					<div class="accordion-body">
						<form action="./RemoveMainItem?" method="get">
						<table class="table table-striped">
							<tr>
								<th></th>
								<th>상품 번호</th>
								<th>상품명</th>
								<th>재고</th>
								<th>가격</th>
								<th>등록일</th>
								<th>처리</th>
							</tr>
							<%
								ArrayList<itemDTO> NList = (ArrayList<itemDTO>) request.getAttribute("NList");
							for (int i = 0; i < NList.size(); i++) { // 상품 리스트 하나씩 출력하기
								itemDTO item = NList.get(i);
							%>
							<input type="hidden" name="itemNo" value="<%=item.getItemNo()%>">
							<input type="hidden" name="status" value="신상품">
							<c:set var="imgthumb" value="<%=item.getItem_img1()%>" />
							<tr>
								<td><img src="<c:url value="/source/${imgthumb }"/>" alt="" width=150 height=150 /></td>
								<td><%=item.getItemNo()%></td>
								<td><%=item.getItem_name()%></td>
								<td><%=item.getStock()%></td>
								<td><%=item.getPrice()%></td>
								<td><%=item.getReg_date()%></td>
								<td>
									<button type="submit" class="btn btn-danger" onclick='./RemoveMainItem?id=${itemNo }&status=신상품'>상품 내리기</button>
								</td>
							</tr>
							<%
								}
							%>
						</table>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>


</body>
</html>