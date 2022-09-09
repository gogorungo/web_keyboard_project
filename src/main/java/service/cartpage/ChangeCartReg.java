package service.cartpage;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.cart.CartDAO;
import model.cart.CartDTO;


public class ChangeCartReg implements Service{
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int memberNo = Integer.parseInt(request.getParameter("memberNo"));
		int itemNo = Integer.parseInt(request.getParameter("itemNo"));
		int count = Integer.parseInt(request.getParameter("count"));
		String msg = null;
		String goUrl = "Cartview?reg=view&memberNo="+request.getParameter("memberNo");
		// 장바구니에 데이터가 있는지 확인(있으면 true)
		if(new CartDAO().CheckMemberCart(memberNo)) {
			new CartDAO().ChangeSelectCount(itemNo,memberNo,count);
			msg = "수량이 변경되었습니다";
		} else { 
			msg = "수량변경 실패";
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("goUrl", goUrl);
		request.setAttribute("memberNo", memberNo);
		request.setAttribute("mainUrl", "./carts/cartAlert");
	}
}
