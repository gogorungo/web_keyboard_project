package service.cartpage;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Service;
import model.cart.CartDAO;
import model.cart.CartDTO;
import model.item.itemDAO;
import model.member.memberDAO;
import model.member.memberDTO;
import model.order.OrderDAO;
import model.order.OrderDTO;

public class OrderEnd implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	
		String ordered_num = (String) request.getSession().getAttribute("tid");
		int memberNo = Integer.parseInt(request.getParameter("memberNo"));
		String addr1 = request.getParameter("addr1");
		String addr2 = request.getParameter("addr2");
		String zipcode = request.getParameter("zipcode");
		//결제완료되면 계속 로그아웃되서 재로그인만듬
		login(request, memberNo);
	
		ArrayList<CartDTO> cartList = new CartDAO().list(memberNo);
		memberDTO member = new memberDAO().detail(memberNo);
		
		Date date = new Date();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String merchant = simpleDateFormat.format(date);
		
	
		for(int i=0; i<cartList.size();i++) {
			new OrderDAO().addOrder(ordered_num,merchant,member,addr1,addr2,cartList.get(i),zipcode);
		}
		new CartDAO().delCart(memberNo); //장바구니 비우기
		
		
		ArrayList<OrderDTO> OrderList = new OrderDAO().SearchOrederedNum(ordered_num);
		String memberid = new memberDAO().detail(OrderList.get(0).getMemberNo()).getUser_id();
		request.setAttribute("main", OrderList.get(0));
		request.setAttribute("memberid", memberid);
		request.setAttribute("orderNum", ordered_num);
		
		request.setAttribute("cartList", cartList);
		request.setAttribute("mainUrl", "./carts/orderendpage");
	}
	
	public void login(HttpServletRequest request, int memberNo) {
		HttpSession session = request.getSession();
		memberDTO dto = new memberDAO().detail(memberNo);

		if (dto != null) {
			session.setAttribute("inUser", dto);
		}
	}
}
