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

public class UpdateStaInfo extends HttpServlet {

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
            StaffService staffService = new StaffService(mgr);

            String updateStaffId = request.getParameter("updatestaffid");
            String updateStaffName = request.getParameter("updateStaffName");
            String updateSemail = request.getParameter("updateSemail");
            String updateSpassword = request.getParameter("updateSpw");
            String updateStaffStatus = request.getParameter("updateStaffStatus");

            utx.begin();
            Staff staff = staffService.findStaffByCode(updateStaffId);
            staff.setStaffname(updateStaffName);
            staff.setSemail(updateSemail);
            staff.setSpassword(updateSpassword);
            boolean success = staffService.updateStaff(staff);
            List<Staff> updaList = staffService.findStaffById(updateStaffId);
            utx.commit();

            HttpSession session = request.getSession();
            session.setAttribute("updaList", updaList);
            session.setAttribute("success", success);
            response.sendRedirect("UpdateStaConfirm.jsp");
        } catch (Exception ex) {

            RequestDispatcher rd = request.getRequestDispatcher("UpdateStaConfirmation.jsp");
            rd.include(request, response);
            out.print("<h3>Error! Unable to obtain the data entered.</h3>");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try(PrintWriter out = response.getWriter()) {
            StaffService staffService = new StaffService(mgr);
            List<Staff> updaList = staffService.findAll();
            HttpSession session = request.getSession();
            session.setAttribute("updaList", updaList);
            response.sendRedirect("StaffHome.jsp");
            //request.getRequestDispatcher("home.jsp").forward(request, response);

        } catch (Exception ex) {

            RequestDispatcher rd = request.getRequestDispatcher("UpdateStaConfirmation.jsp");
            rd.include(request, response);
            out.print("<h3>Error! Unable to obtain the data entered.</h3>");
        }
    }
}
