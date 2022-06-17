<%@page import="model.order.OrderDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<!DOCTYPE html>
<html>
<head>
<style type="text/css">
td {
	vertical-align: middle !important;
	text-align: center !important;
}
</style>
<meta charset="UTF-8">
<title>주문내역</title>
</head>
<body>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-4">취소 교환 반품내역</h1>
		</div>
	</div>
	<div class="container">
		<a href="./Order" class="btn btn-primary" style="margin-bottom: 20px;">주문 내역 보러가기</a>
		<!-- 탭 메뉴 -->
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link active" id="order-tab" data-bs-toggle="tab"
					data-bs-target="#order" type="button" role="tab"
					aria-controls="order" aria-selected="true">주문취소</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="shipping-tab" data-bs-toggle="tab"
					data-bs-target="#shipping" type="button" role="tab"
					aria-controls="shipping" aria-selected="false">반품</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="end-tab" data-bs-toggle="tab"
					data-bs-target="#end" type="button" role="tab" aria-controls="end"
					aria-selected="false">교환</button>
			</li>
		</ul>

		<!-- 내용 -->
		<div class="tab-content" id="myTabContent">
			<div class="tab-pane fade show active" id="order" role="tabpanel"
				aria-labelledby="order-tab">
				<table class="table table-striped">
					<tr>
						<th></th>
						<th>주문번호</th>
						<th>주문날짜</th>
						<th>총 가격</th>
						<th>총 수량</th>
						<th>상태</th>
					</tr>
					<%
						ArrayList<OrderDTO> mainList = (ArrayList<OrderDTO>) request.getAttribute("mainList");
						for (int i = 0; i < mainList.size(); i++) { 
							OrderDTO item = mainList.get(i);	
					%>
					<tr>
						<c:set var="orderNum" value="<%=item.getOrdered_num()%>" />
						<td></td>
						<td onClick='location.href="./OrderDetail?orderNum=${orderNum }";'><%=item.getOrdered_num()%></td>
						<td onClick='location.href="./OrderDetail?orderNum=${orderNum }";'><%=item.getDate_format(item.getOrdered_date()) %></td>
						<td onClick='location.href="./OrderDetail?orderNum=${orderNum }";'><%=item.getPrice() %></td>
						<td onClick='location.href="./OrderDetail?orderNum=${orderNum }";'><%=item.getSelect_count() %></td>
						<td onClick='location.href="./OrderDetail?orderNum=${orderNum }";'><%=item.getStatus() %></td>
					</tr>
					<%
						}
					%>
				</table>
			</div>
			<div class="tab-pane fade" id="shipping" role="tabpanel"
				aria-labelledby="shipping-tab">
				<table class="table table-striped">
					<tr>
						<th></th>
						<th>주문번호</th>
						<th>주문날짜</th>
						<th>총 가격</th>
						<th>총 수량</th>
						<th>상태</th>
					</tr>
					<%
						ArrayList<OrderDTO> mainshippingList = (ArrayList<OrderDTO>) request.getAttribute("mainshippingList");
						for (int i = 0; i < mainshippingList.size(); i++) { 
							OrderDTO item = mainshippingList.get(i);	
					%>
					<tr>
						<c:set var="orderNum" value="<%=item.getOrdered_num()%>" />
						<td></td>
						<td onClick='location.href="./OrderDetail?orderNum=${orderNum }";'><%=item.getOrdered_num()%></td>
						<td onClick='location.href="./OrderDetail?orderNum=${orderNum }";'><%=item.getDate_format(item.getOrdered_date()) %></td>
						<td onClick='location.href="./OrderDetail?orderNum=${orderNum }";'><%=item.getPrice() %></td>
						<td onClick='location.href="./OrderDetail?orderNum=${orderNum }";'><%=item.getSelect_count() %></td>
						<td onClick='location.href="./OrderDetail?orderNum=${orderNum }";'><%=item.getStatus() %></td>
					</tr>
					<%
						}
					%>
				</table>
			</div>
			<div class="tab-pane fade" id="end" role="tabpanel"
				aria-labelledby="end-tab">
				<table class="table table-striped">
					<tr>
						<th></th>
						<th>주문번호</th>
						<th>주문날짜</th>
						<th>총 가격</th>
						<th>총 수량</th>
						<th>상태</th>
					</tr>
					<%
						ArrayList<OrderDTO> mainendList = (ArrayList<OrderDTO>) request.getAttribute("mainendList");
						for (int i = 0; i < mainendList.size(); i++) { 
							OrderDTO item = mainendList.get(i);	
					%>
					<tr>
						<c:set var="orderNum" value="<%=item.getOrdered_num()%>" />
						<td></td>
						<td onClick='location.href="./OrderDetail?orderNum=${orderNum }";'><%=item.getOrdered_num()%></td>
						<td onClick='location.href="./OrderDetail?orderNum=${orderNum }";'><%=item.getDate_format(item.getOrdered_date()) %></td>
						<td onClick='location.href="./OrderDetail?orderNum=${orderNum }";'><%=item.getPrice() %></td>
						<td onClick='location.href="./OrderDetail?orderNum=${orderNum }";'><%=item.getSelect_count() %></td>
						<td onClick='location.href="./OrderDetail?orderNum=${orderNum }";'><%=item.getStatus() %></td>
					</tr>
					<%
						}
					%>
				</table>

			</div>
		</div>
	</div>

	<script>
		let key = "${param.key}";
		console.log(key);
		if (key === "order") {

			$("#shipping-tab").removeClass("active");
			$("#end-tab").removeClass("active");
			$("#order-tab").addClass("active");

			$("#shipping").removeClass("show active");
			$("#end").removeClass("show active");
			$("#order").addClass("show active");

		} else if (key === "shipping") {

			$("#end-tab").removeClass("active");
			$("#order-tab").removeClass("active");
			$("#shipping-tab").addClass("active");

			$("#order").removeClass("show active");
			$("#end").removeClass("show active");
			$("#shipping").addClass("show active");

		} else if (key === "end") {

			$("#order-tab").removeClass("active");
			$("#shipping-tab").removeClass("active");
			$("#end-tab").addClass("active");

			$("#shipping").removeClass("show active");
			$("#order").removeClass("show active");
			$("#end").addClass("show active");

		}
	</script>
</body>
</html>