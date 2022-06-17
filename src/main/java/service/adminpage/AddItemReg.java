package service.adminpage;


import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import controller.Service;
import model.item.itemDAO;
import model.item.itemDTO;

public class AddItemReg implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		try {
			request.setCharacterEncoding("UTF-8");
		} catch (Exception e) {
			e.printStackTrace();
		}
		String msg = null;
		String goUrl = "ItemControl";
		//상대 경로저장	
        String path = request.getSession().getServletContext().getRealPath("/source");
        System.out.println("현재 작업 경로: " + path);
		try {
			MultipartRequest mm = new MultipartRequest(
					request, path, 
					50*1024*1024,
					"UTF-8", 
					new DefaultFileRenamePolicy());
			
			itemDTO dto = new itemDTO();
			dto.setItem_name(mm.getParameter("item_name"));
			dto.setManufacture(mm.getParameter("manufacture"));
			dto.setCategory(mm.getParameter("category"));
			dto.setSpec(mm.getParameter("spec"));
			dto.setPrice(Integer.parseInt(mm.getParameter("price").trim()));
			dto.setStock(Integer.parseInt(mm.getParameter("stock").trim()));
			dto.setItem_img1(mm.getFilesystemName("item_img1"));
			dto.setItem_img2(mm.getFilesystemName("item_img2"));
			
			if(mm.getParameter("switchs") == null) {
				new itemDAO().insertNotSwitchs(dto);
			}else {
				dto.setSwitchs(mm.getParameter("switchs"));
				new itemDAO().insert(dto);
			}
			
			msg="아이템 추가 성공";
		} catch (IOException e) {
			msg = "아이템 추가 실패";
			e.printStackTrace();
		}
		
		request.setAttribute("msg", msg);
		request.setAttribute("goUrl", goUrl);
		request.setAttribute("mainUrl", "./admins/adminAlert");
		
	}

}
