package service.adminpage;

import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.member.memberDAO;
import model.member.memberDTO;
import model.order.OrderDAO;
import model.order.OrderDTO;
import test.XssUtil;

public class OrderSearch implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		String order_num = request.getParameter("order_num");
		String user_id = request.getParameter("user_id");
		String name = request.getParameter("name");
		String status = request.getParameter("status");
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		//널값체크
		if(order_num == null) {
			order_num = "%";
		} else {
			order_num ="%"+order_num+"%";
		}
		if(user_id == null) {
			user_id = "%";
		} else {
			user_id ="%"+user_id+"%";
		}
		if(name == null) {
			name = "%";
		} else {
			name ="%"+name+"%";
		}
		if(status == null) {
			status = "%";
		} else {
			status ="%"+status+"%";
		}
		if(startdate == null) {
			Calendar cal = java.util.Calendar.getInstance();
	        cal.add(cal.DATE, -7);// 일주일 빼기
	        Date date = cal.getTime();
			startdate = dateFormat.format(date);
		}
		if(enddate == null) {
			Date date = new Date();
			enddate = dateFormat.format(date);
		}
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date formatStartdate = null;
		Date formatEnddate = null;
		try {
			formatStartdate = dateFormat.parse(startdate);
			formatEnddate = dateFormat.parse(enddate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		ArrayList<memberDTO> memberList = new memberDAO().findList(user_id);
		ArrayList<OrderDTO> orderList = new ArrayList<OrderDTO>();
		for(memberDTO m_dto:memberList) {
			ArrayList<OrderDTO> addList = new OrderDAO().findList(order_num, name, status, m_dto.getMemberNo());
			for(OrderDTO o_dto:addList) {
				if(o_dto.getOrdered_date().after(formatStartdate) && o_dto.getOrdered_date().before(formatEnddate)) {
					orderList.add(o_dto);
				}
			}
		}
		
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
		
		
		//수입계산
		ArrayList<String> columns = new ArrayList<String>();
		HashMap<String, Integer> Counts = new HashMap<String, Integer>();
		HashMap<String, Integer> totals = new HashMap<String, Integer>();
		for(int i=0; i<mainList.size(); i++) {
			boolean res = true;
			for(int j=0; j<columns.size(); j++) {
				if(columns.get(j).equals(mainList.get(i).getStatus())){
					res = false;
				}
			}
			if (res) {
				columns.add(mainList.get(i).getStatus());
				Counts.put(mainList.get(i).getStatus(), 0);
				totals.put(mainList.get(i).getStatus(), 0);
			}
		}
		
		for(int i=0; i<mainList.size(); i++) {
			if(Counts.containsKey(mainList.get(i).getStatus())) {
				int num = Counts.get(mainList.get(i).getStatus())+1;
				Counts.put(mainList.get(i).getStatus(), num);
			}
			if(totals.containsKey(mainList.get(i).getStatus())) {
				int num2 = totals.get(mainList.get(i).getStatus())+mainList.get(i).getPrice();
				totals.put(mainList.get(i).getStatus(), num2);
			}
		}
		
		int total = 0;
		for (OrderDTO price : mainList) {
			if(price.getStatus().equals("주문완료") || price.getStatus().equals("배송완료") || price.getStatus().equals("배송중") || price.getStatus().equals("교환확인")) {
				total += price.getPrice();
			}
			
		}
		
		order_num = order_num.replace("%", "");
		user_id = user_id.replace("%", "");
		name = name.replace("%", "");
		status = status.replace("%", "");
		order_num = XssUtil.cleanXSS(order_num);
		user_id = XssUtil.cleanXSS(user_id);
		name = XssUtil.cleanXSS(name);
		status = XssUtil.cleanXSS(status);
		
		request.setAttribute("order_num", order_num);
		request.setAttribute("user_id", user_id);
		request.setAttribute("name", name);
		request.setAttribute("status", status);
		request.setAttribute("startdate", startdate);
		request.setAttribute("enddate", enddate);
		request.setAttribute("orderList", mainList);
		request.setAttribute("Counts", Counts);
		request.setAttribute("totals", totals);
		request.setAttribute("total", total);
		request.setAttribute("mainUrl", "./admins/ordersearchpage");
	}
}
