package model.memberService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Service;
import model.member.memberDAO;
import model.member.memberDTO;

public class MemberGoDetail implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();

		memberDTO user = (memberDTO) session.getAttribute("inUser");
		
		String msg = "";
		int id = user.getMemberNo();
		String userPW = request.getParameter("user_pw");
		
		int chk = new memberDAO().checkPW(id, userPW);
		
		if(chk > 0) {
		
			// close 하면 detail 에서 접속이안된다.
			
			memberDTO data = new memberDAO().detail(id);
			
			
			String tel = data.getTel();
			
			String tel1 = tel.substring(0,3);
			String tel2 = tel.substring(3,7);
			String tel3 = tel.substring(7);
			
			data.setTel1(tel1);
			data.setTel2(tel2);
			data.setTel3(tel3);
			
			msg = "인증 성공";
			request.setAttribute("msg", msg);
			request.setAttribute("dto", data);
			request.setAttribute("goUrl", "./GoGoDetail");
			request.setAttribute("mainUrl", "/member_view/alert");
		}else {
			msg = "인증 실패";
			request.setAttribute("msg", msg);
			request.setAttribute("goUrl", "../mainpage/MainService");
			request.setAttribute("mainUrl", "/member_view/alert");
		}

	}

}
