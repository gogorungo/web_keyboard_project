package service.adminpage;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.item.itemDAO;
import model.item.itemDTO;
import model.order.OrderDAO;
import model.order.OrderDTO;

public class ItemAddStockReg implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int itemNo = Integer.parseInt(request.getParameter("itemNo"));
		int count = Integer.parseInt(request.getParameter("count"));
		int addCount = count+new itemDAO().Detail(itemNo).getStock();
		String msg = null;
		String goUrl = "ItemAddStock?itemNo="+itemNo;
		if(new itemDAO().addStock(itemNo, addCount)) {
			msg = "입고되었습니다";
		} else {
			msg = "처리 실패";
		}
		
		
		request.setAttribute("msg", msg);
		request.setAttribute("goUrl", goUrl);
		request.setAttribute("mainUrl", "./admins/adminAlert");
	}
}
