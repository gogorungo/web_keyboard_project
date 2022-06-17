<%@page import="model.order.OrderDAO"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Arrays"%>
<%@page import="model.order.OrderDTO"%>
<%@page import="java.util.ArrayList"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		<jsp:param name="URL" value="member"/>
	</jsp:include>
	<div class="jumbotron">
		<div class="container">
			<h5 class="display-4">${name } 조회</h5>
		</div>
	</div>
	<div class="container">
		<div class="accordion" id="accordionPanelsStayOpenExample">
			<div class="accordion-item">
				<h2 class="accordion-header" id="panelsStayOpen-headingOne">
					<button class="accordion-button" type="button"
						data-bs-toggle="collapse"
						data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true"
						aria-controls="panelsStayOpen-collapseOne">${name }님의 주문
						${mainList.size() }건</button>
				</h2>
				<div id="panelsStayOpen-collapseOne"
					class="accordion-collapse collapse show"
					aria-labelledby="panelsStayOpen-headingOne">
					<div class="accordion-body">
						<table class="table table-striped">
							<tr>
								<th></th>
								<th>주문번호</th>
								<th>주문자 이름</th>
								<th>주문날짜</th>
								<th>총 가격</th>
								<th>총 수량</th>
								<th>처리</th>
								<th>상세보기</th>
							</tr>
							<%
								ArrayList<OrderDTO> mainList = (ArrayList<OrderDTO>) request.getAttribute("mainList");
							for (int i = 0; i < mainList.size(); i++) { // 상품 리스트 하나씩 출력하기
								OrderDTO item = mainList.get(i);
							%>
							<tr>
								<c:set var="orderNum" value="<%=item.getOrdered_num()%>" />
								<td></td>
								<td><%=item.getOrdered_num()%></td>
								<td><%=item.getName()%></td>
								<td><%=item.getDate_format(item.getOrdered_date())%></td>
								<td><%=item.getPrice()%></td>
								<td><%=item.getSelect_count()%></td>
								<td><%=item.getStatus()%></td>
								<td>
									<button type="button" class="btn btn-outline-primary"
										onclick='location.href="../admin/OrderView?orderNum=${orderNum }";'>상세보기</button>
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