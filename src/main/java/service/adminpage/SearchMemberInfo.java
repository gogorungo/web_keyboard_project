package service.adminpage;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.member.memberDAO;
import model.member.memberDTO;
import model.order.OrderDAO;
import model.order.OrderDTO;

public class SearchMemberInfo implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int memberNo = Integer.parseInt(request.getParameter("memberNo"));
	
		memberDTO member = new memberDAO().detail(memberNo);
		ArrayList<OrderDTO> orderList = new OrderDAO().searchOrdr(memberNo);
		ArrayList<OrderDTO> mainList = new ArrayList<OrderDTO>();
		for (int i = 0; i < orderList.size(); i++) {
			boolean res = true;
			for (int j = 0; j < mainList.size(); j++) {
				if (mainList.get(j).getOrdered_num().equals(orderList.get(i).getOrdered_num())) {
					mainList.get(j).setPrice(mainList.get(j).getPrice() + orderList.get(i).getPrice()*orderList.get(i).getSelect_count());
					mainList.get(j)
							.setSelect_count(mainList.get(j).getSelect_count() + orderList.get(i).getSelect_count());
					res = false;
					break;
				}
			}
			if (res) {
				orderList.get(i).setPrice(orderList.get(i).getPrice()*orderList.get(i).getSelect_count());
				mainList.add(orderList.get(i));
			}
		}
		
		
		request.setAttribute("name", member.getUser_id());
		request.setAttribute("mainList", mainList);
		request.setAttribute("mainUrl", "./admins/membersearchinfopage");
		
	}
}
