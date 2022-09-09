
<%@page import="model.order.OrderDAO"%>
<%@page import="model.order.OrderDTO"%>
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

ArrayList<OrderDTO> totalOrderList = new ArrayList<OrderDTO>();

ArrayList<OrderDTO> orderList = new OrderDAO().SearchMemberNolist("%", memberNo);
for (int i = 0; i < orderList.size(); i++){
	totalOrderList.add(orderList.get(i));
}

//ArrayList<OrderDTO> deliveryList = new OrderDAO().SearchMemberNolist("배송중", memberNo);
//for (int i = 0; i < deliveryList.size(); i++){
//	totalOrderList.add(deliveryList.get(i));
//}

//ArrayList<OrderDTO> deliveryComList = new OrderDAO().SearchMemberNolist("배송완료", memberNo);
//for (int i = 0; i < deliveryComList.size(); i++){
//	totalOrderList.add(deliveryComList.get(i));
//}
%>

<link href="../css/qna.css" rel="stylesheet" type="text/css">
<div class="container-box">
<div class="alert alert-warning" role="alert">
<h2 align="center">무엇이든 물어보세요 ;)</h2>
</div>

<script>
	function checkEmpty() {
		var form = document.qna;
		if (form.subject.value == "") {
			alert("제목을 입력하세요.");
			form.subject.focus();
			return false;
		} else if (form.content.value == "") {
			alert("내용을 입력하세요.");
			form.content.focus();
			return false;
		}
		form.submit();
	}
</script>


<form action="./QnaInsertReg" method="post" name="qna" class="row g-3 needs-validation" novalidate>
	<input type="hidden" name="user_id" value="${dto.user_id }" />
	<input type="hidden" name="pname" value="<%=name%>" />

	<div class="mb-3">
		<label for="exampleFormControlInput1" class="form-label">제목</label>
		<input type="text" class="form-control" id="exampleFormControlInput1" placeholder="제목을 입력하세요." name="subject">
	</div>
	<div class="mb-3">
		<label for="exampleFormControlInput1" class="form-label">작성자</label>
		<input type="text" class="form-control" id="exampleFormControlInput1" value="<%=name%>" disabled="disabled">
	</div>
	<%
	if(totalOrderList.size() > 0){
	%>
	<label for="exampleFormControlInput1" class="form-label">주문번호</label>
	<div class="dropdown">
		<select class="form-select" aria-label="Default select example" name="select_orderNum">
		<option selected="selected">주문번호를 선택하세요</option>
		<%
		String ordered_num = null;
		String itemName = null;
		String status = null;
		for (int i = 0; i < totalOrderList.size(); i++){
			ordered_num = totalOrderList.get(i).getOrdered_num();
			itemName = totalOrderList.get(i).getItem_name();
			status = totalOrderList.get(i).getStatus();
			%>
			<option value="<%=ordered_num %>"> <%=ordered_num %> - <%=itemName %> / <%=status %> </option>
		<%
		}
		%>
		</select>
	</div>
	<%
	}
	%>
	<div class="mb-3">
		<label for="exampleFormControlTextarea1" class="form-label">내용</label>
		<textarea class="form-control" id="exampleFormControlTextarea1"
			rows="20" placeholder="내용을 입력하세요." name="content"></textarea>
	</div>
	<div class="btn-group" role="group" aria-label="Basic example">
	<button type="reset" class="btn btn-warning">초기화</button>
	<button type="button" class="btn btn-primary" onclick="checkEmpty()">작성하기</button>
	<button type="button" class="btn btn-secondary" onclick="location='QnaList'">목록으로</button>
	</div>
</form>
</div>