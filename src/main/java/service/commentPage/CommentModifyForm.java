package service.commentPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.comment.CommentDAO;

public class CommentModifyForm implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {

		int no = Integer.parseInt(request.getParameter("commentNo"));

		Object dataDetail = new CommentDAO().detail(no);

		request.setAttribute("dto", dataDetail);
		request.setAttribute("mainUrl", "./comments/commentModifypage");

	}

}