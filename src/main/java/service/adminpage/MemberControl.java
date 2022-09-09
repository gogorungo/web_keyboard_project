package service.adminpage;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.member.memberDAO;
import model.member.memberDTO;


public class MemberControl implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		ArrayList<memberDTO> memberList = new memberDAO().allList();
		
		request.setAttribute("memberList", memberList);
		request.setAttribute("mainUrl", "./admins/membercontrolpage");
		
	}
}
