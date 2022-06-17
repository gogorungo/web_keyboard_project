package service.adminpage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.item.itemDTO;
import model.member.memberDAO;
import model.member.memberDTO;
import model.order.OrderDAO;
import model.order.OrderDTO;

public class AdminRefund implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		String oOrdered_num = request.getParameter("ordered_num");
		String oOrderNo = request.getParameter("orderNo");
		
		//주문정보
		OrderDTO orderData = new OrderDAO().orderSelect(Integer.parseInt(oOrderNo));
		
		//상품정보
		itemDTO itemData = new OrderDAO().orderDetail(orderData.getItem_name());
		
		//유저정보
		memberDTO userData = new memberDAO().detail(orderData.getMemberNo());
		
		request.setAttribute("userData", userData);
		request.setAttribute("itemData", itemData);
		request.setAttribute("orderData", orderData);
		request.setAttribute("mainUrl", "./admins/AdminRefundForm");
		
	}

}
