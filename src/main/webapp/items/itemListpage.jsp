<%@page import="java.util.HashMap"%>
<%@page import="java.util.Arrays"%>
<%@page import="model.item.itemDTO"%>
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
	pageContext.setAttribute("memberNo",memberNo);
%>
<%
	request.setCharacterEncoding("UTF-8");
	String[] SelectMF = null;
	String[] SelectTY = null;
	String[] SelectSW = null;
	String prices = request.getParameter("prices");
	if(prices == null){
		prices = "전체";
	}

	ArrayList<itemDTO> dtos = (ArrayList<itemDTO>) request.getAttribute("dto");
	if (request.getParameterValues("manufactor") != null) {
		SelectMF = request.getParameterValues("manufactor");
		for (int i = 0; i < dtos.size(); i++) {
			boolean res = true;
			for (String val : SelectMF) {
				val = val.toUpperCase();
				if (val.equals(dtos.get(i).getManufacture().toUpperCase())) {
					res = false;
					break;
				}
			}
			if(res){
				dtos.get(i).setItem_name(null);
			}
		}
	}
	if (request.getParameterValues("category") != null) {
		SelectTY = request.getParameterValues("category");
		for (int i = 0; i < dtos.size(); i++) {
			boolean res = true;
			for (String val : SelectTY) {
				val = val.toUpperCase();
				if (val.equals(dtos.get(i).getCategory().toUpperCase())) {
					res = false;
					break;
				}
			}
			if(res){
				dtos.get(i).setItem_name(null);
			}
		}
	}
	if (request.getParameterValues("sw") != null) {
		SelectSW = request.getParameterValues("sw");
		for (int i = 0; i < dtos.size(); i++) {
			boolean res = true;
			for (String val : SelectSW) {
				val = val.toUpperCase();
				if(dtos.get(i).getSwitchs() != null){
					if (val.equals(dtos.get(i).getSwitchs().toUpperCase())) {
						res = false;
						break;
					}
				}
			}
			if(res){
				dtos.get(i).setItem_name(null);
			}
		}
	}
	int total = 0;
	for(itemDTO c: dtos){
		if(c.getItem_name() != null){
			total++;
		}
	}
	
	HashMap<String, Integer> Count = (HashMap<String, Integer>)request.getAttribute("Count");
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
		<form name="frm" action="?" method="get">
			<table  class="table table-striped">
				<thead>
					<tr>
						<th style="text-align: center;">스마트 검색</th>
						<td>검색 결과 : <%=total %>개</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<th scope="row" style="text-align: center;">제조사</th>
						<% 
							ArrayList<String> manufactor = (ArrayList<String>) request.getAttribute("manufactor");
							if(SelectMF != null){
							for(int i =0; i<manufactor.size();i++){
								boolean res = false;
								int count = Count.get(manufactor.get(i));
								for(int j=0; j<SelectMF.length;j++){
									if(manufactor.get(i).equals(SelectMF[j])){
										res=true;
									}
								} if(res){
						%>
									<td style="text-align: left !important;">
									<c:set target="${Count}" property="name" value="<%=manufactor.get(i) %>"/>
									<input type="checkbox" name="manufactor" value="<%=manufactor.get(i) %>"
										onclick='getCheckboxValue(event)' checked> <%=manufactor.get(i) %> (<%=count %>)
									</td>
						<%
								} else {
						%>
									<td style="text-align: left !important;">
									<c:set target="${Count}" property="name" value="\<%=manufactor.get(i) %>"/>
									<input type="checkbox" name="manufactor" value="<%=manufactor.get(i) %>"
										onclick='getCheckboxValue(event)'> <%=manufactor.get(i) %> (<%=count %>)
									</td>	
						<%
								}
						}
							} else {
						%>
							<c:forEach var="name" items="${manufactor }" varStatus="i">
							<td style="text-align: left !important;">
							<c:set target="${Count}" property="name" value="${name }"/>
							<input type="checkbox" name="manufactor" value="${name}"
								onclick='getCheckboxValue(event)'> ${name} (${Count.get(name) })
							</td>
							</c:forEach>
						<%
							}
						%>
						
					</tr>
					<tr>
						<th scope="row" style="text-align: center;">종류</th>
						<% 
							ArrayList<String> category = (ArrayList<String>) request.getAttribute("category");
							if(SelectTY != null){
							for(int i =0; i<category.size();i++){
								boolean res = false;
								int count = Count.get(category.get(i));
								for(int j=0; j<SelectTY.length;j++){
									if(category.get(i).equals(SelectTY[j])){
										res=true;
									}
								} if(res){
						%>
									<td style="text-align: left !important;">
									<c:set target="${Count}" property="name" value="<%=category.get(i) %>"/>
									<input type="checkbox" name="category" value="<%=category.get(i) %>"
										onclick='getCheckboxValue(event)' checked> <%=category.get(i) %> (<%=count %>)
									</td>
						<%
								} else {
						%>
									<td style="text-align: left !important;">
									<c:set target="${Count}" property="name" value="\<%=category.get(i) %>"/>
									<input type="checkbox" name="category" value="<%=category.get(i) %>"
										onclick='getCheckboxValue(event)'> <%=category.get(i) %> (<%=count %>)
									</td>	
						<%
								}
						}
							} else {
						%>
							<c:forEach var="name" items="${category }" varStatus="i">
							<td style="text-align: left !important;"><c:set target="${Count}" property="name" value="${name }"/>
							<input type="checkbox" name="category" value="${name}"
								onclick='getCheckboxValue(event)'> ${name} (${Count.get(name) })
							</td>
							</c:forEach>
						<%
							}
						%>
						
					</tr>
					<tr>
						<th scope="row" style="text-align: center;">스위치</th>
						<% 
							ArrayList<String> sw = (ArrayList<String>) request.getAttribute("sw");
							if(SelectSW != null){
							for(int i =0; i<sw.size();i++){
								boolean res = false;
								int count = Count.get(sw.get(i));
								for(int j=0; j<SelectSW.length;j++){
									if(sw.get(i).equals(SelectSW[j])){
										res=true;
									}
								} if(res){
						%>
									<td style="text-align: left !important;">
									<c:set target="${Count}" property="name" value="<%=sw.get(i) %>"/>
									<input type="checkbox" name="sw" value="<%=sw.get(i) %>"
										onclick='getCheckboxValue(event)' checked> <%=sw.get(i) %> (<%=count %>)
									</td>
						<%
								} else {
						%>
									<td style="text-align: left !important;">
									<c:set target="${Count}" property="name" value="\<%=sw.get(i) %>"/>
									<input type="checkbox" name="sw" value="<%=sw.get(i) %>"
										onclick='getCheckboxValue(event)'> <%=sw.get(i) %> (<%=count %>)
									</td>	
						<%
								}
						}
							} else {
						%>
							<c:forEach var="name" items="${sw }" varStatus="i">
							<td style="text-align: left !important;"> <c:set target="${Count}" property="name" value="${name }"/>
							<input type="checkbox" name="sw" value="${name}"
								onclick='getCheckboxValue(event)'> ${name} (${Count.get(name) })
							</td>
							</c:forEach>
						<%
							}
						%>
						
					</tr>
					<tr>
						<th scope="row" style="text-align: center;">가격대</th>
						<input type="hidden" name="prices" id="prices" value="전체">
						<td colspan="5" style="text-align: left !important;">
							<% 
								ArrayList<String> priceLange = (ArrayList<String>) request.getAttribute("priceLange");
								for(int i = 0; i<priceLange.size(); i++){
									if( priceLange.get(i).equals(prices)){
							%>
									<button type="button" id="pricebtn"
											class="btn btn-outline-dark active"><%=priceLange.get(i) %></button>
							<%
									} else {
							%>
									<button type="button" id="pricebtn checks" name="checks"
											class="btn btn-outline-dark" value="<%=priceLange.get(i) %>"><%=priceLange.get(i) %></button>
							<%
									}
								}
							%>
						</td>
					</tr>
					<tr>
						<th style="text-align: center;"><button type="button" style="text-align:center;"
								class="btn btn-outline-primary" onclick='location.href="../item/itemList";'>필터 초기화</button>
						</th>
						<td colspan="5" id="res"></td>
						<td><button type="button" id="Submit"
								class="btn btn-outline-primary" onclick='check()'>상세검색</button>
						</td>
					</tr>
				</tbody>
			</table >
		</form>
	</div>
	<div class="container">
			<table  class="table table-striped">
				<c:forEach var="name" items="${dto }" varStatus="i">
					<c:if test="${name.item_name != null}">
						<tr>
							<th><a href="./itemdetail?id=${name.itemNo}"><img
								src="<c:url value="/source/${name.item_img1 }"/>" alt=""
								width=150 height=150 /></a></th>
							<td>
								<p class="jb-smaller">[상품번호:${name.itemNo }]</p>
								<p class="jb-larger"><a href="./itemdetail?id=${name.itemNo}" style="text-decoration: none; color:black;">[${name.manufacture}] ${name.item_name}</a></p>
							</td>
							<td>
								<p>${name.price}원</p> <c:choose>
									<c:when test="${name.stock == 0 }">
										<p>재고없음</p>
									</c:when>
									<c:otherwise>
										<p>[재고:${name.stock }]</p>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
					</c:if>
				</c:forEach>
				</tbody>
			</table >
	</div>
	<script>
		var Beforeresult = "";
		var Beforemflist = document.getElementsByName('manufactor');
		var mflist =[];
		for (var i = 0; i < Beforemflist.length; i++) { 
		      if(Beforemflist[i].checked){
		    	  mflist.push(Beforemflist[i].value);
		    	  Beforeresult += Beforemflist[i].value + " ";
		      }
		}
		var Beforecategorylist = document.getElementsByName('category');
		var categorylist =[];
		for (var i = 0; i < Beforecategorylist.length; i++) { 
		      if(Beforecategorylist[i].checked){
		    	  categorylist.push(Beforecategorylist[i].value);
		    	  Beforeresult += Beforecategorylist[i].value + " ";
		      }
		}
		var Beforeswlist = document.getElementsByName('sw');
		var swlist =[];
		for (var i = 0; i < Beforeswlist.length; i++) { 
		      if(Beforeswlist[i].checked){
		    	  swlist.push(Beforeswlist[i].value);
		    	  Beforeresult += Beforeswlist[i].value + " ";
		      }
		}
		
		function getCheckboxValue(event) {
			if (event.target.checked) {
				if (event.target.name === "manufactor") {
					mflist.push(event.target.value);
				}
				if (event.target.name === "category") {
					categorylist.push(event.target.value);
				}
				if (event.target.name === "sw") {
					swlist.push(event.target.value);
				}
			} else {
				if (event.target.name === "manufactor") {
					for (var i = 0; i < mflist.length; i++) {
						if (mflist[i] === event.target.value) {
							mflist.splice(i, 1);
							i--;
						}
					}
				}
				if (event.target.name === "category") {
					for (var i = 0; i < categorylist.length; i++) {
						if (categorylist[i] === event.target.value) {
							categorylist.splice(i, 1);
							i--;
						}
					}
				}
				if (event.target.name === "sw") {
					for (var i = 0; i < swlist.length; i++) {
						if (swlist[i] === event.target.value) {
							swlist.splice(i, 1);
							i--;
						}
					}
				}
			}
//			var result = Beforeresult;
//			mflist.forEach(function(item, index, array) {
//				result += item + ", ";
//			});
//			categorylist.forEach(function(item, index, array) {
//				result += item + ", ";
//			});
//			swlist.forEach(function(item, index, array) {
//				result += item + ", ";
//			});
//			document.getElementById('res').innerText = result;
		}
		document.getElementById('res').innerText = Beforeresult;
	</script>
	<script>
		var mflist = new Array();
		var typelist = new Array();
		var swlist = new Array();
		j = document.getElementsByName("manufactor").length;
		k = document.getElementsByName("category").length;
		s = document.getElementsByName("sw").length;
		function check() {
			for (var i = 0; i < j; i++) {
				if (document.getElementsByName("manufactor")[i].checked == true) {
					mflist.push(document.getElementsByName("manufactor")[i].value);
				}
			}
			for (var i = 0; i < k; i++) {
				if (document.getElementsByName("category")[i].checked == true) {
					categorylist.push(document.getElementsByName("category")[i].value);
				}
			}
			for (var i = 0; i < s; i++) {
				if (document.getElementsByName("sw")[i].checked == true) {
					swlist.push(document.getElementsByName("sw")[i].value);
				}
			}
			
			document.frm.submit();
		}
		

		var btns = document.getElementsByName("checks");
		btns.forEach(element => element.addEventListener('click', function(e){
			var prices = e.target.value;
			document.getElementById("prices").value = prices;
			var mflist = new Array();
			var typelist = new Array();
			var swlist = new Array();
			j = document.getElementsByName("manufactor").length;
			k = document.getElementsByName("category").length;
			s = document.getElementsByName("sw").length;
	
				for (var i = 0; i < j; i++) {
					if (document.getElementsByName("manufactor")[i].checked == true) {
						mflist.push(document.getElementsByName("manufactor")[i].value);
					}
				}
				for (var i = 0; i < k; i++) {
					if (document.getElementsByName("category")[i].checked == true) {
						categorylist.push(document.getElementsByName("category")[i].value);
					}
				}
				for (var i = 0; i < s; i++) {
					if (document.getElementsByName("sw")[i].checked == true) {
						swlist.push(document.getElementsByName("sw")[i].value);
					}
				}
				console.log(prices)
				document.frm.submit();
		}));
	</script>
</body>
</html>
