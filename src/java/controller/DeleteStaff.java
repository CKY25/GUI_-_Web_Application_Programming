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

public class DeleteStaff extends HttpServlet {

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

            String deleteStaffId = request.getParameter("deletestaffid");
            String deleteStaffName = request.getParameter("delStaffName");
            String deleteSemail = request.getParameter("delSemail");
            String deleteSpPassword = request.getParameter("delSpw");
            String deleteStaffStatus = request.getParameter("delStaffStatus");

            String staffId = deleteStaffId;
            utx.begin();
            Staff staff = staffService.findStaffByCode(deleteStaffId);
            List<Staff> deleList = staffService.findAll();
            boolean success = staffService.delStaff(staff);

            utx.commit();

            HttpSession session = request.getSession();
            session.setAttribute("deleList", deleList);
            session.setAttribute("success", success);
            session.setAttribute("staffId", staffId);
            response.sendRedirect("DeleteStaffConfirm.jsp");
        } catch (Exception ex) {
            
            RequestDispatcher rd = request.getRequestDispatcher("DeleteStaff.jsp");
            rd.include(request, response);
            out.print("<h3>Sorry this staff unable to delete. Error!</h3>");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try(PrintWriter out = response.getWriter()) {
            StaffService staffService = new StaffService(mgr);
            List<Staff> deleList = staffService.findAll();
            //String userName = userList.getUsername(); 
            HttpSession session = request.getSession();
            session.setAttribute("deleList", deleList);
            response.sendRedirect("StaffHome.jsp");
            //request.getRequestDispatcher("home.jsp").forward(request, response);

        } catch (Exception ex) {
            
            RequestDispatcher rd = request.getRequestDispatcher("DeleteStaff.jsp");
            rd.include(request, response);
            out.print("<h3>Error! Staff Information failed to delete.</h3>");
        }
    }
}
