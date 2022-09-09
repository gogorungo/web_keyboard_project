<%@page import="java.util.Arrays"%>
<%@page import="model.cart.CartDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-1.12.4.min.js"
	integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ="
	crossorigin="anonymous"></script>
<script type="text/javascript"
	src="https://service.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<style type="text/css">
td {
	vertical-align: middle !important;
	text-align: center !important;
}
</style>
<title>주문완료</title>
</head>
<body>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-4">주문해주셔서 감사합니다</h1>
		</div>
	</div>
	<div class="container">
		<h4 style="color:gray;">주문번호 : ${orderNum }</h4>
			<table class="table table-striped">
				<tr>
					<th></th>
					<th>상품</th>
					<th>가격</th>
					<th>수량</th>
					<th>소계</th>
					<th>비고</th>
				</tr>
				<%
				int sum = 0;
				ArrayList<CartDTO> cartList = (ArrayList<CartDTO>) request.getAttribute("cartList");
				if (cartList == null) {
					cartList = new ArrayList<CartDTO>();
				}
				System.out.println(cartList.size());
				for (int i = 0; i < cartList.size(); i++) { // 상품 리스트 하나씩 출력하기
					CartDTO item = cartList.get(i);
					int total = item.getPrice() * item.getSelected_count();
					sum = sum + total;
				%>
				<c:set var="imgthumb" value="<%=item.getItem_img1()%>" />
				<tr>
					<td><img src="<c:url value="/source/${imgthumb }"/>" alt=""
						width=150 height=150 /></td>
					<td><%=item.getItem_name()%></td>
					<td><%=item.getPrice()%></td>
					<td><%=item.getSelected_count()%></td>
					<td><%=total%></td>
					<td><a
						href="./RemoveItem?itemNo=<%=item.getItemNo()%>&memberNo=<%=memberNo%>">삭제</a></td>
				</tr>
				<%
				}
				%>
				<tr>
					<th></th>
					<th></th>
					<th></th>
					<th>총액</th>
					<th><%=sum%></th>
					<th></th>
				</tr>
			</table>
		</div>

	<div class="container">
			<h1>주문 정보</h1>
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
					<td>${main.getAddr1() } ${main.getAddr2() }</td>
					<td>${main.getTel() }</td>
				</tr>
			</table>
	</div>



	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</body>
</html>