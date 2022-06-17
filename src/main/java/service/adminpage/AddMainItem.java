package service.adminpage;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.item.itemDAO;
import model.item.itemDTO;
import model.main.MainDAO;
import model.main.MainDTO;
import model.main.MainNoticeDAO;
import model.main.MainNoticeDTO;
import model.notice.NoticeDAO;
import model.notice.NoticeDTO;

public class AddMainItem implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {

		ArrayList<itemDTO> itemList = new itemDAO().list();

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

		ArrayList<itemDTO> IList = new ArrayList<itemDTO>();
		for (int i = 0; i < itemList.size(); i++) {
			boolean res = true;
			for (int j = 0; j < GList.size(); j++) {
				if (itemList.get(i).getItemNo() == GList.get(j).getItemNo()) {
					res = false;
					break;
				}
			}
			for (int j = 0; j < NList.size(); j++) {
				if (itemList.get(i).getItemNo() == NList.get(j).getItemNo()) {
					res = false;
					break;
				}
			}
			if (res) {
				IList.add(itemList.get(i));
			}
		}

		request.setAttribute("IList", IList);
		request.setAttribute("mainUrl", "./admins/addmainitempage");

	}
}
