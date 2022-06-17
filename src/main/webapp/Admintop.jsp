<%@page import="javax.websocket.Session"%>
<%@page import="model.member.memberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	String URL = request.getParameter("URL");
%> 
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous" >
<ul id="nav1" class="nav justify-content-center bg-dark">
	<% if(URL.equals("main")){%>
		<li><a href="./Adminmain"><button
				class="btn btn-light" style="margin: 4px;">관리자페이지</button></a></li>
	<% }else{ %>
		<li><a href="./Adminmain"><button
				class="btn btn-dark" style="margin: 4px;">관리자페이지</button></a></li>
	<%}%>
	<% if(URL.equals("order")){%>
		<li><a href="./OrderSearch"><button
				class="btn btn-light" style="margin: 4px;">주문검색</button></a></li>
	<% }else{ %>
		<li><a href="./OrderSearch"><button
				class="btn btn-dark" style="margin: 4px;">주문검색</button></a></li>
	<%}%>
	<% if(URL.equals("member")){%>
		<li><a href="./MemberControl"><button
				class="btn btn-light" style="margin: 4px;">회원관리</button></a></li>
	<% }else{ %>
		<li><a href="./MemberControl"><button
				class="btn btn-dark" style="margin: 4px;">회원관리</button></a></li>
	<%}%>
	<% if(URL.equals("item")){%>
		<li><a href="./ItemControl"><button
				class="btn btn-light" style="margin: 4px;">상품관리</button></a></li>
	<% }else{ %>
		<li><a href="./ItemControl"><button
				class="btn btn-dark" style="margin: 4px;">상품관리</button></a></li>
	<%}%>
	<% if(URL.equals("qna")){%>
		<li><a href="./QnaControl"><button
				class="btn btn-light" style="margin: 4px;">고객센터 관리</button></a></li>
	<% }else{ %>
		<li><a href="./QnaControl"><button
				class="btn btn-dark" style="margin: 4px;">고객센터 관리</button></a></li>
	<%}%>		
	<% if(URL.equals("notice")){%>
		<li><a href="./NoticeControl"><button
				class="btn btn-light" style="margin: 4px;">공지사항 관리</button></a></li>
	<% }else{ %>
		<li><a href="./NoticeControl"><button
				class="btn btn-dark" style="margin: 4px;">공지사항 관리</button></a></li>
	<%}%>	
	<% if(URL.equals("Mainpage")){%>
		<li><a href="./MainControl"><button
				class="btn btn-light" style="margin: 4px;">메인페이지 관리</button></a></li>
	<% }else{ %>
		<li><a href="./MainControl"><button
				class="btn btn-dark" style="margin: 4px;">메인페이지 관리</button></a></li>
	<%}%>				
	<!-- 주문검색쪽에 만듬 			
	<li class="nav-item">
		<form action="../item/SearchItem?" method="get"
			class="d-flex justify-content-start" style="margin: 4px;">
			<input class="form-control me-2" type="search" placeholder="회원 ID 검색"
				aria-label="Search" name="member_id">
			<button class="btn btn-outline-light btn-sm" type="submit">Search</button>
		</form>
	</li>
	-->		
</ul>