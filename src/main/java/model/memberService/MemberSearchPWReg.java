package model.memberService;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Service;
import model.member.memberDAO;
import model.member.memberDTO;

public class MemberSearchPWReg implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		
		
		String userId = request.getParameter("user_id");
		String uID = "";
		boolean flag = true;
		String msg = "";
		
		ArrayList<memberDTO> memberList = new memberDAO().allList();
		
		for(memberDTO dto : memberList) {
			if(userId.equals(dto.getUser_id())) {
				uID = dto.getUser_id();
				session.setAttribute("userID", uID);
				flag = false;
				break;
			}
		}
		
		if(flag) {
			msg = "계정이 존재하지 않습니다";
			request.setAttribute("msg", msg);
			request.setAttribute("goUrl", "./Login");
			request.setAttribute("mainUrl", "/member_view/alert");
		}else {
			request.setAttribute("mainUrl", "./member_view/SearchPWNext");
		}
	}
}
