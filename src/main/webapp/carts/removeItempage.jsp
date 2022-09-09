<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	int itemNo = (int)request.getAttribute("itemNo");
%>
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
<form name="frm" action="../cart/Cartview?" method="post">
	<input type="hidden" name="reg" value="removeItem" /> 
	<input type="hidden" name="memberNo" value="${memberNo }" />
	<input type="hidden" name="itemNo" value="${itemNo }" />
</form>

<script>
	document.frm.submit();
</script>