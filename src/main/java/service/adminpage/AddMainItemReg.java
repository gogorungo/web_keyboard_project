package service.adminpage;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.item.itemDAO;
import model.item.itemDTO;
import model.main.MainDAO;
import model.order.OrderDAO;
import model.order.OrderDTO;

public class AddMainItemReg implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {

		int itemNo = Integer.parseInt(request.getParameter("itemNo"));
		String status = request.getParameter("status");
		String msg = null;
		String goUrl = "MainControl";
		if(new MainDAO().insert(itemNo, status)) {
			msg = "처리 성공";
		} else {
			msg = "처리 실패";
		}
		
		
		request.setAttribute("msg", msg);
		request.setAttribute("goUrl", goUrl);
		request.setAttribute("mainUrl", "./admins/adminAlert");
	}
}
