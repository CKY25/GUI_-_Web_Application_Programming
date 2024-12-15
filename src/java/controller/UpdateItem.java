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
import javax.servlet.annotation.WebServlet;
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
@WebServlet(name = "UpdateItem", urlPatterns = {"/UpdateItem"})
public class UpdateItem extends HttpServlet {

    @PersistenceContext
    EntityManager em;
    @Resource
    UserTransaction utx;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            //obtain input from users/view
            int itemid = Integer.parseInt(request.getParameter("itemid"));
            String itemname = request.getParameter("itemname");
            double itemprice = Double.parseDouble(request.getParameter("itemprice"));
            int itemstock = Integer.parseInt(request.getParameter("itemstock"));
            String itemreview = request.getParameter("itemreview");
            int itemsoldqty = Integer.parseInt(request.getParameter("itemsoldqty"));
            String itemimage = request.getParameter("itemimage");
            String itemdesc = request.getParameter("itemdesc");
            
            //interact with model/entity class            
            ItemService itemService = new ItemService(em);
            Item item = itemService.findItemByCode(itemid);
            item.setItemname(itemname);
            item.setItemprice(itemprice);
            item.setItemstock(itemstock);
            item.setItemreview(itemreview);
            item.setItemsoldqty(itemsoldqty);
            item.setItemimage(itemimage);
            item.setItemdesc(itemdesc);
            utx.begin();
            itemService.updateItem(item);
            utx.commit();
            HttpSession session = request.getSession();
            List<Item> itemList = itemService.findAll();
            session.setAttribute("itemList", itemList);
            RequestDispatcher rd = request.getRequestDispatcher("manageItem.jsp");
            rd.include(request, response);
            out.println("<script type='text/javascript'>document.getElementById(\"blur\").classList.toggle('active')</script>");
            out.println("<script type='text/javascript'>document.getElementById(\"popupSuccessUpdate\").classList.toggle('active')</script>");
        } catch (Exception ex) {
            int itemid = Integer.parseInt(request.getParameter("itemid"));
            RequestDispatcher rd = request.getRequestDispatcher("manageItem.jsp");
            rd.include(request, response);
            out.println("<script type='text/javascript'>togglePopupUpdate(" + itemid + ")</script>");
            out.println("<script type='text/javascript'>document.getElementById(\"errFieldsUpdate\").classList.add('active')</script>");
        } 
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
