package service.commentPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Service;
import model.comment.CommentDAO;
import model.comment.CommentDTO;
import model.member.memberDTO;
import model.qna.QnaDAO;
import model.qna.QnaDTO;

public class CommentInsertReg implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String msg = null;
		HttpSession session = request.getSession();
		memberDTO mDTO = (memberDTO) session.getAttribute("inUser");
		QnaDTO qDTO = (QnaDTO) session.getAttribute("qnaNum");
		int memberNum = mDTO.getMemberNo();
		String getName = mDTO.getName();
		String getId = mDTO.getUser_id();
		String getSubject = request.getParameter("subject");
		String getComment = request.getParameter("comment");
		int qNum = qDTO.getQnaNo();
		
		CommentDTO dto = new CommentDTO();
		dto.setSubject(getSubject);
		dto.setUser_id(getId);
		dto.setPname(getName);
		dto.setComment(getComment);
		dto.setQnaNo(qNum);
		dto.setMemberNo(memberNum);
		msg = "댓글을 작성했어요 :)";
		new CommentDAO().insert(dto);
		System.out.println(dto);
		
		new QnaDAO().processUpdate(qDTO);

		request.setAttribute("msg", msg);
		request.setAttribute("mainUrl", "./comments/commentAlert");
		request.setAttribute("goUrl", "../admin/QnaControl");
	}
}
