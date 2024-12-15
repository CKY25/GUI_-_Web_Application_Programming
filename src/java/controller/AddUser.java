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

public class AddUser extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            //obtain input from users/view
            String userName = request.getParameter("suname");
            String email = request.getParameter("semail");
            String password = request.getParameter("supassword");

            //interact with model/entity class
            LoginService loginService = new LoginService(mgr);
            Loginuser user = new Loginuser(userName, email, password);
            HttpSession session = request.getSession();
            utx.begin();
            List<Loginuser> emailList = loginService.findUserByEmail(email);
            utx.commit();
            if (!emailList.isEmpty()) {
                Loginuser checkEmail = emailList.get(0);
                if (!(checkEmail.getEmail().equals(user.getEmail()))) {
                    String lastUserID = loginService.findLastUserId();
                    String newID = user.generateID(lastUserID);
                    user.setUserid(newID);
                    user.setUserstatus("customer");

                    //List<Loginuser> userList = loginService.findAll();
                    //session.setAttribute("userList", userList);
                    session.setAttribute("user", user);
                    utx.begin();
                    boolean success = loginService.addUser(user);
                    utx.commit();
                    session.setAttribute("success", success);

                    response.sendRedirect("userLogin.jsp");

                } else {

                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                    rd.include(request, response);
                    out.print("<script>document.getElementById(\"duplicateEmail\").classList.toggle(\"active\");</script>");
                }
            } else {

                String lastUserID = loginService.findLastUserId();
                String newID = user.generateID(lastUserID);
                user.setUserid(newID);
                user.setUserstatus("customer");

                //List<Loginuser> userList = loginService.findAll();
                //session.setAttribute("userList", userList);
                session.setAttribute("user", user);
                utx.begin();
                boolean success = loginService.addUser(user);
                utx.commit();
                session.setAttribute("success", success);

                response.sendRedirect("userLogin.jsp");

            }

        } catch (Exception ex) {

            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.include(request, response);
            out.print("<script>document.getElementById(\"err\").classList.toggle(\"active\");</script>");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            LoginService loginService = new LoginService(mgr);
            List<Loginuser> userList = loginService.findAll();
            HttpSession session = request.getSession();
            session.setAttribute("userList", userList);
            response.sendRedirect("userLogin.jsp");

        } catch (Exception ex) {

            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.include(request, response);
            out.print("<script>document.getElementById(\"err\").classList.toggle(\"active\");</script>");
        }
    }
}
