/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.*;

/**
 *
 * @author user
 */
public class RemoveFromCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		try (PrintWriter out = response.getWriter()) {
			int id = Integer.parseInt(request.getParameter("id"));
			if (id != 0) {
				List<CartItem> cart_list = (List<CartItem>) request.getSession().getAttribute("cartItemList");
                                if (cart_list != null) {
                                    System.out.print("cart not null");
					for (CartItem c : cart_list) {
						if (c.getItemid() == id) {
							cart_list.remove(cart_list.indexOf(c));
							break;
						}
					}
				}
                                if(cart_list.isEmpty()){
                                    System.out.print("cart has nothing");
                                    cart_list = null;
                                    request.getSession().setAttribute("cartItemList", cart_list);
                                }
				response.sendRedirect("cart.jsp");

			} else {
				response.sendRedirect("cart.jsp");
			}

		} catch (Exception ex) {
            ex.printStackTrace();
            //response.sendRedirect("error.jsp");
        }
}

}
