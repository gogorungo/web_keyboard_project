<%@page import="java.util.Arrays"%>
<%@page import="model.cart.CartDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.inicis.std.util.SignatureUtil"%>
<%@page import="java.util.*"%>
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
	user.setAttribute("memberNo",memberNo);
%>
<%
	// 여기에 설정된 값은 Form 필드에 동일한 값으로 설정
	String mid					= "INIpayTest";		// 가맹점 ID(가맹점 수정후 고정)					
	
	//인증
	String signKey			    = "SU5JTElURV9UUklQTEVERVNfS0VZU1RS";	// 가맹점에 제공된 웹 표준 사인키(가맹점 수정후 고정)
	String timestamp			= SignatureUtil.getTimestamp();			// util에 의해서 자동생성

	String oid					= mid+"_"+SignatureUtil.getTimestamp();	// 가맹점 주문번호(가맹점에서 직접 설정)
	String price				= "1000";													// 상품가격(특수기호 제외, 가맹점에서 직접 설정)

	String cardNoInterestQuota	= "11-2:3:,34-5:12,14-6:12:24,12-12:36,06-9:12,01-3:4";		// 카드 무이자 여부 설정(가맹점에서 직접 설정)
	String cardQuotaBase		= "2:3:4:5:6:11:12:24:36";		// 가맹점에서 사용할 할부 개월수 설정

	//###############################################
	// 2. 가맹점 확인을 위한 signKey를 해시값으로 변경 (SHA-256방식 사용)
	//###############################################
	String mKey = SignatureUtil.hash(signKey, "SHA-256");
	
	//###############################################
	// 2.signature 생성
	//###############################################
	Map<String, String> signParam = new HashMap<String, String>();

	signParam.put("oid", oid); 					// 필수
	signParam.put("price", price);				// 필수
	signParam.put("timestamp", timestamp);		// 필수

	// signature 데이터 생성 (모듈에서 자동으로 signParam을 알파벳 순으로 정렬후 NVP 방식으로 나열해 hash)
	String signature = SignatureUtil.makeSignature(signParam);
	
	
	/* 기타 */
	String siteDomain = "http://qwe2487.cafe24.com/carts"; //가맹점 도메인 입력
	// 페이지 URL에서 고정된 부분을 적는다. 
	// Ex) returnURL이 http://localhost:8080INIpayStdSample/INIStdPayReturn.jsp 라면
	// http://localhost:8080/INIpayStdSample 까지만 기입한다.
	
	
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
<script src="https://code.jquery.com/jquery-1.12.4.min.js"
	integrity="sha256-ZosEbRLbNQzLpnKIkEdrPv7lOy9C27hHQ+Xp8a4MxAQ="
	crossorigin="anonymous"></script>
<script type="text/javascript"
	src="https://service.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<!-- 테스트 JS(샘플에 제공된 테스트 MID 전용) -->
<script language="javascript" type="text/javascript"
	src="https://stgstdpay.inicis.com/stdjs/INIStdPay.js" charset="UTF-8"></script>
<style type="text/css">
td, th {
	vertical-align: middle !important;
	text-align: center !important;
}
</style>
<title>주문페이지</title>
</head>
<body>
	<div class="jumbotron">
		<div class="container">
			<h5 class="display-4">주문내역서 작성</h5>
		</div>
	</div>
	<div class="container">
			<table class="table table-striped">
				<tr>
					<th></th>
					<th>상품</th>
					<th>가격</th>
					<th>수량</th>
					<th>소계</th>
				</tr>
				<%
				int sum = 0;
				ArrayList<CartDTO> cartList = (ArrayList<CartDTO>) request.getAttribute("cartList");
				if (cartList == null) {
					cartList = new ArrayList<CartDTO>();
				}
				System.out.println(cartList.size());
				for (int i = 0; i < cartList.size(); i++) { // 상품 리스트 하나씩 출력하기
					CartDTO item = cartList.get(i);
					int total = item.getPrice() * item.getSelected_count();
					sum = sum + total;
				%>
				<c:set var="imgthumb" value="<%=item.getItem_img1()%>" />
				<tr>
					<td><img src="<c:url value="/source/${imgthumb }"/>" alt=""
						width=150 height=150 /></td>
					<td><%=item.getItem_name()%></td>
					<td><%=item.getPrice()%></td>
					<td><%=item.getSelected_count()%></td>
					<td><%=total%></td>
				</tr>
				<%
				}
				%>
				<tr>
					<th></th>
					<th></th>
					<th></th>
					<th>총액</th>
					<th><%=sum%></th>
				</tr>
			</table>
		</div>
	<div class="container">
		<form name="frm" action="../cart/OrderEnd?" method="post">
			<input type="hidden" id="memberNo" value="<%=memberNo%>">
			<input type="hidden" id="ordered_num" value="<%=mid%>">
			<table class="table" style=" margin-right:0px;">
				<tr>
					<th>주문자 이름</th>
					<td colspan="2">${member.name }</td>
				</tr>
				<tr>
					<th>주문자 전화번호</th>
					<td colspan="2">${member.tel }</td>
				</tr>
				<tr>
					<th>배송지 주소</th>
					<td colspan="2">
					<c:if test="${member.addr1!=null &&member.addr2 != null }">
						<input type="button" class="btn btn-dark" onclick="clearpotcode()" value="새 배송지 찾기">
					</c:if>
					<c:if test="${member.addr1 ==null || member.addr2 == null }">
						<input type="button" class="btn btn-info" onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
					</c:if>
					</td>
				</tr>
				<c:if test="${member.addr1!=null &&member.addr2 != null }">
					<tr>
						<td><input type="text"
						id="sample4_postcode" disabled="disabled" placeholder="우편번호" style="width:100%; text-align:center;" value="${member.zip_code }"></td>
						<td><input type="text" id="sample4_roadAddress" name="addr1" placeholder="도로명주소" style="width:100%; text-align:center;" value="${member.addr1 }"></td>
						<td colspan="2" ><input type="text" id="sample4_detailAddress" name="addr2" placeholder="상세주소 입력" style="width:100%; text-align:center;" value="${member.addr2 }"></td>
					</tr>		
				</c:if>
				<c:if test="${member.addr1 ==null || member.addr2 == null }">
					<tr>
						<td><input type="text"
						id="sample4_postcode" disabled="disabled" placeholder="우편번호" style="width:100%; text-align:center;"></td>
						<td><input type="text" id="sample4_roadAddress" name="addr1" placeholder="도로명주소" style="width:100%; text-align:center;"></td>
						<td colspan="2" ><input type="text" id="sample4_detailAddress" name="addr2" placeholder="상세주소 입력" style="width:100%; text-align:center;"></td>
					</tr>	
				</c:if>
			</table>
		</form>
			<a href="./Cartview?reg=view&memberNo=<%=memberNo %>" class="btn btn-secondary" role="button" style="margin :10px; ">이전</a>
		<button onclick="requestPay()" class="btn btn-primary" style="margin :10px; float: right;">결제하기</button>
		
	</div>

	<form id="SendPayForm_id" name="inissubmit" method="POST">
		<input type="hidden" name="version" value="1.0">
		<input type="hidden" name="mid" value="<%=mid%>">
		<input type="hidden" style="width: 100%;" name="goodname" value="테스트">
		<input type="hidden" style="width: 100%;" name="oid" value="<%=oid%>"> 
		<input type="hidden" style="width: 100%;" name="price" value="<%=price %>">
		<input type="hidden" style="width: 100%;" name="currency" value="WON"> 
		<input type="hidden" style="width: 100%;" name="buyername" value="${member.name }"> 
		<input type="hidden" style="width: 100%;" name="buyertel" value="${member.tel }">
		<input type="hidden" style="width: 100%;" name="buyeremail" value="test@inicis.com">
		<input type="hidden" type="hidden" style="width: 100%;" name="timestamp"
			value="<%=timestamp %>">
		<input type="hidden" style="width: 100%;" name="signature"
			value="<%=signature%>">
		<input type="hidden" style="width: 100%;" name="returnUrl"
			value="<%=siteDomain%>/INIStdPayReturn.jsp">
		<input type="hidden" name="mKey" value="<%=mKey%>">
		<input type="hidden" style="width:100%;" name="gopaymethod" value="Card" >
		<input type="hidden" style="width:100%;" name="offerPeriod" value="20151001-20151231" >
		<input type="hidden" style="width:100%;" name="acceptmethod" value="CARDPOINT:HPP(1):no_receipt:va_receipt:below1000" >
		<input type="hidden" style="width:100%;" name="languageView" value="ko" >
		<input type="hidden" style="width:100%;" name="charset" value="UTF-8" >
		<input type="hidden" style="width:100%;" name="payViewType" value="popup" >
		<input type="hidden" style="width:100%;" name="closeUrl" value="<%=siteDomain%>/close.jsp" >
		<input type="hidden" style="width:100%;" name="popupUrl" value="<%=siteDomain%>/popup.jsp" >
		<input type="hidden" style="width:100%;" name="quotabase" value="<%=cardQuotaBase%>" >
		<input type="hidden" style="width:100%;" name="ini_onlycardcode" value="" >
		<input type="hidden" style="width:100%;" name="ini_cardcode" value="" >
		<input type="hidden" style="width:100%;" name="ansim_quota" value="" >
		<input type="hidden" style="width:100%;" name="INIregno" value="" >
		<input type="hidden" style="width:100%;" name="merchantData" value="" >	
	</form>




	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
		//본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
		function sample4_execDaumPostcode() {
			new daum.Postcode(
					{
						oncomplete : function(data) {
							// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

							// 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
							// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
							var roadAddr = data.roadAddress; // 도로명 주소 변수
							var extraRoadAddr = ''; // 참고 항목 변수

							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraRoadAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraRoadAddr += (extraRoadAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraRoadAddr !== '') {
								extraRoadAddr = ' (' + extraRoadAddr + ')';
							}

							// 우편번호와 주소 정보를 해당 필드에 넣는다.
							document.getElementById('sample4_postcode').value = data.zonecode;
							document.getElementById("sample4_roadAddress").value = roadAddr;

						}
					}).open({
						autoClose: true
					});
		}
		
		
	</script>
	<script>
		function requestPay() {
			if(document.getElementById('sample4_postcode').value != ""
					& document.getElementById('sample4_detailAddress').value != ""){
				var addr1 = document.getElementById('sample4_roadAddress').value;
				var addr2 = document.getElementById('sample4_detailAddress').value;
				var zipcode = document.getElementById('sample4_postcode').value;
				var memberNo = document.getElementById('memberNo').value;
				sessionStorage['addr1'] = addr1;
				sessionStorage['addr2'] = addr2;
				sessionStorage['zipcode'] = zipcode;
				sessionStorage['memberNo'] = memberNo;
				INIStdPay.pay('SendPayForm_id');
			} else {
				alert("우편번호를 입력해주십시오");
			}
			
		}
	</script>
	<script>
	function clearpotcode() {
		document.getElementById('sample4_postcode').value = null;
		document.getElementById('sample4_roadAddress').value = null;
		document.getElementById('sample4_detailAddress').value = null;
		sample4_execDaumPostcode();
	}
	</script>

</body>
</html>