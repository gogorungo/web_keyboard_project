<%@page import="java.util.Map.Entry"%>
<%@page import="java.util.HashMap"%>
<%@page import="model.member.memberDAO"%>
<%@page import="java.util.Date"%>
<%@page import="model.order.OrderDTO"%>
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
pageContext.setAttribute("memberNo", memberNo);
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
<title></title>
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
</head>
<body>
	<jsp:include page="../Admintop.jsp" >
		<jsp:param name="URL" value="order"/>
	</jsp:include>
	<div class="container">
		<div class="row">
    		<div class="col">
    			<h4>주문번호 검색</h4>
      			<form action="?" method="post" name="frm">
					<table class="table table-striped" style="width: 400px; margin-right:0px;">
						<tr align="center">
							<th>주문번호</th>
		
							<td><input type="text" name="order_num" value="${order_num }"></td>
		
						</tr>
						<tr align="center">
							<th>주문자 ID</th>
		
							<td><input type="text" name="user_id" value="${user_id }"></td>
		
						</tr>
						<tr align="center">
							<th>주문자 이름</th>
							<td><input type="text" name="name" value="${name }"></td>
						</tr>
						<tr align="center">
							<th>상태</th>
							<td><input type="text" name="status" value="${status }"></td>
						</tr>
						<tr align="center">
							<th>검색구간</th>
							<td>
								<p>
									시작일 <input type="date" name="startdate" id="startdate" value="${startdate }" />
								</p>
								<p>
									끝일 <input type="date" name="enddate" id="enddate" value="${enddate }" onchange="handler(event);" />
								</p>
							</td>
						</tr>
						<tr align="center">
							<th></th>
							<td>
							<p><input class="btn btn-danger"  type="reset" value="초기화" /></p>
								<input class="btn btn-primary" type="submit" value="검색" /></td>
						</tr>
					</table>
				</form>
    		</div>
    		<div class="col">
    			<h4>결과 정리</h4>
     		 	<table class="table table-striped">
			<tr>
				<th>상태</th>
				<th>갯수</th>
				<th>가격</th>
			</tr>

			<%
				HashMap<String, Integer> Counts = (HashMap<String, Integer>) request.getAttribute("Counts");
				HashMap<String, Integer> totals = (HashMap<String, Integer>) request.getAttribute("totals");
				for (Entry<String, Integer> entrySet : Counts.entrySet()) {
			%>
			<tr>
				<td><%=entrySet.getKey() %></td>
				<td><%=entrySet.getValue()%>건</td>
				<td><%=totals.get(entrySet.getKey()) %>원</td>
			</tr>
			<%
				}
			%>
			<tr>
				<th colspan="3">매출액(주문완료, 배송중, 배송완료, 교환확인) ${total }원</th>
			</tr>
		</table>
    		</div>
    	</div>
    	<div class="row">
    	<table class="table table-striped">
			<tr>
				<th>주문번호</th>
				<th>주문자 ID</th>
				<th>주문자 이름</th>
				<th>상품수</th>
				<th>상태</th>
				<th>주문일</th>
				<th>배송지</th>
				<th>비고</th>
			</tr>

			<%
				ArrayList<OrderDTO> orderList = (ArrayList<OrderDTO>) request.getAttribute("orderList");
			for (int i = 0; i < orderList.size(); i++) {
				OrderDTO item = orderList.get(i);
				String user_id = new memberDAO().detail(item.getMemberNo()).getUser_id();
			%>
			<tr>
				<td><%=item.getOrdered_num()%></td>
				<td><%=user_id%></td>
				<td><%=item.getName()%></td>
				<td><%=item.getSelect_count()%></td>
				<td><%=item.getStatus()%></td>
				<td><%=new OrderDTO().getDate_format(item.getOrdered_date())%></td>
				<td><%=item.getAddr1()%> <%=item.getAddr2()%></td>
				<td>
					<button onClick='location.href="./OrderView?orderNum=<%=item.getOrdered_num()%>";' class="btn btn-info" type="button">상세보기</button>
				</td>
			</tr>
			<%
				}
			%>
		</table>
    	</div>
	</div>
		
		<script type="text/javascript">
			document.getElementById("startdate").setAttribute("max", document.getElementById("enddate").value);
			function handler(e) {
				document.getElementById("startdate").setAttribute("max", e.target.value);
			}
		</script>


</body>
</html>