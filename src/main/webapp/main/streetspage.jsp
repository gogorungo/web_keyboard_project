<%@page import="model.item.itemDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.notice.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="model.member.memberDTO"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<title>오시는길</title>
</head>
<body>
	<div class="container" style="margin-top: 20px">
		<div class="row">
			<div class="col">
				<h4>MTS 오시는길</h4>
				<div id="map" style="width:600px;height:400px;"></div>
			</div>
			<div class="col">
				<h4>MTS 기업정보</h4>
				<table class="table">
						<tr align="center">
							<th>회사명</th>
							<td>MTS_KeyboardMarket</td>
						</tr>
						<tr align="center">
							<th>설립일</th>
							<td>2020년 6월 3일</td>
						</tr>
						<tr align="center">
							<th>대표이사(CEO)</th>
							<td>이민혁</td>
						</tr>
						<tr align="center">
							<th>개인정보관리책임(CPO)</th>
							<td>김승화</td>
						</tr>
						<tr align="center">
							<th>기술이사(CTO)</th>
							<td>안태식</td>
						</tr>
						<tr align="center">
							<th>사업자등록번호</th>
							<td>123-45-789123</td>
						</tr>
						<tr align="center">
							<th>사업장 소재지</th>
							<td>서울시 용산구 한강로2가 2-36 현대하이엘 xxx호</td>
						</tr>
						<tr align="center">
							<th>대표전화</th>
							<td>Tel:070-xxxx-xxxx</td>
						</tr>
						<tr align="center">
							<th>홈페이지</th>
							<td>http://qwe2487.cafe24.com</td>
						</tr>
				</table>
			</div>
		</div>
	</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a23cfbd7319f6fe778cbe4e4b174c7fd"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a23cfbd7319f6fe778cbe4e4b174c7fd&libraries=services,clusterer,drawing"></script>
<script>
var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
var options = { //지도를 생성할 때 필요한 기본 옵션
	center: new kakao.maps.LatLng(37.5299835, 126.9681104), //지도의 중심좌표.
	level: 3 //지도의 레벨(확대, 축소 정도)
};

var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
//마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(37.5299835, 126.9681104);
//마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition
});

//마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

var iwContent = '<div style="padding:5px;">MTS<br><a href="https://map.kakao.com/link/map/MTS,37.5299835, 126.9681104" style="color:blue; text-decoration: none;" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/MTS,37.5299835, 126.9681104" style="color:blue; text-decoration: none;" target="_blank">길찾기</a></div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
iwPosition = new kakao.maps.LatLng(37.5299835, 126.9681104); //인포윈도우 표시 위치입니다

//인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({
position : iwPosition, 
content : iwContent 
});

//마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
infowindow.open(map, marker); 

</script>
</body>
</html>

