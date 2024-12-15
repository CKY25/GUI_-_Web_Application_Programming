/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.transaction.UserTransaction;
import model.Loginuser;
import model.LoginService;
import model.Orders;
import model.OrdersService;

public class DeleteUser extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @PersistenceContext
    EntityManager mgr;
    @Resource
    UserTransaction utx;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try(PrintWriter out = response.getWriter()) {
            LoginService loginService = new LoginService(mgr);
            
            String deleteUserId = request.getParameter("deleteuserid");
            String deleteUserName = request.getParameter("delUserName");
            String deleteEmail = request.getParameter("delEmail");
            String deletePassword = request.getParameter("delPw");
            String deleteUserStatus = request.getParameter("delStatus");
            
            //Loginuser user = new Loginuser(deleteUserId, deleteUserName, deleteEmail, deletePassword, deleteUserStatus);
            //System.out.printf(deleteUserId);
            //Loginuser user = loginService.findUserByCode(deleteUserId);
            String userId = deleteUserId;
            OrdersService os = new OrdersService(mgr);
            utx.begin();
            Loginuser user = loginService.findUserByCode(deleteUserId);
            List<Loginuser> deleList = loginService.findAll();
            List<Orders> orderList = mgr.createNamedQuery("Orders.findByUserId").setParameter("userid", deleteUserId).getResultList();
            
            for(Orders order : orderList){
                os.deleteOrder(order.getOrderId());
            }
            boolean success = loginService.delUser(user);
            utx.commit();
            
            HttpSession session = request.getSession();
            session.setAttribute("deleList", deleList);
            session.setAttribute("success", success);
            session.setAttribute("userId", userId);
            response.sendRedirect("DeleteConfirm.jsp");
        } catch (Exception ex) {
            PrintWriter out = response.getWriter();
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.include(request, response);
            out.print("<h3>Error! User Information failed to delete.</h3>");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try(PrintWriter out = response.getWriter()) {
            LoginService loginService = new LoginService(mgr);
            List<Loginuser> userList = loginService.findAll();
            //String userName = userList.getUsername(); 
            HttpSession session = request.getSession();
            session.setAttribute("userList", userList);
            response.sendRedirect("home.jsp");
            //request.getRequestDispatcher("home.jsp").forward(request, response);

        } catch (Exception ex) {
            
            RequestDispatcher rd = request.getRequestDispatcher("StaffHome.jsp");
            rd.include(request, response);
            out.print("<h3>Error! User Information failed to delete.</h3>");
        }
    }
}
