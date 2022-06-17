package service.adminpage;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.main.MainNoticeDAO;
import model.main.MainNoticeDTO;
import model.notice.NoticeDAO;
import model.notice.NoticeDTO;

public class AddMainNotice implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {


		
		ArrayList<MainNoticeDTO> NoticeList = new MainNoticeDAO().Currentlist();
		ArrayList<NoticeDTO> M_NoticeList = new ArrayList<NoticeDTO>();
		for (MainNoticeDTO res : NoticeList) {
			M_NoticeList.add(new NoticeDAO().detail(res.getNoticeNo()));
		}

		ArrayList<NoticeDTO> AllNoticeList = new NoticeDAO().Currentlist("게시");
		for (int i = 0; i < AllNoticeList.size(); i++) {
			for (int j = 0; j < M_NoticeList.size(); j++) {
				if (AllNoticeList.get(i).getNoticeNo() == M_NoticeList.get(j).getNoticeNo()) {
					AllNoticeList.remove(i);
					i--;
					break;
				}
			}
		}
		
		ArrayList<MainNoticeDTO> mainPostList = new MainNoticeDAO().CurrentPostList("게시중");

		request.setAttribute("AllNoticeList", AllNoticeList);
		request.setAttribute("mainPostList", mainPostList);
		request.setAttribute("mainUrl", "./admins/addMainnoticepage");

	}
}