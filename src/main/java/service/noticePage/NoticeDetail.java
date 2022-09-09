package service.noticePage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Service;
import model.notice.NoticeDAO;

public class NoticeDetail implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();
		
		int id = Integer.parseInt(request.getParameter("noticeNo"));

		Object dataDetail = new NoticeDAO().detail(id);
		
		if (dataDetail != null) {
			session.setAttribute("noticeNum", dataDetail);
		}

		request.setAttribute("dto", dataDetail);
		request.setAttribute("mainUrl", "./notices/noticeDetailpage");

	}

}