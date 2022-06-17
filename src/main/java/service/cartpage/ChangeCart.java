package service.cartpage;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.cart.CartDAO;
import model.cart.CartDTO;
import model.item.itemDAO;
import model.item.itemDTO;


public class ChangeCart implements Service{
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int memberNo = Integer.parseInt(request.getParameter("memberNo"));
		int itemNo = Integer.parseInt(request.getParameter("itemNo"));
		
		CartDTO cartdto = new CartDAO().CartDetail(itemNo, memberNo);
		
		
		request.setAttribute("cartdto", cartdto);
		request.setAttribute("mainUrl", "./carts/changecartpage");
	}
}
