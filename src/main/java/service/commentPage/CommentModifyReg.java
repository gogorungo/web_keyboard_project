package service.commentPage;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.comment.CommentDAO;
import model.comment.CommentDTO;

public class CommentModifyReg implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		CommentDTO dto = new CommentDTO();
		dto.setCommentNo(Integer.parseInt(request.getParameter("commentNo")));
		dto.setSubject(request.getParameter("subject"));
		dto.setPname(request.getParameter("pname"));
		dto.setComment(request.getParameter("comment"));

		int res = new CommentDAO().modify(dto);

		String msg = "수정 되지 않았어요 ㅠㅠ", goUrl = "commentModifyForm?commentNo=" + dto.getCommentNo();

		if (res > 0) {
			msg = "수정이 완료되었어요.";
			goUrl = "commentDetail?commentNo=" + dto.getCommentNo();
		}

		request.setAttribute("msg", msg);
		request.setAttribute("mainUrl", "./comments/commentAlert");
		request.setAttribute("goUrl", "../admin/QnaControl");

	}

}