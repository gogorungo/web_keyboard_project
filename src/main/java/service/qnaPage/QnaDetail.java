package service.qnaPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Service;
import model.qna.QnaDAO;
import model.qna.QnaDTO;

public class QnaDetail implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		HttpSession session = request.getSession();

		int id = Integer.parseInt(request.getParameter("qnaNo"));
		
		QnaDTO dataDetail = new QnaDAO().detail(id);
		
		if (dataDetail != null) {
			session.setAttribute("qnaNum", dataDetail);
		}

		request.setAttribute("dto", dataDetail);
		request.setAttribute("mainUrl", "./qnas/qnaDetailpage");

	}

}