package service.commentPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.comment.CommentDAO;

public class CommentList implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		Object dataList = new CommentDAO().list();

		request.setAttribute("commentData", dataList);
		request.setAttribute("mainUrl", "./comments/commentListpage");

	}

}
