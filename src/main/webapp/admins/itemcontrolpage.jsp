<%@page import="model.item.itemDTO"%>
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
</style>
<title>관리자 페이지</title>
</head>
<body>
	<jsp:include page="../Admintop.jsp" >
		<jsp:param name="URL" value="item"/>
	</jsp:include>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-4">상품관리</h1>
			<p><a href="./AddItem"><button class="btn btn-secondary" type="button">상품 추가</button></a></p>
		</div>
	</div>
	
	<div class="container" >
		<table class="table table-striped">
			<tr>
				<th></th>
				<th>상품</th>
				<th>가격</th>
				<th>재고</th>
				<th>비고</th>
			</tr>

			<%
			ArrayList<itemDTO> itemList = (ArrayList<itemDTO>) request.getAttribute("itemList");
			for (int i = 0; i < itemList.size(); i++) { // 상품 리스트 하나씩 출력하기
				itemDTO item = itemList.get(i);
			%>
			<c:set var="imgthumb" value="<%=item.getItem_img1()%>" />
			<tr>
				<td><img src="<c:url value="/source/${imgthumb }"/>" alt=""
					width=150 height=150 /></td>
				<td><%=item.getItem_name()%></td>
				<td><%=item.getPrice()%></td>
				<td><%=item.getStock()%></td>
				<td>
					<p><a href="./ItemEdit?itemNo=<%=item.getItemNo() %>"><button class="btn btn-primary" type="button" style="width: 100%;">상품정보 수정</button></a></p>
					<p><a href="./ItemAddStock?itemNo=<%=item.getItemNo() %>"><button class="btn btn-success" type="button" style="width: 100%;">상품 입고</button></a></p>
				</td>
			</tr>
			<%
			}
			%>

		</table>

	</div>

</body>
</html>