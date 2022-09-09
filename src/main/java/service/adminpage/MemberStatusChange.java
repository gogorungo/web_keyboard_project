package service.adminpage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.member.memberDAO;

public class MemberStatusChange implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {

		String status = request.getParameter("status");
		int memberNo = Integer.parseInt(request.getParameter("memberNo"));
		String msg = null;
		String goUrl = "MemberControl";
		if(new memberDAO().change(status, memberNo)) {
			msg = "처리 성공";
		} else {
			msg = "처리 실패";
		}
		
		
		request.setAttribute("msg", msg);
		request.setAttribute("goUrl", goUrl);
		request.setAttribute("mainUrl", "./admins/adminAlert");
	}
}
