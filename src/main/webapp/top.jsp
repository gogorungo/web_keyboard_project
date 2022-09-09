<%@page import="javax.websocket.Session"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<ul id="nav2" class="nav justify-content-center bg-light">
	<li>
	<a href="../mainpage/MainService"> <img
		src="<c:url value="/source/Logo3.jpg"/>"  alt="..."></a>
	</li>	
</ul>



<ul id="nav2" class="nav justify-content-end bg-light">
	<%
		if (userStatus != null) {
		if (userStatus.equals("관리자")) {
	%>
	<c:set var="userName" value="<%=dto.getName()%>" />
	<li><input class="btn btn-light btn-sm" type="button"
		value="${userName }님 어서오세요!" style="margin: 4px;" /></li>
	<li><a href="../admin/Adminmain"><button
				class="btn btn-primary btn-sm" style="margin: 4px;">관리자 페이지</button></a></li>
	<li><a href="../member/Logout"><button
				class="btn btn-danger btn-sm" style="margin: 4px;">로그아웃</button></a></li>
	<%
		} else {
	%>
	<c:set var="userName" value="<%=dto.getName()%>" />
	<li><input class="btn btn-light btn-sm" type="button"
		value="${userName }님 어서오세요!" style="margin: 4px;" /></li>
	<li><a href="../member/Logout"><button
				class="btn btn-danger btn-sm" style="margin: 4px;">로그아웃</button></a></li>
	<%
		}
	%>
	<%
		} else {
	%>
	<%
		}
	%>
</ul>
<ul id="nav3" class="nav justify-content-end bg-light">
	<%
		if (dto != null) {
	%>
	<li><a href="../member/Detail"><button
				class="btn btn-info btn-sm" style="margin: 4px;">마이페이지</button></a></li>
	<li><a href="../cart/Cartview?reg=view&memberNo=${memberNo }"><button
				class="btn btn-info btn-sm" style="margin: 4px;">장바구니</button></a></li>
	<li><a href="../member/Order"><button
				class="btn btn-info btn-sm" style="margin: 4px;">주문내역 확인</button></a></li>
	<li><a href="../qna/QnaList?qnaStatus=전체"><button
				class="btn btn-dark btn-sm" style="margin: 4px;">고객센터</button></a></li>
	<%
		} else {
	%>
	<li><a href="../member/Login"><button
				class="btn btn-success btn-sm" style="margin: 4px;">로그인</button></a></li>
	<li><a href="../member/SignUp"><button
				class="btn btn-info btn-sm" style="margin: 4px;">회원가입</button></a></li>
	<li><a href="../qna/QnaList?qnaStatus=전체"><button
				class="btn btn-dark btn-sm" style="margin: 4px;">고객센터</button></a></li>
	<%
		}
	%>
</ul>
<ul id="nav4" class="nav justify-content-center bg-light">
	<li><a href="../notice/NoticeList"><button
				class="btn btn-light" style="margin: 4px;">공지사항</button></a></li>
	<li><a href="../mainpage/Street"><button
				class="btn btn-light" style="margin: 4px;">오시는길</button></a></li>			
	<li><a href="../item/itemList"><button
				class="btn btn-light" style="margin: 4px;">스마트검색</button></a></li>			
	<li class="nav-item">
		<form action="../item/SearchItem?" method="get"
			class="d-flex justify-content-start" style="margin: 4px;">
			<input class="form-control me-2" type="search" placeholder="상품 검색"
				aria-label="Search" name="itemname" style="text-align: left !important">
			<button class="btn btn-outline-success btn-sm" type="submit">Search</button>
		</form>
	</li>
</ul>