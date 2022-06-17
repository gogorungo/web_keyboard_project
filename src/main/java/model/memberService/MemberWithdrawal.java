package model.memberService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Service;
import model.member.memberDAO;

public class MemberWithdrawal implements Service{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		int mNo = Integer.valueOf(request.getParameter("memberNo"));
		
		new memberDAO().doWithdrawal(mNo);
		
		
		
		HttpSession session = request.getSession();

		session.removeAttribute("inUser");
		
		request.setAttribute("mainUrl", "./member_view/SignUpReg");
	}

}
