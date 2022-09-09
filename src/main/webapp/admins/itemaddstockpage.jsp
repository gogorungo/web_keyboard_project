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
			<h3 class="display-4">상품 입고</h3>
			<a href="./ItemControl" class="btn btn-secondary">상품 목록으로</a>
		</div>
	</div>
	<div class="container">
		<form action="./ItemAddStockReg?" method="post" name="frm">
			<input type="hidden" name="itemNo" value="${getItem.getItemNo() }">
			<table class="table table-striped" style="width: 600px;">
				<tr>
					<th></th>
					<td><img
						src="<c:url value="/source/${getItem.getItem_img1() }"/>" alt=""
						width=400 height=400 /></td>
				</tr>
				<tr>
					<th>상품</th>
					<td>${getItem.getItem_name() }</td>

				</tr>
				<tr>
					<th>가격</th>
					<td>${getItem.getPrice() }</td>
				</tr>
				<tr>
					<th>재고</th>
					<td>${getItem.getStock() }</td>
				</tr>
				<tr>
					<th>입고</th>
					<td>
						<div class="form-floating">
							<textarea class="form-control" placeholder="입고수량 입력"
								id="floatingTextarea" name="count"></textarea>
							<label for="floatingTextarea">입고수량 입력</label>
						</div>
					</td>
				</tr>
				<tr><td colspan="2"><input type="button" class="btn btn-primary" value="상품입고" onclick="check();"></td></tr>
			</table>
		</form>
	</div>
	
	<script type="text/javascript">
		function check() {
			var res = isNaN(document.getElementById('floatingTextarea').value);
			if(res){
				alert('숫자만 입력해주십시오.');
			} else {
				document.frm.submit();
			}
		}
	</script>
</body>
</html>