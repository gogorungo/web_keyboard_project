<%@page import="javax.naming.Context"%>
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
<title>관리자 페이지</title>
</head>
<body>
	<jsp:include page="../Admintop.jsp" >
		<jsp:param name="URL" value="main"/>
	</jsp:include>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3"><%=new Date()%>
				관리자 페이지
			</h1>
			<h2 class="display-3">이번달 수입 : ${total }원</h2>
		</div>
	</div>
	<div class="container">
		<div class="accordion" id="accordionPanelsStayOpenExample">
			<div class="accordion-item">
				<h2 class="accordion-header" id="panelsStayOpen-headingOne">
					<button class="accordion-button" type="button"
						data-bs-toggle="collapse"
						data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="true"
						aria-controls="panelsStayOpen-collapseOne">주문 완료
						${mainList.size() }건</button>
				</h2>
				<div id="panelsStayOpen-collapseOne"
					class="accordion-collapse collapse show"
					aria-labelledby="panelsStayOpen-headingOne">
					<div class="accordion-body">
						<table class="table">
							<tr>
								<th></th>
								<th>주문번호</th>
								<th>주문자 이름</th>
								<th>주문날짜</th>
								<th>총 가격</th>
								<th>총 수량</th>
								<th>상태</th>
								<th>처리</th>
							</tr>
							<%
							ArrayList<OrderDTO> mainList = (ArrayList<OrderDTO>) request.getAttribute("mainList");
							for (int i = 0; i < mainList.size(); i++) { 
								OrderDTO item = mainList.get(i);
								
							%>
							<tr><c:set var="orderNum" value="<%=item.getOrdered_num()%>" />
								<td></td>
								<td><%=item.getOrdered_num()%></td>
								<td><%=item.getName()%></td>
								<td><%=item.getOrdered_date() %></td>
								<td><%=item.getPrice() %></td>
								<td><%=item.getSelect_count() %></td>
								<td><%=item.getStatus() %></td>
								<td>
									<button type="button" class="btn btn-outline-success"
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
			<div class="accordion-item">
				<h2 class="accordion-header" id="panelsStayOpen-headingTwo">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse"
						data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="false"
						aria-controls="panelsStayOpen-collapseTwo">배송중
						${mainorderinglist.size() }건</button>
				</h2>
				<div id="panelsStayOpen-collapseTwo"
					class="accordion-collapse collapse"
					aria-labelledby="panelsStayOpen-headingTwo">
					<div class="accordion-body">
						<table class="table">
							<tr>
								<th></th>
								<th>주문번호</th>
								<th>주문자 이름</th>
								<th>주문날짜</th>
								<th>총 가격</th>
								<th>총 수량</th>
								<th>상태</th>
								<th>처리</th>
							</tr>
							<%
							ArrayList<OrderDTO> mainorderinglist = (ArrayList<OrderDTO>) request.getAttribute("mainorderinglist");
							for (int i = 0; i < mainorderinglist.size(); i++) { 
								OrderDTO item = mainorderinglist.get(i);
							%>
							<tr><c:set var="orderNum" value="<%=item.getOrdered_num()%>" />
								<td></td>
								<td><%=item.getOrdered_num()%></td>
								<td><%=item.getName()%></td>
								<td><%=item.getOrdered_date() %></td>
								<td><%=item.getPrice() %></td>
								<td><%=item.getSelect_count() %></td>
								<td><%=item.getStatus() %></td>
								<td>
									<button type="button" class="btn btn-outline-primary"
										onclick='location.href="../admin/OrderEnd?orderNum=${orderNum }";'>배송완료</button>
								</td>
							</tr>
							<%
							}
							%>
						</table>
					</div>
				</div>
			</div>
			<div class="accordion-item">
				<h2 class="accordion-header" id="panelsStayOpen-headingThree">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse"
						data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="false"
						aria-controls="panelsStayOpen-collapseThree">배송완료
						${MainorderEndlist.size() }건</button>
				</h2>
				<div id="panelsStayOpen-collapseThree"
					class="accordion-collapse collapse"
					aria-labelledby="panelsStayOpen-headingThree">
					<div class="accordion-body">
						<table class="table">
							<tr>
								<th></th>
								<th>주문번호</th>
								<th>주문자 이름</th>
								<th>주문날짜</th>
								<th>총 가격</th>
								<th>총 수량</th>
								<th>상태</th>
								<th>처리</th>
							</tr>
							<%
							ArrayList<OrderDTO> MainorderEndlist = (ArrayList<OrderDTO>) request.getAttribute("MainorderEndlist");
							for (int i = 0; i < MainorderEndlist.size(); i++) {
								OrderDTO item = MainorderEndlist.get(i);
							%>
							<tr><c:set var="orderNum" value="<%=item.getOrdered_num()%>" />
								<td></td>
								<td><%=item.getOrdered_num()%></td>
								<td><%=item.getName()%></td>
								<td><%=item.getOrdered_date() %></td>
								<td><%=item.getPrice() %></td>
								<td><%=item.getSelect_count() %></td>
								<td><%=item.getStatus() %></td>
								<td>
									<button type="button" class="btn btn-outline-success"
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
			<div class="accordion-item">
				<h2 class="accordion-header" id="panelsStayOpen-headingFour">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse"
						data-bs-target="#panelsStayOpen-collapseFour" aria-expanded="false"
						aria-controls="panelsStayOpen-collapseFour">주문취소
						${MainCanellist.size() }건</button>
				</h2>
				<div id="panelsStayOpen-collapseThree"
					class="accordion-collapse collapse"
					aria-labelledby="panelsStayOpen-headingFour">
					<div class="accordion-body">
						<table class="table">
							<tr>
								<th></th>
								<th>주문번호</th>
								<th>주문자 이름</th>
								<th>주문날짜</th>
								<th>총 가격</th>
								<th>총 수량</th>
								<th>상태</th>
								<th>처리</th>
							</tr>
							<%
							ArrayList<OrderDTO> MainCanellist = (ArrayList<OrderDTO>) request.getAttribute("MainCanellist");
							for (int i = 0; i < MainCanellist.size(); i++) { // 상품 리스트 하나씩 출력하기
								OrderDTO item = MainCanellist.get(i);
							%>
							<tr><c:set var="orderNum" value="<%=item.getOrdered_num()%>" />
								<td></td>
								<td><%=item.getOrdered_num()%></td>
								<td><%=item.getName()%></td>
								<td><%=item.getOrdered_date() %></td>
								<td><%=item.getPrice() %></td>
								<td><%=item.getSelect_count() %></td>
								<td><%=item.getStatus() %></td>
								<td>
									<button type="button" class="btn btn-outline-success"
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
			<div class="accordion-item">
				<h2 class="accordion-header" id="panelsStayOpen-headingFour">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse"
						data-bs-target="#panelsStayOpen-collapseFour"
						aria-expanded="false" aria-controls="panelsStayOpen-collapseFour">환불,반품,교환
						${refund.size() }건</button>
				</h2>
				<div id="panelsStayOpen-collapseFour"
					class="accordion-collapse collapse"
					aria-labelledby="panelsStayOpen-headingFour">
					<div class="accordion-body">
						<table class="table">
							<tr>
								<th></th>
								<th>회원번호</th>
								<th>신청인</th>
								<th>상품</th>
								<th>가격</th>
								<th>수량</th>
								<th>소계</th>
							</tr>
							<%
							ArrayList<OrderDTO> refund_list = (ArrayList<OrderDTO>) request.getAttribute("refund");
							
							for(OrderDTO rList : refund_list){ 
							int sum; %>

							<tr>
								<td></td>
								<td><%=rList.getMemberNo()%></td>
								<td><%=rList.getName()%></td>
								<td><%=rList.getItem_name()%></td>
								<td><%=rList.getPrice()%></td>
								<td><%=rList.getSelect_count() %></td>
								<% sum = rList.getPrice() * rList.getSelect_count(); %>
								<td><%= sum %></td>
								<c:set var="oNum" value="<%=rList.getOrdered_num() %>" />
								<c:set var="oNo" value="<%=rList.getOrderNo() %>" />
								<% if(rList.getStatus().equals("주문완료")){ %>
								<td>
									<button type="button" class="btn btn-outline-primary"
										onclick='location.href="../admin/AdminRefund?ordered_num=${oNum }&orderNo=${oNo }";'>취소처리</button>
								</td>
								<%} %>
								<% if(rList.getStatus().equals("배송중")){ %>
								<td>
									<button type="button" class="btn btn-outline-primary"
										onclick='location.href="../admin/AdminRefund?ordered_num=${oNum }&orderNo=${oNo }";'>환불처리</button>
								</td>
								<%} %>
								<% if(rList.getStatus().equals("배송완료")){ %>
								<td>
									<button type="button" class="btn btn-outline-primary"
										onclick='location.href="../admin/AdminRefund?ordered_num=${oNum }&orderNo=${oNo }";'>반품처리</button>
								</td>
								<%} %>
							</tr>
							<% }%>
						</table>
					</div>
				</div>
			</div>
			<div class="accordion-item">
				<h2 class="accordion-header" id="panelsStayOpen-headingThree">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse"
						data-bs-target="#panelsStayOpen-collapseThree"
						aria-expanded="false" aria-controls="panelsStayOpen-collapseThree">환불,
						반품, 교환 처리완료 ${refundNO.size() }건</button>
				</h2>
				<div id="panelsStayOpen-collapseThree"
					class="accordion-collapse collapse"
					aria-labelledby="panelsStayOpen-headingThree">
					<div class="accordion-body">
						<table class="table">
							<tr>
								<th></th>
								<th>회원번호</th>
								<th>신청인</th>
								<th>상품</th>
								<th>가격</th>
								<th>수량</th>
								<th>소계</th>
							</tr>
							<%
							ArrayList<OrderDTO> refundNo = (ArrayList<OrderDTO>) request.getAttribute("refundNO");
							
							for(OrderDTO rList : refundNo){ 
							int sum; %>

							<tr>
								<td></td>
								<td><%=rList.getMemberNo()%></td>
								<td><%=rList.getName()%></td>
								<td><%=rList.getItem_name()%></td>
								<td><%=rList.getPrice()%></td>
								<td><%=rList.getSelect_count() %></td>
								<% sum = rList.getPrice() * rList.getSelect_count(); %>
								<td><%= sum %></td>
								<c:set var="oNum" value="<%=rList.getOrdered_num() %>" />
								<c:set var="oNo" value="<%=rList.getOrderNo() %>" />
								<td>
									<button type="button" class="btn btn-outline-primary"
										onclick='location.href="../admin/AdminRefund?ordered_num=${oNum }&orderNo=${oNo }";'>상태확인</button>
								</td>
							</tr>
							<% }%>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>