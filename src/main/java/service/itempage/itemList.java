package service.itempage;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.item.itemDAO;
import model.item.itemDTO;

public class itemList implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		ArrayList<itemDTO> dto = null;
		String prices = request.getParameter("prices");
		dto = new itemDAO().list();
		if(prices != null) {
			switch (prices) {
			case "전체":
				break;
			case "1~5만원":
				for(int i=0; i<dto.size();i++) {
					if(dto.get(i).getPrice()>=10000 && dto.get(i).getPrice()<=50000 ) {
						
					} else {
						dto.get(i).setItem_name(null);
					}
				}
				break;
			case "5~10만원":
				for(int i=0; i<dto.size();i++) {
					if(dto.get(i).getPrice()>=50000 && dto.get(i).getPrice()<=100000 ) {
						
					} else {
						dto.get(i).setItem_name(null);
					}
				}
				break;
			case "10~20만원":
				for(int i=0; i<dto.size();i++) {
					if(dto.get(i).getPrice()>=100000 && dto.get(i).getPrice()<=200000 ) {
						
					} else {
						dto.get(i).setItem_name(null);
					}
				}
				break;
			case "20만원~":
				for(int i=0; i<dto.size();i++) {
					if(dto.get(i).getPrice()>=200000) {
						
					} else {
						dto.get(i).setItem_name(null);
					}
				}
				break;
			}
		} else {
			dto = new itemDAO().list();
		}
		
		// 1. 제조사 리스트 중복제거
		ArrayList<String> BeforeMF = new ArrayList<String>();
		for (itemDTO item : dto) {
			BeforeMF.add(item.getManufacture());
		}

		ArrayList<String> manufactor = new ArrayList<String>();
		for (String item : BeforeMF) {
			if (!manufactor.contains(item)) {
				manufactor.add(item);
			}
		}

		// 빈도수 체크
		HashMap<String, Integer> Count = new HashMap<String, Integer>();
		for (String item : manufactor) {
			Count.put(item, Collections.frequency(BeforeMF, item));
		}


		// 2. 카테고리 중복제거
		ArrayList<String> BeforeCG = new ArrayList<String>();
		for (itemDTO item : dto) {
			BeforeCG.add(item.getCategory());
		}
		ArrayList<String> category = new ArrayList<String>();
		for (String item : BeforeCG) {
			if (!category.contains(item))
				category.add(item);
		}

		// 빈도수 체크
		for (String item : category) {
			Count.put(item, Collections.frequency(BeforeCG, item));
		}


		// 3. 스위치 중복제거
		ArrayList<String> BeforeSW = new ArrayList<String>();
		for (itemDTO item : dto) {
			if (item.getSwitchs() != null && item.getSwitchs().length()>0) {
				BeforeSW.add(item.getSwitchs());
			}
		}

		ArrayList<String> sw = new ArrayList<String>();
		for (String item : BeforeSW) {
			if (!sw.contains(item))
				sw.add(item);
		}

		// 빈도수 체크
		for (String item : sw) {
			Count.put(item, Collections.frequency(BeforeSW, item));
		}


		ArrayList<String> priceLange = new ArrayList<String>();
		priceLange.add("전체");
		priceLange.add("1~5만원");
		priceLange.add("5~10만원");
		priceLange.add("10~20만원");
		priceLange.add("20만원~");
	

		request.setAttribute("manufactor", manufactor);
		request.setAttribute("category", category);
		request.setAttribute("sw", sw);
		request.setAttribute("priceLange", priceLange);
		request.setAttribute("dto", dto);
		request.setAttribute("Count", Count);
		request.setAttribute("mainUrl", "./items/itemListpage");
	}
}
