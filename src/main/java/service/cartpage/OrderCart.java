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
import model.member.memberDAO;
import model.member.memberDTO;

public class OrderCart implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int memberNo = 0; // 멤버 기본키 로그인시 받아올 예정
		HttpSession user = request.getSession();
		memberDTO dto = (memberDTO) user.getAttribute("inUser");
		if (dto != null) {
			memberNo = dto.getMemberNo();
		} 

		Date nowDate = new Date();
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyMMddHHmmss");
		String merchant = simpleDateFormat.format(nowDate);
		String order_num = "MTS"+merchant;
		
		ArrayList<CartDTO> cartList = new CartDAO().list(memberNo);
		memberDTO member = new memberDAO().detail(memberNo);
		request.setAttribute("cartList", cartList);
		request.setAttribute("member", member);
		request.setAttribute("order_num", order_num);
		request.setAttribute("merchant", merchant);
		request.setAttribute("mainUrl", "./carts/orderpage");
	}
}
