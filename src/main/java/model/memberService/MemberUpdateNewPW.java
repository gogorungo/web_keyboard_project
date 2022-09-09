package model.memberService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Service;
import model.member.memberDAO;

public class MemberUpdateNewPW implements Service{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		String userId = (String) session.getAttribute("userID");
		String userPw = request.getParameter("user_pw");
		
		new memberDAO().updatePW(userId, userPw);
		
		String msg = "비밀번호가 변경되었습니다";
		request.setAttribute("msg", msg);
		request.setAttribute("goUrl", "./Login");
		request.setAttribute("mainUrl", "/member_view/alert");
	}

}
