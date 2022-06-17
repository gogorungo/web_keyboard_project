package model.memberService;

import java.util.ArrayList;

import javax.jws.Oneway;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Service;
import model.member.memberDAO;
import model.member.memberDTO;
import model.order.OrderDAO;
import model.order.OrderDTO;

public class MemberCancelList implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();

		memberDTO member = (memberDTO) session.getAttribute("inUser");

		int memberNo = member.getMemberNo();

//		int page;
//		if(request.getAttribute("nowPage") != null) {
//			page = (int)request.getAttribute("nowPage");
//		}else {
//			page = 1;
//		}
//		
//		int limit = 10; // 한 페이지당 게시물 수
//		int pageLimit = 10; // 페이지 번호 갯수
//		
//		
//		int total = new memberDAO().totalCnt(memberNo);
//		
//		int pageTotal = total/limit;
//		
//		// 나머지가 있다면 +1
//		if(total%limit > 0) {
//			pageTotal++;
//		}
//		
//		int start = (page-1)*limit;
//		int pageStart = (page-1)/pageLimit*pageLimit+1;
//		int pageEnd = pageStart+pageLimit-1;
//		
//		if(pageEnd>pageTotal) {
//			pageEnd = pageTotal;
//		}

//		Object data = new memberDAO().orderList(start,limit,memberNo);

		// 1.주문취소 리스트
		ArrayList<OrderDTO> orderList = new OrderDAO().SearchMemberNolist("%주문취소%", memberNo);
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
				} else {
					
				}
			}
			if (res) {
				orderList.get(i).setPrice(orderList.get(i).getPrice()*orderList.get(i).getSelect_count());
				mainList.add(orderList.get(i));
			}
		}
		

		// 2.반품 리스트
		ArrayList<OrderDTO> shippingList = new OrderDAO().SearchMemberNolist("%반품%", memberNo);
		ArrayList<OrderDTO> mainshippingList = new ArrayList<OrderDTO>();
		for (int i = 0; i < shippingList.size(); i++) {
			boolean res = true;
			for (int j = 0; j < mainshippingList.size(); j++) {
				if (mainshippingList.get(j).getOrdered_num().equals(shippingList.get(i).getOrdered_num())) {
					mainshippingList.get(j).setPrice(mainshippingList.get(j).getPrice() + shippingList.get(i).getPrice()*shippingList.get(i).getSelect_count());
					mainshippingList.get(j)
							.setSelect_count(mainshippingList.get(j).getSelect_count() + shippingList.get(i).getSelect_count());
					res = false;
					break;
				}
			}
			if (res) {
				shippingList.get(i).setPrice(shippingList.get(i).getPrice()*shippingList.get(i).getSelect_count());
				mainshippingList.add(shippingList.get(i));
			}
		}

		// 3.교환 리스트
		ArrayList<OrderDTO> endList = new OrderDAO().SearchMemberNolist("%교환%", memberNo);
		ArrayList<OrderDTO> mainendList = new ArrayList<OrderDTO>();
		for (int i = 0; i < endList.size(); i++) {
			boolean res = true;
			for (int j = 0; j < mainendList.size(); j++) {
				if (mainendList.get(j).getOrdered_num().equals(endList.get(i).getOrdered_num())) {
					mainendList.get(j).setPrice(mainendList.get(j).getPrice() + endList.get(i).getPrice()*endList.get(i).getSelect_count());
					mainendList.get(j)
							.setSelect_count(mainendList.get(j).getSelect_count() + endList.get(i).getSelect_count());
					res = false;
					break;
				}
			}
			if (res) {
				endList.get(i).setPrice(endList.get(i).getPrice()*endList.get(i).getSelect_count());
				mainendList.add(endList.get(i));
			}
		}

		request.setAttribute("mainList", mainList);
		request.setAttribute("mainshippingList", mainshippingList);
		request.setAttribute("mainendList", mainendList);
		request.setAttribute("mainUrl", "member_view/CancelForm");
	}

}