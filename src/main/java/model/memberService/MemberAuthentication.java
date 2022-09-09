package model.memberService;

import java.util.ArrayList;
import java.util.Properties;
import java.util.Random;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import controller.Service;
import model.adminEmail.adminEmailDAO;
import model.adminEmail.adminEmailDTO;
import model.member.memberDAO;
import model.member.memberDTO;

public class MemberAuthentication implements Service {
	
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		HttpSession userFrom = request.getSession();
		String from = (String) userFrom.getAttribute("fromURL");

		
		adminEmailDTO adminDTO = new adminEmailDAO().adminData();
		
		String msg = "";
        String email = request.getParameter("email");
        int emailCheck = new memberDAO().emailchk(email);
        boolean flag = true;
        String userID = "";
        
        if(userFrom.getAttribute("userID") != null) {
        		userID = (String) userFrom.getAttribute("userID");
        }
        
        ArrayList<memberDTO> memberList = new memberDAO().allList();
        
        int chkIDPW = new memberDAO().checkIDEmail(userID, email);
        
        if(from.equals("signUp") && emailCheck>0) {
    			msg = "이미 존재하는 이메일 입니다";
    			request.setAttribute("msg", msg);
    			request.setAttribute("goUrl", "./Login");
    			request.setAttribute("mainUrl", "/member_view/alert");
        }else if(from.equals("searchID") && emailCheck==0) {
        		msg = "존재하지 않는 이메일 입니다";
			request.setAttribute("msg", msg);
			request.setAttribute("goUrl", "./Login");
			request.setAttribute("mainUrl", "/member_view/alert");
        }else if(from.equals("searchPW") && emailCheck==0) {
	    		msg = "존재하지 않는 이메일 입니다";
			request.setAttribute("msg", msg);
			request.setAttribute("goUrl", "./Login");
			request.setAttribute("mainUrl", "/member_view/alert");
	    }else if(from.equals("searchPW") && chkIDPW==0) {
	    		msg = "일치하는 회원이 없습니다";
			request.setAttribute("msg", msg);
			request.setAttribute("goUrl", "./Login");
			request.setAttribute("mainUrl", "/member_view/alert");
	    }else {
			
			for(memberDTO dto : memberList) {
				if(email.equals(dto.getEmail())) {
					flag = false;
					break;
				}
			}
        
	        //mail server 설정
	        String host = "smtp.naver.com";
	        String user = adminDTO.getEmailAddress(); //자신의 네이버 계정
	        String password = adminDTO.getEmailPassword();//자신의 네이버 패스워드
	        
	        //메일 받을 주소
	        String to_email = email;
	        System.out.println(email);
	        
	        //SMTP 서버 정보를 설정한다.
	        Properties props = new Properties();
	        props.put("mail.smtp.host", host);
	        props.put("mail.smtp.port", 465);
	        props.put("mail.smtp.auth", "true");
	        props.put("mail.smtp.ssl.enable", "true");
	        props.put("mail.smtp.ssl.trust", "smtp.naver.com");
	        props.put("mail.smtp.ssl.protocols", "TLSv1.2");
	 
	        
	        //인증 번호 생성기
	        StringBuffer temp =new StringBuffer();
	        Random rnd = new Random();
	        for(int i=0;i<10;i++)
	        {
	            int rIndex = rnd.nextInt(3);
	            switch (rIndex) {
	            case 0:
	                // A-Z
	                temp.append((char) ((int) (rnd.nextInt(26)) + 65));
	                break;
	            case 1:
	                // 0-9
	                temp.append((rnd.nextInt(10)));
	                break;
	            case 2:
	                // A-Z
	                temp.append((char) ((int) (rnd.nextInt(26)) + 65));
	                break;
	            }
	        }
	        String AuthenticationKey = temp.toString();
	        System.out.println(AuthenticationKey);
	        
	        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
	            protected PasswordAuthentication getPasswordAuthentication() {
	                return new PasswordAuthentication(user,password);
	            }
	        });
	        
	        //email 전송
	        try {
	            MimeMessage message = new MimeMessage(session);
	            message.setFrom(new InternetAddress(user, "key_board shop"));
	            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to_email));
	            
	            //메일 제목
	            message.setSubject("안녕하세요 키보드 쇼핑몰 인증 메일입니다.");
	            //메일 내용
	            message.setText("인증 번호는 : "+temp);
	            
	            Transport.send(message);
	            
	        }catch (Exception e) {
	            e.printStackTrace();// TODO: handle exception
	        }
	        
	        request.setAttribute("AuthenticationKey", AuthenticationKey);
	        request.setAttribute("email", email);
	        request.setAttribute("mainUrl", "./member_view/AuthenticationReg");

		}
	}
}
