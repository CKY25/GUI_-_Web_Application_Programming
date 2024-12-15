/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.CartItem;

/**
 *
 * @author user
 */
public class QuantityIncDecServlet extends HttpServlet {
        private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
			String action = request.getParameter("action");
			int id = Integer.parseInt(request.getParameter("id"));
			List<CartItem> cart_list = (List<CartItem>) request.getSession().getAttribute("cartItemList");
                               
			if (action != null && id >= 1) {
				if (action.equals("inc")) {
					for (CartItem c : cart_list) {
						if (c.getItemid() == id) {
							int quantity = c.getItemqty();
							quantity++;
							c.setItemqty(quantity);
							response.sendRedirect("cart.jsp");
						}
					}
				}

				if (action.equals("dec")) {
					for (CartItem c : cart_list) {
						if (c.getItemid() == id && c.getItemqty() > 1) {
							int quantity = c.getItemqty();
							quantity--;
							c.setItemqty(quantity);
							break;
						}
					}
					response.sendRedirect("cart.jsp");
				}
			} else {
				response.sendRedirect("cart.jsp");
			}
		}
	}

}
