package controller.itempage;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;

@WebServlet("/item/*")
public class ItemController extends HttpServlet {

	ArrayList<String> nonClass;

	public ItemController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String serviceStr = request.getRequestURI().substring((request.getContextPath() + "/item/").length());
		try {
			Service service = (Service) Class.forName("service.itempage."+serviceStr).newInstance();
			service.execute(request, response);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/template.jsp");
			dispatcher.forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
