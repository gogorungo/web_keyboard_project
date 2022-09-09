package model.memberService;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Service;
import model.member.memberDAO;
import model.member.memberDTO;

public class MemberAuthenticationReg implements Service {
	
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String from = (String) session.getAttribute("fromURL");
		
        String email = request.getParameter("email");
        
        
        if(from.equals("signUp")) {
	        session.setAttribute("email", email);
			request.setAttribute("mainUrl", "./member_view/SignUpForm");
	        
	        
        }else if(from.equals("searchPW")){
        		session.setAttribute("email", email);
        		request.setAttribute("mainUrl", "./member_view/NewPW");
        }else if(from.equals("searchID")){
	        	
	    		String uID = "";
	    		
	    		ArrayList<memberDTO> memberList = new memberDAO().allList();
	    		
	    		for(memberDTO dto : memberList) {
	    			if(email.equals(dto.getEmail())) {
	    				uID = dto.getUser_id();
	    				break;
	    			}
	    		}
	    		request.setAttribute("userID", uID);
        		session.setAttribute("email", email);
        		request.setAttribute("mainUrl", "./member_view/SearchIDReg");
        		
        }
	}
}