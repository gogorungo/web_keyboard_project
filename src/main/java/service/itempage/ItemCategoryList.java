package service.itempage;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.item.itemDAO;
import model.item.itemDTO;
import model.member.memberDAO;
import model.member.memberDTO;

public class ItemCategoryList implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String category = request.getParameter("category");
		ArrayList<itemDTO> categoryList = new itemDAO().findcategoryList(category);
		
		
		request.setAttribute("category", category);
		request.setAttribute("categoryList", categoryList);
		request.setAttribute("mainUrl", "./items/itemcategoryListpage");
	}
}
