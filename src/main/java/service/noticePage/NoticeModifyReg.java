package service.noticePage;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.notice.NoticeDAO;
import model.notice.NoticeDTO;

public class NoticeModifyReg implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		NoticeDTO dto = new NoticeDTO();
		dto.setNoticeNo(Integer.parseInt(request.getParameter("noticeNo")));
		dto.setSubject(request.getParameter("subject"));
		dto.setPname(request.getParameter("pname"));
		dto.setContent(request.getParameter("content"));

		int res = new NoticeDAO().modify(dto);

		String msg = "수정 되지 않았어요 ㅠㅠ", goUrl = "noticeModifyForm?noticeNo=" + dto.getNoticeNo();

		if (res > 0) {
			msg = "수정이 완료되었어요.";
			goUrl = "noticeDetail?noticeNo=" + dto.getNoticeNo();
		}

		request.setAttribute("msg", msg);
		request.setAttribute("mainUrl", "./notices/noticeAlert");
		request.setAttribute("goUrl", "NoticeList");

	}

}