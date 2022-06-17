package service.cartpage;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.cart.CartDAO;
import model.cart.CartDTO;

public class Cartview implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String reg = request.getParameter("reg");
		int memberNo = Integer.parseInt(request.getParameter("memberNo")); // 멤버 기본키 로그인시 받아올 예정
		
		
		// 장바구니 보기
		if (reg.equals("view")) {
			ArrayList<CartDTO> cartList = new CartDAO().list(memberNo);
			// System.out.println(cartList.size());
			request.setAttribute("cartList", cartList);
			request.setAttribute("mainUrl", "./carts/cartpage");
		}

		// 장바구니 추가일때
		if (reg.equals("addCart")) {
			int itemNo = Integer.parseInt(request.getParameter("itemNo"));
			// 이미 장바구니에 있는지 확인(없으면 true)
			if (new CartDAO().CheckCart(itemNo, memberNo)) { // 없으면 추가
				CartDTO dto = new CartDAO().ItemToCartDTO(itemNo);
				dto.setSelected_count(Integer.parseInt(request.getParameter("count")));
				dto.setMemberNo(memberNo);
				SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
				String strNowDate = simpleDateFormat.format(new Date());
				dto.setReg_date(strNowDate);
				new CartDAO().insert(dto); // DB에 추가
				ArrayList<CartDTO> cartList = new CartDAO().list(memberNo);
				// System.out.println(cartList.size());
				request.setAttribute("cartList", cartList);
				request.setAttribute("mainUrl", "./carts/cartpage");
			} else { // 이미 alert창
				String msg = "장바구니에 상품이 있습니다";
				String goUrl = "Cartview?reg=view&memberNo="+request.getParameter("memberNo");
				request.setAttribute("msg", msg);
				request.setAttribute("goUrl", goUrl);
				request.setAttribute("memberNo", memberNo);
				request.setAttribute("mainUrl", "./carts/cartAlert");
			}
		}

		
		
	}
}
