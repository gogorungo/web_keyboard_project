package service.adminpage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.member.memberDAO;
import model.member.memberDTO;

public class MemberEdit implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {

		int memberNo = Integer.parseInt(request.getParameter("memberNo"));
		memberDTO getMember = new memberDAO().detail(memberNo);
		
		request.setAttribute("getMember", getMember);
		request.setAttribute("mainUrl", "./admins/membereditpage");
	}
}
