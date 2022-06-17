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
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<form action="../cart/Cartview?" method="post">
			<input type="hidden" name="reg" value="addCart" />
			<input type="hidden" name="memberNo" value="${memberNo }" />
			<table class="table table-striped">
				<tr>
					<th style="text-align: center;"><img src="<c:url value="/source/${dto.getItem_img1() }"/>"
						alt="" width=350 height=370 /></th>
					<td style="text-align: left !important;"><input type="hidden" name="itemNo"
						value="${dto.getItemNo() }" />
						<p>[상품번호 : ${dto.getItemNo() }]</p>
						<p>[상품명 : ${dto.getItem_name() }]</p>
						<p>[제조사 : ${dto.getManufacture() }]</p>
						<p>[종류 : ${dto.getCategory() }]</p>
						<p>[스위치 : ${dto.getSwitchs() }]</p>
						<p>[스펙 : ${dto.getSpec() }]</p>
						<p>[등록일 : ${dto.getReg_date() }]</p>
						<p>[가격 : ${dto.getPrice() }]</p>
						<p>[재고 : ${dto.getStock() }]</p></td>
					<td style="text-align: left !important; vertical-align: top !important;">
						<p>
							<c:choose>
								<c:when test="${dto.getStock() == 0 }">
										재고없음
									</c:when>
								<c:otherwise>
									수량 <select onchange="showValue(this.value)" class="form-select"
										aria-label="Default select example">
										<c:forEach var="i" begin="1" end="${dto.getStock() }">
											<option value="${i }">${i }</option>
										</c:forEach>
									</select>
									<input type="hidden" id="count" name="count" value=1 />
									<p>
										<%
											if(memberNo != 0){
										%>
											<input type="submit" value="장바구니로" />
										<%		
											} else {
										%>
											<a href="../member/Login"><input type="button" value="장바구니로" /></a>
										<%		
											}
										%>
									
									</p>
								</c:otherwise>
							</c:choose>
						</p>
					</td>
				</tr>
				<tr>
					<td style="text-align: left !important;" colspan="3"><img
						src="<c:url value="/source/${dto.getItem_img2() }"/>"  style="width: 100%;"alt="" /></td>
				</tr>
			</table>
		</form>
	</div>



	

	<script>
		var showValue = function(value) {
			document.getElementById("count").value = value;
		}
	</script>
</body>
</html>