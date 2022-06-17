package service.adminpage;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.member.memberDAO;
import model.member.memberDTO;

public class SearchMember implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String member_id = request.getParameter("member_id");
		String member_id2 = "%"+member_id+"%";
		ArrayList<memberDTO> memberList = new memberDAO().findList(member_id2);
		
		
		request.setAttribute("member_id", member_id);
		request.setAttribute("memberList", memberList);
		request.setAttribute("mainUrl", "./admins/membersearchpage");
		
	}
}
