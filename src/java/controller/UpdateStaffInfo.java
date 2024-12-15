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

public class UpdateStaffInfo extends HttpServlet {

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

            String updatestaffid = request.getParameter("updstaffid");
            String updateStaffName = request.getParameter("updStaffName");
            String updateSemail = request.getParameter("updSemail");
            String updateSpassword = request.getParameter("updSpw");
            String updateStaffStatus = request.getParameter("updStatus");

            //Loginuser user = new Loginuser(updateUserId,updateUserName, updateEmail, updatePassword, updateUserStatus);
            utx.begin();
            Staff staff = staffService.findStaffByCode(updatestaffid);
            staff.setSemail(updateSemail);
            staff.setSpassword(updateSpassword);
            boolean success = staffService.updateStaff(staff);
            //Loginuser update = loginService.findUserByCode(updateUserId);
            List<Staff> updList = staffService.findStaffById(updatestaffid);
            utx.commit();

            HttpSession session = request.getSession();
            session.setAttribute("updList", updList);
            session.setAttribute("success", success);
            response.sendRedirect("UpdateStaffConfirm.jsp");
        } catch (Exception ex) {

            RequestDispatcher rd = request.getRequestDispatcher("UpdateStaffInfo.jsp");
            rd.include(request, response);
            out.print("<h3>Error! Unable to obtain the data entered.</h3>");
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
            response.sendRedirect("login.jsp");
            //request.getRequestDispatcher("home.jsp").forward(request, response);

        } catch (Exception ex) {

            RequestDispatcher rd = request.getRequestDispatcher("UpdateStaffInfo.jsp");
            rd.include(request, response);
            out.print("<h3>Error! Unable to obtain the data entered.</h3>");
        }
    }
}
