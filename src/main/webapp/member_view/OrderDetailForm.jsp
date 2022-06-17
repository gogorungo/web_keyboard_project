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
	pageContext.setAttribute("memberNo",memberNo);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script src="https://code.jquery.com/jquery-3.3.1.min.js"
	integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
	crossorigin="anonymous"></script>
<style type="text/css">
td {
	vertical-align: middle !important;
	text-align: center !important;
}
</style>
<title>주문 상세 페이지</title>
</head>
<body>
	<div class="jumbotron">
		<div class="container">
			<h4 class="display-4">주문내역 상세보기</h4>
			<p>주문번호 - ${orderNum }</p>
			<p>처리상태 - ${main.getStatus() }</p>
		</div>
	</div>
	<div class="container" style="margin-top: 10px;">
	<div style="margin-bottom: 10px;">
		<c:if test="${main.getStatus() == '주문완료' }">
			<button type="button" class="btn btn-outline-danger"
				onclick='location.href="./Ordering?orderNum=${main.getOrdered_num()}&res=주문취소확인";'>주문취소</button>
		</c:if>
		<c:if test="${main.getStatus() == '배송중' }">
			<button type="button" class="btn btn-outline-danger"
				onclick='location.href="./Ordering?orderNum=${main.getOrdered_num()}&res=주문취소요청";'>주문 취소 요청</button>
		</c:if>
		<c:if test="${main.getStatus() == '배송완료' }">
			<button type="button" class="btn btn-outline-danger"
				onclick='location.href="./Ordering?orderNum=${main.getOrdered_num()}&res=반품요청";'>반품요청</button>
			<button type="button" class="btn btn-outline-info"
				onclick='location.href="./Ordering?orderNum=${main.getOrdered_num()}&res=교환요청";'>교환요청</button>
		</c:if>
	</div>
			<h5>상품정보</h5>
			<table class="table table-striped">
				<tr>
					<th></th>
					<th>상품</th>
					<th>가격</th>
					<th>수량</th>
					<th>소계</th>
				</tr>
				<%
				int sum = 0;
				ArrayList<OrderDTO> OrderList = (ArrayList<OrderDTO>) request.getAttribute("OrderList");
				if (OrderList == null) {
					OrderList = new ArrayList<OrderDTO>();
				}
				for (int i = 0; i < OrderList.size(); i++) { // 상품 리스트 하나씩 출력하기
					OrderDTO item = OrderList.get(i);
					int total = item.getPrice() * item.getSelect_count();
					sum = sum + total;
				%>
				<c:set var="imgthumb" value="<%=item.getItem_img1()%>" />
				<tr>
					<td><img src="<c:url value="/source/${imgthumb }"/>" alt=""
						width=150 height=150 /></td>
					<td><%=item.getItem_name()%></td>
					<td><%=item.getPrice()%></td>
					<td><%=item.getSelect_count()%></td>
					<td><%=total%></td>
				</tr>
				<%
				}
				%>
				<tr>
					<th></th>
					<th></th>
					<th>총액</th>
					<th><%=sum%></th>
					<th></th>
				</tr>
			</table>
		</div>

	<div class="container">
			<h5>주문 정보</h5>
			<table class="table table-striped">
				<tr>
					<th>주문자 아이디</th>
					<th>주문자 이름</th>
					<th>배송지</th>
					<th>전화번호</th>
				</tr>
				<tr>
					<td>${memberid }</td>
					<td>${main.getName() }</td>
					<td>${main.getAddr1() }${main.getAddr2() }</td>
					<td>${main.getTel() }</td>
				</tr>
			</table>
	</div>

</body>
</html>