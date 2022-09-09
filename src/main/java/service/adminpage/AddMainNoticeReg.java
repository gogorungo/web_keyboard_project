package service.adminpage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.main.MainNoticeDAO;
import model.notice.NoticeDAO;
import model.notice.NoticeDTO;

public class AddMainNoticeReg implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {

		int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
		NoticeDTO dto = new NoticeDAO().detail(noticeNo);
		String msg = null;
		String goUrl = "AddMainNotice";
		if(new MainNoticeDAO().insert(dto)) {
			msg = "메인화면에 공지사항을 추가했어요.";
		} else {
			msg = "메인화면에 공지사항을 추가하지 못했어요.";
		}
		
		
		request.setAttribute("msg", msg);
		request.setAttribute("goUrl", goUrl);
		request.setAttribute("mainUrl", "./admins/adminAlert");
	}
}