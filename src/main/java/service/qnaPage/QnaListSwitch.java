package service.qnaPage;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.qna.QnaDAO;
import model.qna.QnaDTO;

public class QnaListSwitch implements Service{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		int page = (int) request.getAttribute("nowPage");
		System.out.println(page);

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
		ArrayList<QnaDTO> dao = null;
		
		switch (process) {
			
		case "답변" :
			System.out.println("답변");
			dao = new QnaDAO().complete(start, limit);
			break;
			
		case "미답변" :
			System.out.println("미답변");
			dao = new QnaDAO().list(start, limit);
			break;
		}
		
		request.setAttribute("process", process);
		request.setAttribute("answer", dao);
		request.setAttribute("mainUrl", "./qnas/qnaListpage");
	}

}