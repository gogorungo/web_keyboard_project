package service.adminpage;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.cart.CartDAO;
import model.cart.CartDTO;
import model.member.memberDAO;
import model.member.memberDTO;
import model.order.OrderDAO;
import model.order.OrderDTO;

public class Adminmain implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {

		ArrayList<OrderDTO> allList = new OrderDAO().allList();
		int total = 0;
		for (OrderDTO price : allList) {
			if(price.getStatus().equals("주문완료") || price.getStatus().equals("배송완료") || price.getStatus().equals("배송중") || price.getStatus().equals("교환확인")) {
				total += price.getPrice()*price.getSelect_count();
			}
			
		}

		// 1.주문완료 리스트
		ArrayList<OrderDTO> orderList = new OrderDAO().Searchlist("주문완료");
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

		// 2.배송중 리스트
		ArrayList<OrderDTO> orderinglist = new OrderDAO().Searchlist("배송중");
		ArrayList<OrderDTO> mainorderinglist = new ArrayList<OrderDTO>();
		for (int i = 0; i < orderinglist.size(); i++) {
			boolean res = true;
			for (int j = 0; j < mainorderinglist.size(); j++) {
				if (mainorderinglist.get(j).getOrdered_num().equals(orderinglist.get(i).getOrdered_num())) {
					mainorderinglist.get(j)
							.setPrice(mainorderinglist.get(j).getPrice() + orderinglist.get(i).getPrice()*orderinglist.get(i).getSelect_count());
					mainorderinglist.get(j).setSelect_count(
							mainorderinglist.get(j).getSelect_count() + orderinglist.get(i).getSelect_count());
					res = false;
					break;
				}
			}
			if (res) {
				orderinglist.get(i).setPrice(orderinglist.get(i).getPrice()*orderinglist.get(i).getSelect_count());
				mainorderinglist.add(orderinglist.get(i));
			}
		}

		// 3.배송완료 리스트
		ArrayList<OrderDTO> orderEndlist = new OrderDAO().Searchlist("배송완료");
		ArrayList<OrderDTO> MainorderEndlist = new ArrayList<OrderDTO>();
		for (int i = 0; i < orderEndlist.size(); i++) {
			boolean res = true;
			for (int j = 0; j < MainorderEndlist.size(); j++) {
				if (MainorderEndlist.get(j).getOrdered_num().equals(orderEndlist.get(i).getOrdered_num())) {
					MainorderEndlist.get(j)
							.setPrice(MainorderEndlist.get(j).getPrice() + orderEndlist.get(i).getPrice()*orderEndlist.get(i).getSelect_count());
					MainorderEndlist.get(j).setSelect_count(
							MainorderEndlist.get(j).getSelect_count() + orderEndlist.get(i).getSelect_count());
					res = false;
					break;
				}
			}
			if (res) {
				orderEndlist.get(i).setPrice(orderEndlist.get(i).getPrice()*orderEndlist.get(i).getSelect_count());
				MainorderEndlist.add(orderEndlist.get(i));
			}
		}
		
		

		// 4.주문취소요청 리스트
		ArrayList<OrderDTO> RequestOrderCancelList = new OrderDAO().Searchlist("주문취소요청");
		ArrayList<OrderDTO> MainROCList = new ArrayList<OrderDTO>();
		for (int i = 0; i < RequestOrderCancelList.size(); i++) {
			boolean res = true;
			for (int j = 0; j < MainROCList.size(); j++) {
				if (MainROCList.get(j).getOrdered_num().equals(RequestOrderCancelList.get(i).getOrdered_num())) {
					MainROCList.get(j)
							.setPrice(MainROCList.get(j).getPrice() + RequestOrderCancelList.get(i).getPrice()*RequestOrderCancelList.get(i).getSelect_count());
					MainROCList.get(j).setSelect_count(
							MainROCList.get(j).getSelect_count() + RequestOrderCancelList.get(i).getSelect_count());
					res = false;
					break;
				} else {

				}
			}
			if (res) {
				RequestOrderCancelList.get(i).setPrice(RequestOrderCancelList.get(i).getPrice()*RequestOrderCancelList.get(i).getSelect_count());
				MainROCList.add(RequestOrderCancelList.get(i));
			}
		}

		// 5.반품요청 리스트
		ArrayList<OrderDTO> RequestChangeList = new OrderDAO().Searchlist("반품요청");
		ArrayList<OrderDTO> MainRCList = new ArrayList<OrderDTO>();
		for (int i = 0; i < RequestChangeList.size(); i++) {
			boolean res = true;
			for (int j = 0; j < MainRCList.size(); j++) {
				if (MainRCList.get(j).getOrdered_num().equals(RequestChangeList.get(i).getOrdered_num())) {
					MainRCList.get(j).setPrice(MainRCList.get(j).getPrice() + RequestChangeList.get(i).getPrice()*RequestChangeList.get(i).getSelect_count());
					MainRCList.get(j).setSelect_count(
							MainRCList.get(j).getSelect_count() + RequestChangeList.get(i).getSelect_count());
					res = false;
					break;
				}
			}
			if (res) {
				RequestChangeList.get(i).setPrice(RequestChangeList.get(i).getPrice()*RequestChangeList.get(i).getSelect_count());
				MainRCList.add(RequestChangeList.get(i));
			}
		}

		// 6.교환요청 리스트
		ArrayList<OrderDTO> RequestRefundList = new OrderDAO().Searchlist("교환요청");
		ArrayList<OrderDTO> MainRRList = new ArrayList<OrderDTO>();
		for (int i = 0; i < RequestRefundList.size(); i++) {
			boolean res = true;
			for (int j = 0; j < MainRRList.size(); j++) {
				if (MainRRList.get(j).getOrdered_num().equals(RequestRefundList.get(i).getOrdered_num())) {
					MainRRList.get(j).setPrice(MainRRList.get(j).getPrice() + RequestRefundList.get(i).getPrice()*RequestRefundList.get(i).getSelect_count());
					MainRRList.get(j).setSelect_count(
							MainRRList.get(j).getSelect_count() + RequestRefundList.get(i).getSelect_count());
					res = false;
					break;
				}
			}
			if (res) {
				RequestRefundList.get(i).setPrice(RequestRefundList.get(i).getPrice()*RequestRefundList.get(i).getSelect_count());
				MainRRList.add(RequestRefundList.get(i));
			}
		}

		// 7.취소 반품 교환 확인리스트
		ArrayList<OrderDTO> RequestCheckList = new OrderDAO().RequestCheckList("%확인%");
		ArrayList<OrderDTO> MainRequestCheckList = new ArrayList<OrderDTO>();
		for (int i = 0; i < RequestCheckList.size(); i++) {
			boolean res = true;
			for (int j = 0; j < MainRequestCheckList.size(); j++) {
				if (MainRequestCheckList.get(j).getOrdered_num().equals(RequestCheckList.get(i).getOrdered_num())) {
					MainRequestCheckList.get(j).setPrice(MainRequestCheckList.get(j).getPrice() + RequestCheckList.get(i).getPrice()*RequestCheckList.get(i).getSelect_count());
					MainRequestCheckList.get(j).setSelect_count(
							MainRequestCheckList.get(j).getSelect_count() + RequestCheckList.get(i).getSelect_count());
					res = false;
					break;
				}
			}
			if (res) {
				RequestCheckList.get(i).setPrice(RequestCheckList.get(i).getPrice()*RequestCheckList.get(i).getSelect_count());
				MainRequestCheckList.add(RequestCheckList.get(i));
			}
		}

		request.setAttribute("total", total);
		request.setAttribute("mainList", mainList);
		request.setAttribute("mainorderinglist", mainorderinglist);
		request.setAttribute("MainorderEndlist", MainorderEndlist);
		request.setAttribute("MainROCList", MainROCList);
		request.setAttribute("MainRCList", MainRCList);
		request.setAttribute("MainRRList", MainRRList);
		request.setAttribute("MainRequestCheckList", MainRequestCheckList);
		request.setAttribute("mainUrl", "./admins/admainpage");
	}
}