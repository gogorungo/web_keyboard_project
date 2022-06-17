package service.adminpage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.main.MainDAO;

public class RemoveMainItem implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int itemNo = Integer.parseInt(request.getParameter("itemNo"));
		String status = request.getParameter("status");
		String msg = null;
		String goUrl = "MainControl";
		if(new MainDAO().removeitem(itemNo, status)) {
			msg = "상품이 내려갔습니다.";
		} else {
			msg = "처리 실패";
		}
		
		
		request.setAttribute("msg", msg);
		request.setAttribute("goUrl", goUrl);
		request.setAttribute("mainUrl", "./admins/adminAlert");
	}
}
