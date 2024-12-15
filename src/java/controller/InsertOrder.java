/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.UserTransaction;
import model.CartItem;
import model.Item;
import model.ItemService;
import model.Orders;
import model.OrdersService;

/**
 *
 * @author User
 */
@WebServlet(name = "InsertOrder", urlPatterns = {"/InsertOrder"})
public class InsertOrder extends HttpServlet {

    @PersistenceContext
    EntityManager em;
    @Resource
    UserTransaction utx;

    //add the name attribute to the <input> such as name="firstName" for the First Name input in the checkout jsp
    //add the post method and action link to the form in the checkout jsp 
    //add the value of the payment method into the <input> in the checkout jsp 
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        try {
            String customerName = request.getParameter("username");
            String paymentMethod = request.getParameter("paymentMethod");
            
            if(paymentMethod.equals("Online Banking")){
                paymentMethod = request.getParameter("bank");
            }
            
            OrdersService ordersService = new OrdersService(em);
            ItemService itemService = new ItemService(em);
            boolean success = false;

            List<CartItem> cartItemList = (List<CartItem>) session.getAttribute("cartItemList");

            for (CartItem cartItem : cartItemList) {
                int itemId = cartItem.getItemid();
                TypedQuery<Item> itemQuery = em.createNamedQuery("Item.findByItemid", Item.class).setParameter("itemid", itemId);
                Item item = itemQuery.getSingleResult();
                
                String itemName = item.getItemname();
                int itemQuantity = cartItem.getItemqty();
                double itemPrice = item.getItemprice();
                double totalPrice = itemPrice * itemQuantity;
                int qtySold = item.getItemsoldqty();
                int qtyStock = item.getItemstock();
                item.setItemsoldqty(qtySold + itemQuantity);
                item.setItemstock(qtyStock - itemQuantity);
  
                Date date = new Date();
                DateFormat dateFormat = new SimpleDateFormat("dd-M-yyyy");
                String formattedDate = dateFormat.format(date);
                Date orderDate = dateFormat.parse(formattedDate);
                
                utx.begin();
//                System.out.println(paymentMethod);
                success = ordersService.addOrder(customerName, itemName, itemQuantity, paymentMethod, totalPrice, orderDate, "Packaging");
                itemService.updateItem(item);
                utx.commit();

                session.setAttribute("cartItemList", null);
            }

            List<Orders> orderList = ordersService.findAll();
            session.setAttribute("success", success);
            session.setAttribute("orderList", orderList);

            RequestDispatcher rd = request.getRequestDispatcher("ordersAction.jsp");
            rd.include(request, response);
            out.println("<script>let myModal = new bootstrap.Modal(document.getElementById('SuccessInsOrder'), {});myModal.show();</script>"); // this change to the qy's success order message

        } catch (Exception ex) {

            RequestDispatcher rd = request.getRequestDispatcher("ordersAction.jsp");
            rd.include(request, response);
            out.println("<script>let myModal = new bootstrap.Modal(document.getElementById('UnsuccessInsOrder'), {});myModal.show();</script>");// this change to the qy's unsuccess order message

        }
    }

}
