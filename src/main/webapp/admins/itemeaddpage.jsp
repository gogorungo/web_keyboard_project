<%@page import="model.item.itemDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Arrays"%>
<%@page import="model.order.OrderDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.File"%>
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
input {
	width: 100%;
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
			<h3 class="display-4">상품 추가</h3>
			<a href="./ItemControl" class="btn btn-secondary">상품 목록으로</a>
		</div>
	</div>
	<div class="container">	
		<form action="./AddItemReg" method="post"
			enctype="multipart/form-data" name="frm">
			<table class="table table-striped" style="width:800px;">
				<tr>
					<th>상품명</th>
					<td><input type="text" name="item_name" id="item_name" placeholder="앱코 HACKER K660 축교환 완전방수 게이밍 카일 광축 블랙"></td>
				</tr>
				<tr>
					<th>제조사</th>
					<td><input type="text" name="manufacture" id="manufacture" placeholder="앱코"></td>
				</tr>
				<tr>
					<th>종류</th>
					<td><input type="text" name="category" id="category" placeholder="무접점"></td>
				</tr>
				<tr>
					<th>스위치</th>
					<td><input type="text" name="switchs" id="switchs" placeholder="광축"></td>
				</tr>
				<tr>
					<th>스펙</th>
					<td><input type="text" name="spec" id="spec" placeholder="유선, 스위치 : 카일"></td>
				</tr>
				<tr>
					<th>가격</th>
					<td><input type="text" name="price" id="price" placeholder="49700"></td>
				</tr>
				<tr>
					<th>재고</th>
					<td><input type="text" name="stock" id="stock" placeholder="30"></td>
				</tr>
				<tr>
					<th>메인 이미지 파일</th>
					<td><input type="file" name="item_img1" id="item_img1" placeholder="4_1.jpg"></td>
				</tr>
				<tr>
					<th>상품 정보 이미지 파일</th>
					<td><input type="file" name="item_img2" id="item_img2" placeholder="4_2.jpg"></td>
				</tr>
				<tr>
					<td colspan="2">
					<input type="button" class="btn btn-primary" onclick="checkImg()" value="상품추가">
					</td>
				</tr>
			</table>
		</form>
	</div>
	<script type="text/javascript">
	function checkImg() {
		var item_name = document.getElementById("item_name").value; 
		var manufacture = document.getElementById("manufacture").value; 
		var category = document.getElementById("category").value; 
		var switchs = document.getElementById("switchs").value; 
		var spec = document.getElementById("spec").value; 
		var price = document.getElementById("price").value; 
		var stock = document.getElementById("stock").value; 
		var item_img1 = document.getElementById("item_img1").value; 
		var item_img2 = document.getElementById("item_img2").value;
		if((item_name == "" || manufacture == "" || category == "" || 
				switchs == "" || spec == "" || price == "" ||
				stock == "" || item_img1 == "" || item_img2 == "")){
			alert('빈칸이 있습니다');
	   		return;
		}
		item_img1 = item_img1.slice(item_img1.indexOf(".") + 1).toLowerCase();
		item_img2 = item_img2.slice(item_img2.indexOf(".") + 1).toLowerCase();
	 	if((item_img1 != "jpg" || item_img2 != "jpg")){
	   		alert('jpg파일만 올려주십시오');
	   		return;
	 	}else{
	  		document.frm.submit();
	 	}
	}
		
	</script>
</body>
</html>