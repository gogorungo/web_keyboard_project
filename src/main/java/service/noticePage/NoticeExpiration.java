package service.noticePage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.main.MainNoticeDAO;
import model.notice.NoticeDAO;

public class NoticeExpiration implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {

		int no = Integer.parseInt(request.getParameter("noticeNo"));
		String msg = null;

		new NoticeDAO().expirationUpdate(no);
		new MainNoticeDAO().removeitem(no);
		msg = "만료처리가 되었어요.";
		
		request.setAttribute("msg", msg);
		request.setAttribute("mainUrl", "./notices/noticeAlert");
		request.setAttribute("goUrl", "../admin/NoticeControl");
	}

}
