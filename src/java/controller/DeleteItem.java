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
import javax.persistence.Query;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.UserTransaction;
import model.Item;
import model.ItemService;

/**
 *
 * @author User
 */
public class DeleteItem extends HttpServlet {

    @PersistenceContext
    EntityManager em;
    @Resource
    UserTransaction utx;
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try(PrintWriter out = response.getWriter()) {
            ItemService itemService = new ItemService(em);
            HttpSession session = request.getSession();
            int itemid = Integer.parseInt(request.getParameter("itemid"));
            utx.begin();
            boolean success = itemService.deleteItem(itemid);
            utx.commit();
            List<Item> itemList = itemService.findAll();
            session.setAttribute("itemList", itemList);
            RequestDispatcher rd = request.getRequestDispatcher("manageItem.jsp");
            rd.include(request, response);
            out.println("<script type='text/javascript'>document.getElementById(\"blur\").classList.toggle('active')</script>");
            out.println("<script type='text/javascript'>document.getElementById(\"popupSuccessDelete\").classList.toggle('active')</script>");
            
        } catch (Exception ex) {
            Logger.getLogger(DeleteItem.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ItemService itemService = new ItemService(em);
            List<Item> itemList = itemService.findAll();
            HttpSession session = request.getSession();
            session.setAttribute("itemList", itemList);
            response.sendRedirect("manageItem.jsp");
        } catch (Exception ex) {
            Logger.getLogger(DeleteItem.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
