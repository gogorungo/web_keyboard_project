package service.adminpage;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.member.memberDAO;
import model.member.memberDTO;

public class MemberEditReg implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		
		
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        
			
			String msg = null;
			String goUrl = "MemberControl";
			
			memberDTO dto = new memberDTO();
			dto.setMemberNo(Integer.parseInt(request.getParameter("memberNo")));
			dto.setUser_id(request.getParameter("user_id"));
			//dto.setUser_pw(request.getParameter("user_pw")); 비밀번호 토큰화 작업후 작업하는게좋음
			dto.setName(request.getParameter("name"));
			
			String strDate = request.getParameter("birthdate");
	        Date date = new Date(sdf.parse(strDate).getTime());
			
			dto.setBirthdate(date); 
			dto.setGender(request.getParameter("gender"));
			dto.setEmail(request.getParameter("email"));
			dto.setZip_code(request.getParameter("zip_code"));
			dto.setAddr1(request.getParameter("addr1"));
			dto.setAddr2(request.getParameter("addr2"));
			
			String tel1 = request.getParameter("tel1");
			String tel2 = request.getParameter("tel2");
			String tel3 = request.getParameter("tel3");
			String tel = tel1 + tel2 + tel3;
			dto.setTel(tel);
			dto.setStatus(request.getParameter("status"));
			
			int res = new memberDAO().Adminmodify(dto);
			
			
		
			if(res>0) {
				msg="수정성공";
			} else {
				msg = "수정실패";
				goUrl = "MemberEdit?memberNo="+dto.getMemberNo();
			}
			
			request.setAttribute("msg", msg);
			request.setAttribute("goUrl", goUrl);
			request.setAttribute("mainUrl", "./admins/adminAlert");
		
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
