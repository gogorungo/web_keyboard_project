package service.itempage;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.item.itemDAO;
import model.item.itemDTO;

public class itemdetail implements Service{
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		
		itemDAO dao = new itemDAO();
		itemDTO dto = dao.Detail(Integer.parseInt(request.getParameter("id")));
		
		request.setAttribute("dto", dto);
		request.setAttribute("mainUrl", "./items/detailpage");
		
	}
}
