package service.qnaPage;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.comment.CommentDAO;
import model.qna.QnaDAO;
import model.qna.QnaDTO;

public class QnaList implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {

		int page = (int) request.getAttribute("nowPage");

		int limit = 10; // 한 페이지당 게시물 수
		int pageLimit = 5; // 페이지 번호 갯수

		int total = new QnaDAO().postCount();

		int pageTotal = total / limit;

		if (total % limit > 0) {
			pageTotal++;
		}

		int start = (page - 1) * limit;
		int pageStart = (page - 1) / pageLimit * pageLimit + 1;
		int pageEnd = pageStart + pageLimit - 1;

		if (pageEnd > pageTotal) {
			pageEnd = pageTotal;
		}

		String process = request.getParameter("qnaStatus");

		ArrayList<QnaDTO> dataList = new QnaDAO().list(start, limit);
		ArrayList<QnaDTO> dataListComplete = new QnaDAO().complete(start, limit);
		ArrayList<QnaDTO> dataListTotal = new QnaDAO().total(start, limit);

		for (QnaDTO qnaDTO : dataListTotal) {
			new CommentDAO().answerCount(qnaDTO);
		}

		request.setAttribute("qnaData", dataList);
		request.setAttribute("qnaDataComplete", dataListComplete);
		request.setAttribute("qnaDataTotal", dataListTotal);
		request.setAttribute("process", process);
		request.setAttribute("mainUrl", "./qnas/qnaListpage");

		request.setAttribute("start", start);
		request.setAttribute("limit", limit);
		request.setAttribute("pageTotal", pageTotal);
		request.setAttribute("pageStart", pageStart);
		request.setAttribute("pageEnd", pageEnd);
	}

}