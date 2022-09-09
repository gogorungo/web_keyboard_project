package service.adminpage;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.qna.QnaDAO;
import model.qna.QnaDTO;

public class QnaControl implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {


		// 1.미답변 리스트
		ArrayList<QnaDTO> PostList = new QnaDAO().Currentlist("미답변");
		// 2.답변 리스트
		ArrayList<QnaDTO> EndList = new QnaDAO().Currentlist("답변");

		request.setAttribute("PostList", PostList);
		request.setAttribute("EndList", EndList);
		request.setAttribute("mainUrl", "./admins/qnaControlPage");

	}

}
