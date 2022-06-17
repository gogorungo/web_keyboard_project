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
<title>장바구니</title>
</head>
<body>
	<div class="jumbotron">
		<div class="container">
			<h5 class="display-3">장바구니</h5>
		</div>
	</div>
	<div class="container">
			<form name="frm" action="../cart/OrderCart?" method="get">
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
				<c:set var="imgthumb" value="<%=item.getItem_img1()%>"/>
				<tr>
					<td style="text-align: center;"><img
							src="<c:url value="/source/${imgthumb }"/>" alt=""
							width=150 height=150 />
					</td>
					<td name="Item_name" style="text-align: center; vertical-align: middle;"><%=item.getItem_name()%></td>
					<td style="text-align: center; vertical-align: middle;"><%=item.getPrice()%></td>
					<td name="Selected_count" style="text-align: center; vertical-align: middle;"><%=item.getSelected_count()%></br>
						<a href="./ChangeCart?memberNo=<%=memberNo%>&itemNo=<%=item.getItemNo() %>" class="btn btn-outline-success">수량 변경</a>
					</td>
					<td style="text-align: center; vertical-align: middle;"><%=total%></td>
					<td style="text-align: center; vertical-align: middle;"><a href="./RemoveItem?itemNo=<%=item.getItemNo() %>&memberNo=<%=memberNo%>">삭제</a></td>
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
			</form>
			<a href="../item/itemList" class="btn btn-secondary">&laquo; 쇼핑 계속하기</a>
		
					<%
						if(dto != null){
					%>
					<a href="javascript:goOrder();" class="btn btn-success" style="float: right;">주문하기</a>
					<%
						} else {
					%>
					<a href="../member/Login" class="btn btn-success" style="float: right;">주문하기</a>
					<%		
						}
					%>
			<a href="./DeleteCart?memberNo=<%=memberNo%>" class="btn btn-danger" style="float: right; margin-right: 10px;">장바구니 비우기</a>		
		</div>	
	<script type="text/javascript">
		function goOrder(){
			document.frm.submit();	
		}
	</script>
</body>
</html>