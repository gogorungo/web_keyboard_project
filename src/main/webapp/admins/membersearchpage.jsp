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
<title>관리자 페이지</title>
</head>
<body>
	<jsp:include page="../Admintop.jsp" >
		<jsp:param name="URL" value="member"/>
	</jsp:include>
	<div class="jumbotron">
		<div class="container">
			<h3 class="display-3">${member_id }로 검색한 회원</h3>
		</div>
	</div>
	
	<div class="container">
		<table class="table">
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
				<td><%=item.getBirthdate()%></td>
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
				<td><%=item.getReg_date()%></td>
				<td><%=item.getStatus()%></td>
				<td>
					<p><a href="./SearchMemberInfo?&memberNo=${memberNo }"><button class="btn btn-info" type="button">상세보기</button></a></p>
				</td>
			</tr>
			<%
			}
			%>
		</table>
	</div>

</body>
</html>