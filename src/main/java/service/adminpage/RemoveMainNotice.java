package service.adminpage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.main.MainNoticeDAO;

public class RemoveMainNotice implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
		String msg = null;
		String goUrl = "AddMainNotice";
		if(new MainNoticeDAO().removeitem(noticeNo)) {
			msg = "메인화면에서 공지사항을 내렸어요.";
		} else {
			msg = "메인화면에서 공지사항을 내리지 못했어요.";
		}
		
		
		request.setAttribute("msg", msg);
		request.setAttribute("goUrl", goUrl);
		request.setAttribute("mainUrl", "./admins/adminAlert");
	}
}
