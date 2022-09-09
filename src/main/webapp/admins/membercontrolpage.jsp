<%@page import="model.item.itemDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Arrays"%>
<%@page import="model.order.OrderDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
button {
	width: 100%;
	text-align: center !important;
}
</style>
<title>관리자 페이지</title>
</head>
<body>
	<jsp:include page="../Admintop.jsp" >
		<jsp:param name="URL" value="member"/>
	</jsp:include>
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-4">회원 관리</h1>
		</div>
	</div>
	
	<div class="container">
		<table class="table table-striped">
			<tr>
				<th>회원 번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>생일</th>
				<th>성별</th>
				<th>이메일</th>
				<th>주소</th>
				<th>전화번호</th>
				<th>등록일</th>
				<th>상태</th>
				<th>비고</th>
			</tr>

			<%
			ArrayList<memberDTO> memberList = (ArrayList<memberDTO>) request.getAttribute("memberList");
			for (int i = 0; i < memberList.size(); i++) { 
				memberDTO item = memberList.get(i);
				pageContext.setAttribute("memberNo",item.getMemberNo());
			%>
			<tr>
				<td><%=item.getMemberNo() %></td>
				<td><%=item.getUser_id()%></td>
				<td><%=item.getName()%></td>
				<td><fmt:formatDate value="<%=item.getBirthdate()%>" pattern="yyyy-MM-dd" /></td>
				<td><%=item.getGender() %></td>
				<td><%=item.getEmail()%></td>
				<%
					if(item.getAddr1()!=null && item.getAddr2()!=null){
				%>
					<td><%=item.getAddr1()%> <%=item.getAddr2() %></td>
				<%		
					} else {
				%>
					<td>주소미입력</td>
				<%	
					}
				%>
				
				<td><%=item.getTel()%></td>
				<td><fmt:formatDate value="<%=item.getReg_date()%>" pattern="yyyy-MM-dd" /></td>
				<td><%=item.getStatus()%></td>
				<td>
					<p><a href="./MemberEdit?&memberNo=${memberNo }"><button class="btn btn-dark" type="button">회원 정보 수정</button></a></p>
					<%
						if(item.getStatus().equals("정지")){
					%>
						<p><a href="./MemberStatusChange?status=회원&memberNo=${memberNo }"><button class="btn btn-success" type="button">정지 해제</button></a></p>
					<%			
						} else if(item.getStatus().equals("회원")) {
					%>
						<p><a href="./MemberStatusChange?status=정지&memberNo=${memberNo }"><button class="btn btn-danger" type="button">사용자 정지</button></a></p>
					<%
						} else if(item.getStatus().equals("탈퇴")) {
							%>
							<p><button class="btn btn-danger" type="button">탈퇴한 회원</button></p>
						<%
							}
						%>
				
					<p><a href="./SearchMemberInfo?&memberNo=${memberNo }"><button class="btn btn-info" type="button">조회</button></a></p>
				</td>
			</tr>
			<%
			}
			%>
		</table>
	</div>

</body>
</html>