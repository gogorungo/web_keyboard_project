package controller.qna;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;

@WebServlet("/qna/*")
public class QnaController extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	Object data = null;

	ArrayList<String> nonClass;

	public QnaController() {
		super();
		nonClass = new ArrayList<String>();
		nonClass.add("qnaInsertpage");
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String serviceStr = request.getRequestURI().substring((request.getContextPath() + "/qna/").length());
		System.out.println(serviceStr);

		int page = 1;
		if (request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}

		request.setAttribute("nowPage", page);

		if (nonClass.contains(serviceStr)) {
			request.setAttribute("mainUrl", "./qnas/" + serviceStr);
		} else {
			try {
				Service service = (Service) Class.forName("service.qnaPage." + serviceStr).newInstance();
				service.execute(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		RequestDispatcher dispatcher = request.getRequestDispatcher("/template.jsp");
		dispatcher.forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doGet(req, resp);
	}

}