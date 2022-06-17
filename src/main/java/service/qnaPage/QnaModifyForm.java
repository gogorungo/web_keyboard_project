package service.qnaPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.qna.QnaDAO;

public class QnaModifyForm implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {

		int no = Integer.parseInt(request.getParameter("qnaNo"));

		Object dataDetail = new QnaDAO().detail(no);

		request.setAttribute("dto", dataDetail);
		request.setAttribute("mainUrl", "./qnas/qnaModifypage");

	}

}