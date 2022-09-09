package service.qnaPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Service;
import model.member.memberDTO;
import model.qna.QnaDAO;
import model.qna.QnaDTO;
import test.XssUtil;

public class QnaInsertReg implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String msg = null;
		HttpSession session = request.getSession();
		memberDTO mDTO = (memberDTO) session.getAttribute("inUser");
		int memberNum = mDTO.getMemberNo();
		String getId = mDTO.getUser_id();
		
			QnaDTO dto = new QnaDTO();
			dto.setSubject(request.getParameter("subject"));
			dto.setUser_id(getId);
			dto.setPname(request.getParameter("pname"));
			dto.setContent(request.getParameter("content"));
			dto.setMemberNo(memberNum);
			dto.setStatus("미답변");
			dto.setOrdered_num(request.getParameter("select_orderNum"));
			msg = "게시글을 작성했어요 :)";
			new QnaDAO().insert(dto);
			System.out.println(dto);
			
		request.setAttribute("msg", msg);
		request.setAttribute("mainUrl", "./qnas/qnaAlert");
		request.setAttribute("goUrl", "QnaList");
	}
}
