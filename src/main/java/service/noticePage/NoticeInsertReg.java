package service.noticePage;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Service;
import model.member.memberDTO;
import model.notice.NoticeDAO;
import model.notice.NoticeDTO;

public class NoticeInsertReg implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String msg = null;
		HttpSession session = request.getSession();
		memberDTO mDTO = (memberDTO) session.getAttribute("inUser");
		String id = mDTO.getUser_id();

			NoticeDTO dto = new NoticeDTO();
			dto.setSubject(request.getParameter("subject"));
			dto.setUser_id(id);
			dto.setPname(request.getParameter("pname"));
			dto.setContent(request.getParameter("content"));
			msg = "공지사항을 작성했어요 :)";
			new NoticeDAO().insert(dto);
			System.out.println(dto);

		request.setAttribute("msg", msg);
		request.setAttribute("mainUrl", "./notices/noticeAlert");
		request.setAttribute("goUrl", "NoticeList");
	}
}
