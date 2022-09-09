package controller.cart;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import controller.Service;

@WebServlet("/cart/*")
public class cartController extends HttpServlet {

	ArrayList<String> nonClass;

	public cartController() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String serviceStr = request.getRequestURI().substring((request.getContextPath()+ "/cart/").length());

		try {
			Service service = (Service) Class.forName("service.cartpage."+serviceStr).newInstance();
			service.execute(request, response);
			
//			if(serviceStr.equals("Cartview")) {
//				RequestDispatcher dispatcher = request.getRequestDispatcher("/carts/cartpage.jsp");
//				dispatcher.forward(request, response);
//			}else if(serviceStr.equals("DeleteCart")) {
//				RequestDispatcher dispatcher = request.getRequestDispatcher("/carts/deletecartpage.jsp");
//				dispatcher.forward(request, response);
//			}else if(serviceStr.equals("RemoveItem")) {
//				RequestDispatcher dispatcher = request.getRequestDispatcher("/carts/removeItempage.jsp");
//				dispatcher.forward(request, response);
//			}else if(serviceStr.equals("OrderCart")) {
//				RequestDispatcher dispatcher = request.getRequestDispatcher("/carts/orderpage.jsp");
//				dispatcher.forward(request, response);
//			}else if(serviceStr.equals("OrderEnd")) {
//				RequestDispatcher dispatcher = request.getRequestDispatcher("/carts/orderendpage.jsp");
//				dispatcher.forward(request, response);
//			}
			
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
