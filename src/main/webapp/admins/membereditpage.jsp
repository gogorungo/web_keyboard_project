<%@page import="model.item.itemDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Arrays"%>
<%@page import="model.order.OrderDTO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/signUpForm.css" />
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

 	<jsp:include page="../Admintop.jsp" >
		<jsp:param name="URL" value="member"/>
	</jsp:include>
	<div class="jumbotron">
		<div class="container" style="margin-right:-310px;">
			<h3 class="display-4">회원 정보 수정</h3>
			<a href="./MemberControl" class="btn btn-secondary" >회원 목록으로</a>
		</div>
	</div>

<main class="text-center form-signin">
	<form  action="MemberEditReg" name="frm" method="post" >
	<input type="hidden" name="gender" value="${getMember.gender }" />
		<div class="form-floating">
	    		<input type="text" name="memberNo" value="${getMember.memberNo }" class="form-control" id="memberNo" placeholder="아이디" readonly>
	    		<label for="memberNo">회원번호</label>
	    </div>
	    <div class="form-floating">
	    		<input type="text" name="user_id" value="${getMember.user_id }" class="form-control" id="user_id" placeholder="아이디" readonly>
	    		<label for="user_id">아이디</label>
	    </div>	
		<div class="form-floating">
	       <input type="text" name="name" value="${getMember.name }" class="form-control" id="name" placeholder="이름">
	       <label for="name">이름</label>
	    </div>	
	    	    	<div class="form-floating" style="margin-bottom:20px;">
			<input type="date" name="birthdate" class="form-control" value="<fmt:formatDate value="${getMember.birthdate }" pattern="yyyy-MM-dd"/>" placeholder="생일">
	       	<label for="birthdate">생일</label>
		</div>
	    <c:choose>
			<c:when test="${getMember.gender eq 'm' }">
				<div class="form-floating">
			       <input type="text" name="gender" class="form-control" id="gender" placeholder="성별" readonly>
			       <label for="gender">남성</label>
			    </div>
			</c:when>
			<c:when test="${getMember.gender eq 'f' }">
				<div class="form-floating">
			       <input type="text" name="gender" class="form-control" id="gender" placeholder="성별" readonly>
			       <label for="gender">여성</label>
			    </div>
			</c:when>
		</c:choose>
		<div class="form-floating">
			<input type="text" name="email" value='${getMember.email }' class="form-control" id="email" placeholder="이메일">
	    		<label for="email">이메일</label>
		</div>
		<div class="form-floating">
			<input type="text" name="zip_code" class="form-control" value="${getMember.zip_code }" id="member_post" placeholder="주소 입력" readonly onclick="findAddr()">
			<label for="addr">우편번호(클릭)</label>
		</div>
		<div class="form-floating">
			<input type="text" name="addr1" class="form-control" value="${getMember.addr1 }" id="member_addr" placeholder="주소 입력" readonly onclick="findAddr()">
			<label for="addr">주소</label>
		</div>
		<div class="form-floating">
			<input type="text" name="addr2" class="form-control" value="${getMember.addr2 }"  placeholder="상세 주소" >
			<label for="addr">상세주소</label>
		</div>
		<div class="container" style="margin-top:20px;" >
			<div class="row" >
				<div class="col">
					<select class="form-control" name = "tel1" id="tel1" display="inline-block">
						<c:forTokens items="010,011,016,017,019"  delims="," var="tt">
						<c:set  var="ss" value="" />
						<c:if test="${getMember.tel1 eq tt}">
							<c:set  var="ss" value="selected" />
						</c:if>
						<option value="${tt }" ${ss }>${tt }</option>
						</c:forTokens>
					</select>
				</div>
				<div class="col">
					<input type="text" class="form-control" value="${getMember.tel2 }" id="tel2" name="tel2" placeholder="예)1234" />
				</div>
				<div class="col">
					<input type="text" class="form-control" value="${getMember.tel3 }" name="tel3" id="tel3" placeholder="예)1234" />
				</div>
			</div>
		</div>
		<div class="form-floating">
			<input type="text" name="reg_date" class="form-control" value="<fmt:formatDate value="${getMember.reg_date }" pattern="yyyy-MM-dd HH:mm:ss"/>"  placeholder="가입일" readonly>
			<label for="reg_date">가입일</label>
		</div>
		<div style="margin-bottom:20px;">
			<c:choose>
				<c:when test="${getMember.getStatus()  eq '관리자'}">
					<input type='radio' name='status' value='관리자' checked="checked"/>관리자
					<input type='radio' name='status' value='회원' />회원
					<input type='radio' name='status' value='정지' />정지
					<input type='radio' name='status' value='탈퇴' />탈퇴
				</c:when>
				<c:when test="${getMember.getStatus()  eq '회원'}">
					<input type='radio' name='status' value='관리자' />관리자
					<input type='radio' name='status' value='회원' checked="checked"/>회원
					<input type='radio' name='status' value='정지' />정지
					<input type='radio' name='status' value='탈퇴' />탈퇴
				</c:when>
				<c:when test="${getMember.getStatus()  eq '정지'}">
					<input type='radio' name='status' value='관리자' />관리자
					<input type='radio' name='status' value='회원' />회원
					<input type='radio' name='status' value='정지' checked="checked"/>정지
					<input type='radio' name='status' value='탈퇴' />탈퇴
				</c:when>	
				<c:when test="${getMember.getStatus()  eq '탈퇴'}">
					<input type='radio' name='status' value='관리자' />관리자
					<input type='radio' name='status' value='회원' />회원
					<input type='radio' name='status' value='정지'/>정지
					<input type='radio' name='status' value='탈퇴'  checked="checked"/>탈퇴
				</c:when>						
			</c:choose>
		</div>
		<button class="w-100 btn btn-lg btn-primary" type="button" onclick="checkform()" >회원정보 수정</button>
	</form>
</main>


<script type="text/javascript">

	
	function findAddr(){
		new daum.Postcode({
	        oncomplete: function(data) {
	        	
	        	console.log(data);
	        	
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var roadAddr = data.roadAddress; // 도로명 주소 변수
	            var jibunAddr = data.jibunAddress; // 지번 주소 변수
	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById('member_post').value = data.zonecode;
	            if(roadAddr !== ''){
	                document.getElementById("member_addr").value = roadAddr;
	            } 
	            else if(jibunAddr !== ''){
	                document.getElementById("member_addr").value = jibunAddr;
	            }
	        }
	    }).open();
	}

	//유효성검사
	  function checkform() {
		  var spacing =  /\s/g; // 띄어쓰기 체크
			var newLine =  /\n/g; // 개행문자 체크 (제거로 만들자) 
			
			
			var form = document.frm;
			
			var uName = form.name.value;
			var userEmail = form.email.value;
			var uAddr2 = form.addr2.value;
			var uTel2 = form.tel2.value;
			var uTel3 = form.tel3.value;
			
		
			if(uName == ""){
				alert("이름을 입력하세요.");
			    form.name.select;
			    return false;
			}
			
			if(spacing.test(uName)){
				alert("이름에는 빈 칸이 없어야 합니다");
				form.name.select;
			    return false;
			}
			
			var regExpName = /^[가-힣a-zA-Z]{2,10}$/; //이름. 한글, 영어만 가능
			if(!regExpName.test(uName)){
				alert("이름은 한글과 영어만 가능합니다. (최소 2글자 최대 10글자)");
				form.name.select;
			    return false;
			}

	 		if(userEmail == ""){
				alert("이메일을 입력하세요.");
				form.email.select;
			    return false;
			}
			
	 		if(spacing.test(userEmail)){
				alert("빈 칸이 없어야 합니다");
				form.email.select;
			    return false;
			}
			
			if(newLine.test(userEmail)){
				alert("입력에러. 다시 입력해주세요.");
				form.email.select;
			    return false;
			}
			
			var regExpEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
			if(!regExpEmail.test(userEmail)){
				alert("이메일의 형식에 맞춰 입력해주세요 (test@test.com)");
				form.email.select;
			    return false;
			}
			
			var regExpAddr2 = /^[가-힣a-zA-Z\d\s]{0,30}$/; //주소
			if(!regExpAddr2.test(uAddr2)){
				alert("주소는 한글과 영어, 숫자만 입력 가능합니다. (최대 30글자)");
				form.addr2.select;
			    return false;
			}
			
			if(uTel2 == ""){
				alert("전화번호를 입력해주세요");
			    form.tel2.select;
			    return false;
			}
			
			if(spacing.test(uTel2)){
				alert("전화번호에는 빈 칸이 없어야 합니다");
				form.tel2.select;
			    return false;
			}
			
			var regExpTel2 = /^[0-9]{4}$/; //숫자만 가능. 4자리
			if(!regExpTel2.test(uTel2)){
				alert("전화번호는 4자리의 숫자만 입력 가능합니다.");
				form.tel2.select;
			    return false;
			}
			
			if(uTel3 == ""){
				alert("전화번호를 입력해주세요");
			    form.tel3.select;
			    return false;
			}
			
			if(spacing.test(uTel3)){
				alert("전화번호에는 빈 칸이 없어야 합니다");
				form.tel3.select;
			    return false;
			}
			var regExpTel3 = /^[0-9]{4}$/; //숫자만 가능. 4자리
			if(!regExpTel3.test(uTel3)){
				alert("전화번호는 4자리의 숫자만 입력 가능합니다.");
				form.tel3.select;
			    return false;
			}
			form.submit();

		}

</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

