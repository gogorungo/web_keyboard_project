package model.memberService;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Service;
import model.item.itemDAO;
import model.item.itemDTO;
import model.main.MainDAO;
import model.main.MainDTO;
import model.main.MainNoticeDAO;
import model.main.MainNoticeDTO;
import model.member.memberDTO;
import model.notice.NoticeDAO;
import model.notice.NoticeDTO;

public class MemberLogout implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();

		memberDTO user = (memberDTO) session.getAttribute("inUser");

		session.removeAttribute("inUser");;

		// 메인 페이지 수정하면서 에러떠서 임시조치
		// 1.추천상품 리스트
		ArrayList<MainDTO> GoodList = new MainDAO().Currentlist("추천상품");
		ArrayList<itemDTO> GList = new ArrayList<itemDTO>();
		for (MainDTO res : GoodList) {
			GList.add(new itemDAO().Detail(res.getItemNo()));
		}
		// 2.신상품 리스트
		ArrayList<MainDTO> NewList = new MainDAO().Currentlist("신상품");
		ArrayList<itemDTO> NList = new ArrayList<itemDTO>();
		for (MainDTO res : NewList) {
			NList.add(new itemDAO().Detail(res.getItemNo()));
		}

		// 3.주요공지사항 리스트
		ArrayList<MainNoticeDTO> NoticeList = new MainNoticeDAO().Currentlist();
		ArrayList<NoticeDTO> M_NoticeList = new ArrayList<NoticeDTO>();
		for (MainNoticeDTO res : NoticeList) {
			M_NoticeList.add(new NoticeDAO().detail(res.getNoticeNo()));
		}
		request.setAttribute("GList", GList);
		request.setAttribute("NList", NList);
		request.setAttribute("M_NoticeList", M_NoticeList);
		
		String msg = "로그아웃 되었습니다";
		
		request.setAttribute("msg", msg);
		request.setAttribute("goUrl", "../mainpage/MainService");
		request.setAttribute("mainUrl", "/member_view/alert");
	}

}
