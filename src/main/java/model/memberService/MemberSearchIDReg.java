package model.memberService;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.member.memberDAO;
import model.member.memberDTO;

public class MemberSearchIDReg implements Service{

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String uEmail = request.getParameter("email");
		String uName = request.getParameter("name");
		
		String uID = "";
		boolean flag = true;
		
		
		ArrayList<memberDTO> memberList = new memberDAO().allList();
		
		for(memberDTO dto : memberList) {
			if(uEmail.equals(dto.getEmail()) && uName.equals(dto.getName())) {
				uID = dto.getUser_id();
				flag = false;
				break;
			}
		}
		request.setAttribute("userID", uID);
		request.setAttribute("email", uEmail);
		
		if(flag) {
			request.setAttribute("msg", "일치하는 회원이 없습니다");
			request.setAttribute("goUrl", "./Login");
			request.setAttribute("mainUrl", "./member_view/alert");
		}else {

			request.setAttribute("mainUrl", "./member_view/GoAuthentication");
		}
		
	}

}
