/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.UserTransaction;
import model.Orders;
import model.OrdersService;

/**
 *
 * @author User
 */
@WebServlet(name = "DeleteOrder", urlPatterns = {"/DeleteOrder"})
public class DeleteOrder extends HttpServlet {

    @PersistenceContext
    EntityManager em;
    @Resource
    UserTransaction utx;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        try {
            OrdersService ordersService = new OrdersService(em);
            HttpSession session = request.getSession();

            int orderId = Integer.parseInt(request.getParameter("orderId"));

            utx.begin();
            boolean success = ordersService.deleteOrder(orderId);
            utx.commit();
            List<Orders> orderList = ordersService.findAll();
            session.setAttribute("success", success);
            session.setAttribute("orderList", orderList);

            if (success == false) {
                RequestDispatcher rd = request.getRequestDispatcher("ordersAction.jsp");
                rd.include(request, response);
                out.println("<script>let myModal = new bootstrap.Modal(document.getElementById('UnsuccessDelOrder'), {});myModal.show();</script>");
            } else {
                RequestDispatcher rd = request.getRequestDispatcher("ordersAction.jsp");
                rd.include(request, response);
                out.println("<script>let myModal = new bootstrap.Modal(document.getElementById('SuccessDelOrder'), {});myModal.show();</script>");
            }
        } catch (Exception ex) {
            RequestDispatcher rd = request.getRequestDispatcher("ordersAction.jsp");
            rd.include(request, response);
            out.println("<script>let myModal = new bootstrap.Modal(document.getElementById('UnsuccessDelOrder'), {});myModal.show();</script>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            OrdersService ordersService = new OrdersService(em);
            List<Orders> orderList = ordersService.findAll();
            HttpSession session = request.getSession();
            session.setAttribute("orderList", orderList);
            response.sendRedirect("ordersAction.jsp");
        } catch (Exception ex) {
            Logger.getLogger(AddOrder.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
