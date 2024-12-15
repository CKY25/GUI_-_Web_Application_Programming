/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.*;
import static java.lang.System.out;
import java.util.List;
import java.util.logging.*;
import javax.annotation.Resource;
import javax.persistence.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.transaction.UserTransaction;
import model.Loginuser;
import model.LoginService;

public class UpdateUserInfo extends HttpServlet {

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

            String updateUserId = request.getParameter("updateuserid");
            String updateUserName = request.getParameter("updUserName");
            String updateEmail = request.getParameter("updEmail");
            String updatePassword = request.getParameter("updPw");
            String updateUserStatus = request.getParameter("updStatus");

            //Loginuser user = new Loginuser(updateUserId,updateUserName, updateEmail, updatePassword, updateUserStatus);
            utx.begin();
            Loginuser user = loginService.findUserByCode(updateUserId);
            user.setUsername(updateUserName);
            user.setEmail(updateEmail);
            user.setPassword(updatePassword);
            boolean success = loginService.updateUser(user);
            //Loginuser update = loginService.findUserByCode(updateUserId);
            List<Loginuser> updList = loginService.findUserById(updateUserId);
            utx.commit();

            HttpSession session = request.getSession();
            session.setAttribute("updList", updList);
            session.setAttribute("success", success);
            response.sendRedirect("UpdateConfirm.jsp");
        } catch (Exception ex) {

            RequestDispatcher rd = request.getRequestDispatcher("UpdateUserInfo.jsp");
            rd.include(request, response);
            out.print("<h3>Error! Unable to obtain the data entered.</h3>");
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

            RequestDispatcher rd = request.getRequestDispatcher("UpdateUserInfo.jsp");
            rd.include(request, response);
            out.print("<h3>Error! Unable to obtain the data entered.</h3>");
        }
    }
}
