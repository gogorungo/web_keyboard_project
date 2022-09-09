package service.adminpage;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.member.memberDAO;

import model.order.OrderDAO;
import model.order.OrderDTO;


public class OrderView implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String orderNum = request.getParameter("orderNum");
		ArrayList<OrderDTO> OrderList = new OrderDAO().SearchOrederedNum(orderNum);
		String memberid = new memberDAO().detail(OrderList.get(0).getMemberNo()).getUser_id();
		
		request.setAttribute("OrderList", OrderList);
		request.setAttribute("main", OrderList.get(0));
		request.setAttribute("memberid", memberid);
		request.setAttribute("orderNum", orderNum);
		request.setAttribute("mainUrl", "./admins/orderviewpage");

	}
}
