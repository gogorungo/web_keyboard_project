package service;

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

public class Street implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("mainUrl", "./main/streetspage");
	}
}

