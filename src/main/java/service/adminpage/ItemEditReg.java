package service.adminpage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.item.itemDAO;
import model.item.itemDTO;

public class ItemEditReg implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
		String msg = null;
		String goUrl = "ItemControl";
		
		itemDTO dto = new itemDTO();
		dto.setItemNo(Integer.parseInt(request.getParameter("itemNo")));
		dto.setItem_name(request.getParameter("item_name"));
		dto.setManufacture(request.getParameter("manufacture"));
		dto.setCategory(request.getParameter("category"));
		dto.setSwitchs(request.getParameter("switchs"));
		dto.setSpec(request.getParameter("spec"));
		dto.setPrice(Integer.parseInt(request.getParameter("price")));
		dto.setItem_img1(request.getParameter("item_img1"));
		dto.setItem_img2(request.getParameter("item_img2"));
		
		int res = new itemDAO().modify(dto);
	
		if(res>0) {
			msg="수정성공";
		} else {
			msg = "수정실패";
			goUrl = "ItemEdit?itemNo="+dto.getItemNo();
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("goUrl", goUrl);
		request.setAttribute("mainUrl", "./admins/adminAlert");
	}
}
