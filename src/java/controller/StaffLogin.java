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
import model.Staff;
import model.StaffService;

public class StaffLogin extends HttpServlet {

    @PersistenceContext
    EntityManager mgr;
    @Resource
    UserTransaction utx;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try(PrintWriter out = response.getWriter()) {

            String email = request.getParameter("xlemail");
            String password = request.getParameter("xlpassword");

            StaffService staffService = new StaffService(mgr);
            Staff staff = new Staff(email, password);
            HttpSession session = request.getSession();
            staff.setSemail(email);
            staff.setSpassword(password);

            utx.begin();
            List<Staff> staffList = staffService.findStaffByEmail(email);
            utx.commit();

            if (!staffList.isEmpty()) {

                Staff checkEmail = staffList.get(0);
                if (checkEmail.getSemail().equals(staff.getSemail())) {

                    if (checkEmail.getSpassword().equals(staff.getSpassword())) {

                        session.setAttribute("staffList", staffList);
                        response.sendRedirect("index.jsp");
                    } else {

                        RequestDispatcher rd = request.getRequestDispatcher("StaffLogin.jsp");
                        rd.include(request, response);
                        out.print("<script>document.getElementById(\"passwordErr\").classList.add(\"active\");</script>");
                    }
                } else {

                    RequestDispatcher rd = request.getRequestDispatcher("StaffLogin.jsp");
                    rd.include(request, response);
                    out.print("<script>document.getElementById(\"emailErr\").classList.toggle(\"active\");</script>");
                    //response.sendRedirect("StaffLogin.jsp");
                }

            } else {

                RequestDispatcher rd = request.getRequestDispatcher("StaffLogin.jsp");
                rd.include(request, response);
                out.print("<script>document.getElementById(\"emailErr\").classList.toggle(\"active\");</script>");
                //response.sendRedirect("StaffLogin.jsp");
            }

        } catch (Exception ex) {

            RequestDispatcher rd = request.getRequestDispatcher("StaffLogin.jsp");
            rd.include(request, response);
            out.print("<script>document.getElementById(\"serror\").classList.toggle(\"active\");</script>");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try(PrintWriter out = response.getWriter()) {
            StaffService staffService = new StaffService(mgr);
            List<Staff> staffList = staffService.findAll();
            //String userName = userList.getUsername(); 
            HttpSession session = request.getSession();
            session.setAttribute("staffList", staffList);
            response.sendRedirect("StaffHome.jsp");
            //request.getRequestDispatcher("home.jsp").forward(request, response);

        } catch (Exception ex) {

            RequestDispatcher rd = request.getRequestDispatcher("StaffLogin.jsp");
            rd.include(request, response);
            out.print("<script>document.getElementById(\"serror\").classList.toggle(\"active\");</script>");
        }
    }
}
