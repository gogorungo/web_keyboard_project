package model.memberService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Service;
import model.member.memberDAO;
import model.member.memberDTO;

public class MemberGoGoDetail implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();

		memberDTO user = (memberDTO) session.getAttribute("inUser");
		
		memberDAO dao = new memberDAO();
		
		int id = user.getMemberNo();
		
		// close 하면 detail 에서 접속이안된다.
		
		memberDTO data = dao.detail(id);
		
		
		String tel = data.getTel();
		
		String tel1 = tel.substring(0,3);
		String tel2 = tel.substring(3,7);
		String tel3 = tel.substring(7);
		
		data.setTel1(tel1);
		data.setTel2(tel2);
		data.setTel3(tel3);
		
		
		request.setAttribute("dto", data);
		request.setAttribute("mainUrl", "member_view/DetailForm");
	}

}