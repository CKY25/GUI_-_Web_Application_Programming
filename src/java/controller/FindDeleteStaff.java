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
import model.Staff;
import model.StaffService;

public class FindDeleteStaff extends HttpServlet {

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
            String staffid = request.getParameter("delStaff");

            StaffService staffService = new StaffService(mgr);
            Staff staff = new Staff(staffid);
            HttpSession session = request.getSession();
            staff.setStaffid(staffid);

            utx.begin();
            List<Staff> delList = staffService.findStaffById(staffid);
            utx.commit();

            if (!delList.isEmpty()) {

                Staff checkStaffId = delList.get(0);
                if (checkStaffId.getStaffid().equals(staff.getStaffid())) {
                    session.setAttribute("delList", delList);
                    response.sendRedirect("DeleteStaffConfirmation.jsp");

                } else {
                   
                    RequestDispatcher rd = request.getRequestDispatcher("DeleteStaff.jsp");
                    rd.include(request, response);
                    out.print("<script>document.getElementById(\"unableFindStaff\").classList.toggle(\"active\");</script>");
                    //response.sendRedirect("DeleteStaff.jsp");
                }

            } else {
                
                RequestDispatcher rd = request.getRequestDispatcher("DeleteStaff.jsp");
                rd.include(request, response);
                out.print("<script>document.getElementById(\"invalidStaff\").classList.toggle(\"active\");</script>");
                //response.sendRedirect("DeleteStaff.jsp");
            }

        } catch (Exception ex) {
            
            RequestDispatcher rd = request.getRequestDispatcher("DeleteStaff.jsp");
            rd.include(request, response);
            out.print("<script>document.getElementById(\"invalidStaff\").classList.toggle(\"active\");</script>");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try(PrintWriter out = response.getWriter()) {
            StaffService staffService = new StaffService(mgr);
            List<Staff> delList = staffService.findAll();
            HttpSession session = request.getSession();
            session.setAttribute("delList", delList);
            response.sendRedirect("StaffHome.jsp");
            //request.getRequestDispatcher("home.jsp").forward(request, response);

        } catch (Exception ex) {
            
            RequestDispatcher rd = request.getRequestDispatcher("DeleteStaff.jsp");
            rd.include(request, response);
            out.print("<script>document.getElementById(\"invalidStaff\").classList.toggle(\"active\");</script>");
        }
    }
}
