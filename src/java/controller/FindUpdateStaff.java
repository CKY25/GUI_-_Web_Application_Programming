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

public class FindUpdateStaff extends HttpServlet {

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
            String staffid = request.getParameter("updstaffid");

            StaffService staffService = new StaffService(mgr);
            Staff staff = new Staff(staffid);
            HttpSession session = request.getSession();
            staff.setStaffid(staffid);

            utx.begin();
            List<Staff> updList = staffService.findStaffById(staffid);
            utx.commit();

            //response.sendRedirect("userLogin.jsp");
            if (!updList.isEmpty()) {

                Staff checkStaffId = updList.get(0);
                if (checkStaffId.getStaffid().equals(staff.getStaffid())) {

                    session.setAttribute("updList", updList);
                    response.sendRedirect("UpdateStaConfirmation.jsp");

                } else {
                    
                    RequestDispatcher rd = request.getRequestDispatcher("UpdateStaInfo.jsp");
                    rd.include(request, response);
                    out.print("<script>document.getElementById(\"unableFindStaff\").classList.toggle(\"active\");</script>");
                    //response.sendRedirect("UpdateStaInfo.jsp");
                }

            } else {
                
                RequestDispatcher rd = request.getRequestDispatcher("UpdateStaInfo.jsp");
                rd.include(request, response);
                out.print("<script>document.getElementById(\"invalidStaff\").classList.toggle(\"active\");</script>");
                //response.sendRedirect("UpdateStaInfo.jsp");
            }

        } catch (Exception ex) {
            
            RequestDispatcher rd = request.getRequestDispatcher("UpdateStaInfo.jsp");
            rd.include(request, response);
            out.print("<script>document.getElementById(\"invalidStaff\").classList.toggle(\"active\");</script>");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try(PrintWriter out = response.getWriter()) {
            StaffService staffService = new StaffService(mgr);
            List<Staff> updList = staffService.findAll();
            //String userName = userList.getUsername(); 
            HttpSession session = request.getSession();
            session.setAttribute("updList", updList);
            response.sendRedirect("StaffHome.jsp");
            //request.getRequestDispatcher("home.jsp").forward(request, response);

        } catch (Exception ex) {
            
            RequestDispatcher rd = request.getRequestDispatcher("UpdateStaInfo.jsp");
            rd.include(request, response);
            out.print("<script>document.getElementById(\"invalidStaff\").classList.toggle(\"active\");</script>");
        }
    }
}
