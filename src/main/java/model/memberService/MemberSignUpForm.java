package model.memberService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Service;

public class MemberSignUpForm implements Service{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String email = (String) session.getAttribute("email");
		
		request.setAttribute("email", email);
		request.setAttribute("mainUrl", "./member_view/SignUpForm");
	}
}
