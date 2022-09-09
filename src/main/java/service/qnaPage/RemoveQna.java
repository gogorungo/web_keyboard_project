package service.qnaPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.qna.QnaDAO;

public class RemoveQna implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {

		int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
		String msg = null;
		
		if (new QnaDAO().removeQna(qnaNo)) {
			msg = "게시글을 삭제했어요.";
		} else {
			msg = "게시글을 삭제하지 못했어요.";
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("goUrl", "../admin/QnaControl");
		request.setAttribute("mainUrl", "./qnas/qnaAlert");

	}

}
