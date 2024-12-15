/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.*;
import static java.lang.System.out;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.*;
import javax.annotation.Resource;
import javax.persistence.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.transaction.UserTransaction;
import model.Item;
import model.Orders;
import model.OrdersService;

/**
 *
 * @author User
 */
@WebServlet(name = "AddOrder", urlPatterns = {"/AddOrder"})
public class AddOrder extends HttpServlet {

    @PersistenceContext
    EntityManager em;
    @Resource
    UserTransaction utx;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        try {
            String customerName = request.getParameter("customerName");
            String iName = request.getParameter("iName");
            TypedQuery<Item> itemQuery = em.createNamedQuery("Item.findByItemname", Item.class).setParameter("itemname", iName);
            Item item = itemQuery.getSingleResult();

            int qty = Integer.parseInt(request.getParameter("qty"));
            String methodName = request.getParameter("methodName");

            Double totalPrice = item.getItemprice() * qty;
            Date date = new Date();
            DateFormat dateFormat = new SimpleDateFormat("dd-M-yyyy");
            String formattedDate = dateFormat.format(date);
            Date orderDate = dateFormat.parse(formattedDate);

            String status = request.getParameter("orderStatus");

            OrdersService ordersService = new OrdersService(em);
            utx.begin();
            boolean success = ordersService.addOrder(customerName, iName, qty, methodName, totalPrice, orderDate, status);
            utx.commit();

            List<Orders> orderList = ordersService.findAll();
            session.setAttribute("success", success);
            session.setAttribute("orderList", orderList);

            RequestDispatcher rd = request.getRequestDispatcher("ordersAction.jsp");
            rd.include(request, response);
            out.println("<script>let myModal = new bootstrap.Modal(document.getElementById('SuccessInsOrder'), {});myModal.show();</script>");

        } catch (Exception ex) {
            RequestDispatcher rd = request.getRequestDispatcher("ordersAction.jsp");
            rd.include(request, response);
            out.println("<script>let myModal = new bootstrap.Modal(document.getElementById('UnsuccessInsOrder'), {});myModal.show();</script>");

        }
    }

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
