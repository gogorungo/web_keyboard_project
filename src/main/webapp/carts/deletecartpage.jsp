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
	pageContext.setAttribute("memberNo",memberNo);
%>
<%
	String msg = (String)request.getAttribute("msg");
%>

<form name="frm" action="../cart/Cartview?" method="post">
	<input type="hidden" name="reg" value="delCart" /> 
	<input type="hidden" name="memberNo" value="${memberNo }" />
</form>

<script>
	alert("<%=msg %>");
	document.frm.submit();
</script>