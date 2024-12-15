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

/**
 *
 * @author kivac
 */
public class FindUpdateUser extends HttpServlet {

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
            String userid = request.getParameter("upduserid");

            LoginService loginService = new LoginService(mgr);
            Loginuser user = new Loginuser(userid);
            HttpSession session = request.getSession();
            user.setUserid(userid);

            utx.begin();
            List<Loginuser> updList = loginService.findUserById(userid);
            utx.commit();

            //response.sendRedirect("userLogin.jsp");
            if (!updList.isEmpty()) {

                Loginuser checkUserId = updList.get(0);
                if (checkUserId.getUserid().equals(user.getUserid())) {

                    session.setAttribute("updList", updList);
                    response.sendRedirect("UpdateConfirmation.jsp");

                } else {
                    
                    RequestDispatcher rd = request.getRequestDispatcher("UpdateUserInfo.jsp");
                    rd.include(request, response);
                    out.print("<script>document.getElementById(\"unableFind\").classList.toggle(\"active\");</script>");
                    //response.sendRedirect("UpdateUserInfo.jsp");
                }

            } else {
                
                RequestDispatcher rd = request.getRequestDispatcher("UpdateUserInfo.jsp");
                rd.include(request, response);
                out.print("<script>document.getElementById(\"invalidUser\").classList.toggle(\"active\");</script>");
                //response.sendRedirect("UpdateUserInfo.jsp");
            }

        } catch (Exception ex) {
            
            RequestDispatcher rd = request.getRequestDispatcher("UpdateUserInfo.jsp");
            rd.include(request, response);
            out.print("<script>document.getElementById(\"invalidUser\").classList.toggle(\"active\");</script>");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try(PrintWriter out = response.getWriter()) {
            LoginService loginService = new LoginService(mgr);
            List<Loginuser> updList = loginService.findAll();
            //String userName = userList.getUsername(); 
            HttpSession session = request.getSession();
            session.setAttribute("updList", updList);
            response.sendRedirect("home.jsp");
            //request.getRequestDispatcher("home.jsp").forward(request, response);

        } catch (Exception ex) {
            
            RequestDispatcher rd = request.getRequestDispatcher("UpdateUserInfo.jsp");
            rd.include(request, response);
            out.print("<script>document.getElementById(\"invalidUser\").classList.toggle(\"active\");</script>");
        }
    }
}
