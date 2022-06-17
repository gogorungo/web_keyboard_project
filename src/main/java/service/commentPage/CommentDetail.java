package service.commentPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Service;
import model.comment.CommentDAO;

public class CommentDetail implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {

		HttpSession session = request.getSession();

		int id = Integer.parseInt(request.getParameter("commentNo"));

		Object dataDetail = new CommentDAO().detail(id);
		
		if (dataDetail != null) {
			session.setAttribute("commentNum", dataDetail);
		}

		request.setAttribute("dto", dataDetail);
		request.setAttribute("mainUrl", "./comments/commentDetailpage");

	}

}