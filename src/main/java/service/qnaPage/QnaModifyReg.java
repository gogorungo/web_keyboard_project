package service.qnaPage;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.qna.QnaDAO;
import model.qna.QnaDTO;

public class QnaModifyReg implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		QnaDTO dto = new QnaDTO();
		dto.setQnaNo(Integer.parseInt(request.getParameter("qnaNo")));
		dto.setSubject(request.getParameter("subject"));
		dto.setPname(request.getParameter("pname"));
		dto.setContent(request.getParameter("content"));
		dto.setOrdered_num(request.getParameter("select_orderNum"));

		int res = new QnaDAO().modify(dto);

		String msg = "수정 되지 않았어요 ㅠㅠ", goUrl = "qnaModifyForm?qnaNo=" + dto.getQnaNo();

		if (res > 0) {
			msg = "수정이 완료되었어요.";
			goUrl = "qnaDetail?qnaNo=" + dto.getQnaNo();
		}

		request.setAttribute("msg", msg);
		request.setAttribute("mainUrl", "./qnas/qnaAlert");
		request.setAttribute("goUrl", "QnaList");

	}

}