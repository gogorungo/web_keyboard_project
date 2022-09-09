package model.memberService;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;
import model.member.memberDAO;

public class MemberIdCheck implements Service {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		
		int res = new memberDAO().idchk(request.getParameter("id"));
		
		try {
			response.getWriter().append(res+"");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
