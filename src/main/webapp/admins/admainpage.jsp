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
<%
	ArrayList<OrderDTO> MainROCList = (ArrayList<OrderDTO>) request.getAttribute("MainROCList");
	ArrayList<OrderDTO> MainRCList = (ArrayList<OrderDTO>) request.getAttribute("MainRCList");
	ArrayList<OrderDTO> MainRRList = (ArrayList<OrderDTO>) request.getAttribute("MainRRList");
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
		<jsp:param name="URL" value="main"/>
	</jsp:include>
	<div class="container">
		<h4 class="display-4"><%=new OrderDTO().getDate_format(new Date())%></h4>
		<h5 class="display-5">이번달 예상 수입 : ${total }원</h5>
		<span style="color:gray;">(status : 주문완료, 배송중, 배송완료, 반품확인)</span>
	</div>

	<div class="container">
		<!-- 탭 메뉴 -->
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item" role="presentation">
				<button class="nav-link active" id="order-tab" data-bs-toggle="tab"
					data-bs-target="#order" type="button" role="tab"
					aria-controls="order" aria-selected="true">주문취소요청(<%=MainROCList.size() %>건)</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="shipping-tab" data-bs-toggle="tab"
					data-bs-target="#shipping" type="button" role="tab"
					aria-controls="shipping" aria-selected="false">반품요청(<%=MainRCList.size()  %>건)</button>
			</li>
			<li class="nav-item" role="presentation">
				<button class="nav-link" id="end-tab" data-bs-toggle="tab"
					data-bs-target="#end" type="button" role="tab" aria-controls="end"
					aria-selected="false">교환요청(<%=MainRRList.size()  %>건)</button>
			</li>
		</ul>

		<!-- 내용 -->
		<div class="tab-content" id="myTabContent">
			<div class="tab-pane fade show active" id="order" role="tabpanel"
				aria-labelledby="order-tab">
				<table class="table  table-striped">
					<tr>
						<th></th>
						<th>주문번호</th>
						<th>주문날짜</th>
						<th>총 가격</th>
						<th>총 수량</th>
						<th>상태</th>
					</tr>
					<%
						for (int i = 0; i < MainROCList.size(); i++) { 
							OrderDTO item = MainROCList.get(i);	
					%>
					<tr>
						<c:set var="orderNum" value="<%=item.getOrdered_num()%>" />
						<td></td>
						<td onClick='location.href="../admin/OrderView?orderNum=${orderNum }";'><%=item.getOrdered_num()%></td>
						<td onClick='location.href="../admin/OrderView?orderNum=${orderNum }";'><%=item.getDate_format(item.getOrdered_date()) %></td>
						<td onClick='location.href="../admin/OrderView?orderNum=${orderNum }";'><%=item.getPrice() %></td>
						<td onClick='location.href="../admin/OrderView?orderNum=${orderNum }";'><%=item.getSelect_count() %></td>
						<td onClick='location.href="../admin/OrderView?orderNum=${orderNum }";'><%=item.getStatus() %></td>
					</tr>
					<%
						}
					%>
				</table>
			</div>
			<div class="tab-pane fade" id="shipping" role="tabpanel"
				aria-labelledby="shipping-tab">
				<table class="table  table-striped">
					<tr>
						<th></th>
						<th>주문번호</th>
						<th>주문날짜</th>
						<th>총 가격</th>
						<th>총 수량</th>
						<th>상태</th>
					</tr>
					<%
						for (int i = 0; i < MainRCList.size(); i++) { 
							OrderDTO item = MainRCList.get(i);	
					%>
					<tr>
						<c:set var="orderNum" value="<%=item.getOrdered_num()%>" />
						<td></td>
						<td onClick='location.href="../admin/OrderView?orderNum=${orderNum }";'><%=item.getOrdered_num()%></td>
						<td onClick='location.href="../admin/OrderView?orderNum=${orderNum }";'><%=item.getDate_format(item.getOrdered_date()) %></td>
						<td onClick='location.href="../admin/OrderView?orderNum=${orderNum }";'><%=item.getPrice() %></td>
						<td onClick='location.href="../admin/OrderView?orderNum=${orderNum }";'><%=item.getSelect_count() %></td>
						<td onClick='location.href="../admin/OrderView?orderNum=${orderNum }";'><%=item.getStatus() %></td>
					</tr>
					<%
						}
					%>
				</table>
			</div>
			<div class="tab-pane fade" id="end" role="tabpanel"
				aria-labelledby="end-tab">
				<table class="table  table-striped">
					<tr>
						<th></th>
						<th>주문번호</th>
						<th>주문날짜</th>
						<th>총 가격</th>
						<th>총 수량</th>
						<th>상태</th>
					</tr>
					<%
						for (int i = 0; i < MainRRList.size(); i++) { 
							OrderDTO item = MainRRList.get(i);	
					%>
					<tr>
						<c:set var="orderNum" value="<%=item.getOrdered_num()%>" />
						<td></td>
						<td onClick='location.href="../admin/OrderView?orderNum=${orderNum }";'><%=item.getOrdered_num()%></td>
						<td onClick='location.href="../admin/OrderView?orderNum=${orderNum }";'><%=item.getDate_format(item.getOrdered_date()) %></td>
						<td onClick='location.href="../admin/OrderView?orderNum=${orderNum }";'><%=item.getPrice() %></td>
						<td onClick='location.href="../admin/OrderView?orderNum=${orderNum }";'><%=item.getSelect_count() %></td>
						<td onClick='location.href="../admin/OrderView?orderNum=${orderNum }";'><%=item.getStatus() %></td>
					</tr>
					<%
						}
					%>
				</table>

			</div>
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
						<table class="table  table-striped">
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
								<td><%=item.getDate_format(item.getOrdered_date()) %></td>
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
						<table class="table  table-striped">
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
								<td><%=item.getDate_format(item.getOrdered_date()) %></td>
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
						<table class="table  table-striped">
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
								<td><%=item.getDate_format(item.getOrdered_date()) %></td>
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
						aria-controls="panelsStayOpen-collapseFour">취소/반품/교환확인
						${MainRequestCheckList.size() }건</button>
				</h2>
				<div id="panelsStayOpen-collapseFour"
					class="accordion-collapse collapse"
					aria-labelledby="panelsStayOpen-headingFour">
					<div class="accordion-body">
						<table class="table table-striped">
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
							ArrayList<OrderDTO> MainRequestCheckList = (ArrayList<OrderDTO>) request.getAttribute("MainRequestCheckList");
							for (int i = 0; i < MainRequestCheckList.size(); i++) { // 상품 리스트 하나씩 출력하기
								OrderDTO item = MainRequestCheckList.get(i);
							%>
							<tr><c:set var="orderNum" value="<%=item.getOrdered_num()%>" />
								<td></td>
								<td><%=item.getOrdered_num()%></td>
								<td><%=item.getName()%></td>
								<td><%=item.getDate_format(item.getOrdered_date()) %></td>
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