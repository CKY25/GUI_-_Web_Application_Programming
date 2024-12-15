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
import model.Item;
import model.ItemService;
import model.Staff;

/**
 *
 * @author User
 */
@WebServlet(name = "AddItem", urlPatterns = {"/AddItem"})
public class AddItem extends HttpServlet {

    @PersistenceContext
    EntityManager em;
    @Resource
    UserTransaction utx;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            //obtain input from users/view
            int itemid = Integer.parseInt(request.getParameter("itemid"));
            String itemname = request.getParameter("itemname");
            double itemprice = Double.parseDouble(request.getParameter("itemprice"));
            int itemstock = Integer.parseInt(request.getParameter("itemstock"));
            int itemsoldqty = Integer.parseInt(request.getParameter("itemsoldqty"));
            String itemimage = request.getParameter("itemimage");
            String itemdesc = request.getParameter("itemdesc");

            ItemService itemService = new ItemService(em);
            if (itemService.checkExist(itemid)) {
                RequestDispatcher rd = request.getRequestDispatcher("manageItem.jsp");
                rd.include(request, response);
                out.println("<script type='text/javascript'>document.getElementById(\"blur\").classList.toggle('active')</script>");
                out.println("<script type='text/javascript'>document.getElementById(\"popupAdd\").classList.toggle('active')</script>");
                out.println("<script type='text/javascript'>document.getElementById(\"errId\").classList.add('active')</script>");
            } else {
                //interact with model/entity class
                Item item = new Item(itemid, itemname, itemprice, itemstock, itemsoldqty, itemimage, itemdesc);
                utx.begin();
                itemService.addItem(item);
                utx.commit();
                List<Item> itemList = itemService.findAll();
                HttpSession session = request.getSession();
                session.setAttribute("itemList", itemList);
                RequestDispatcher rd = request.getRequestDispatcher("manageItem.jsp");
                rd.include(request, response);
                out.println("<script type='text/javascript'>document.getElementById(\"blur\").classList.toggle('active')</script>");
                out.println("<script type='text/javascript'>document.getElementById(\"popupSuccessAdd\").classList.toggle('active')</script>");
            }
        } catch (Exception ex) {
            RequestDispatcher rd = request.getRequestDispatcher("manageItem.jsp");
            rd.include(request, response);
            out.println("<script type='text/javascript'>document.getElementById(\"blur\").classList.toggle('active')</script>");
            out.println("<script type='text/javascript'>document.getElementById(\"popupAdd\").classList.toggle('active')</script>");
            out.println("<script type='text/javascript'>document.getElementById(\"errFieldsAdd\").classList.add('active')</script>");
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            ItemService itemService = new ItemService(em);
            List<Item> itemList = itemService.findAll();
            HttpSession session = request.getSession();
            List<Staff> s = (List)session.getAttribute("staffList");
            session.setAttribute("itemList", itemList);
            session.setAttribute("isManager", s.get(0).getStaffstatus());
            System.out.println(s.get(0));
            response.sendRedirect("manageItem.jsp");

        } catch (Exception ex) {
            Logger.getLogger(AddItem.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
