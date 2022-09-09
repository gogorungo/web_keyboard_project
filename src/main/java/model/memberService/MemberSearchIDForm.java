package model.memberService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Service;

public class MemberSearchIDForm implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		
		session.setAttribute("fromURL", "searchID");
		
		request.setAttribute("mainUrl", "./member_view/SearchIDForm");
	}
}
