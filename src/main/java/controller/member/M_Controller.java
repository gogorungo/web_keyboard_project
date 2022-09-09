package controller.member;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;

/**
 * Servlet implementation class M_Controller
 */

@WebServlet("/member/*")
public class M_Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */

	ArrayList<String> nonClass;
	
	ArrayList<String> nonTemplate;

	public M_Controller() {
		super();
		nonClass = new ArrayList<String>();
		
		nonTemplate = new ArrayList<String>();
		nonTemplate.add("IdCheck");
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
//		System.out.println(request.getRequestURI());
//		System.out.println(request.getContextPath());

		String serviceStr = request.getRequestURI().substring((request.getContextPath() + "/member/").length());


//		System.out.println(serviceStr);
		
		if (nonClass.contains(serviceStr)) {
			request.setAttribute("mainUrl", serviceStr);
		} else {
			try {
				Service service = (Service) Class.forName("model.memberService.Member" + serviceStr).newInstance();
				service.execute(request, response);

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

		if(!nonTemplate.contains(serviceStr)) {
		// 포워딩의 액션태그 기능을 쓰기위한 사전작업 앞에 / 안붙이면 무한루프돌음
			RequestDispatcher dispatcher = request.getRequestDispatcher("/template.jsp");
			dispatcher.forward(request, response);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request,response);
	}

}
