package service.adminpage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.order.OrderDAO;

public class AdminRefundCancel implements Service{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		String order_no = request.getParameter("orderNo");
		
		new OrderDAO().refundCancle(Integer.parseInt(order_no));
		
		
		request.setAttribute("mainUrl", "./admins/goAdmin");
	}

}
