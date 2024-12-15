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

public class Login extends HttpServlet {

    @PersistenceContext
    EntityManager mgr;
    @Resource
    UserTransaction utx;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try(PrintWriter out = response.getWriter()) {

            String email = request.getParameter("lemail");
            String password = request.getParameter("lpassword");

            LoginService loginService = new LoginService(mgr);
            Loginuser user = new Loginuser(email, password);
            HttpSession session = request.getSession();
            user.setEmail(email);
            user.setPassword(password);

            utx.begin();
            List<Loginuser> custList = loginService.findUserByEmail(email);
            utx.commit();

            if (!custList.isEmpty()) {

                Loginuser checkEmail = custList.get(0);
                if (checkEmail.getEmail().equals(user.getEmail())) {

                    if (checkEmail.getPassword().equals(user.getPassword())) {

                        session.setAttribute("custList", custList);
                        response.sendRedirect("index.jsp");
                    } else {
                        
                        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                        rd.include(request, response);
                        out.println("<script>document.getElementById(\"passErr\").classList.add(\"active\");</script>");
                    }
                } else {
                    
                    RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                    rd.include(request, response);
                    out.print("<script>document.getElementById(\"emErr\").classList.toggle(\"active\");</script>");
                }

            } else {
                
                RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
                rd.include(request, response);
                out.print("<script>document.getElementById(\"emErr\").classList.toggle(\"active\");</script>");
            }

        } catch (Exception ex) {
            //Logger.getLogger(AddUser.class.getName()).log(Level.SEVERE, null, ex);    
            
            RequestDispatcher rd = request.getRequestDispatcher("login.jsp");
            rd.include(request, response);
            out.print("<script>document.getElementById(\"error\").classList.toggle(\"active\");</script>");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            LoginService loginService = new LoginService(mgr);
            List<Loginuser> userList = loginService.findAll();
            //String userName = userList.getUsername(); 
            HttpSession session = request.getSession();
            session.setAttribute("userList", userList);
            response.sendRedirect("index.jsp");
            //request.getRequestDispatcher("home.jsp").forward(request, response);

        } catch (Exception ex) {
            
            RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
            rd.include(request, response);
            out.print("<script>document.getElementById(\"error\").classList.toggle(\"active\");</script>");
        }
    }
}
