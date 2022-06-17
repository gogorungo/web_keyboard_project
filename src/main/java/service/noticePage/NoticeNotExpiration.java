package service.noticePage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.notice.NoticeDAO;

public class NoticeNotExpiration implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {

		int no = Integer.parseInt(request.getParameter("noticeNo"));
		String msg = null;

		new NoticeDAO().notExpirationUpdate(no);
		msg = "만료 게시물을 복구했어요.";
		
		request.setAttribute("msg", msg);
		request.setAttribute("mainUrl", "./notices/noticeAlert");
		request.setAttribute("goUrl", "../admin/NoticeControl");
	}

}
