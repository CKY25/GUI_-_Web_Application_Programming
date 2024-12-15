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

public class AddStaff extends HttpServlet {

    @PersistenceContext
    EntityManager mgr;
    @Resource
    UserTransaction utx;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            //obtain input from users/view
            String userName = request.getParameter("xsuname");
            String email = request.getParameter("xsemail");
            String password = request.getParameter("xsupassword");

            //interact with model/entity class
            StaffService staffService = new StaffService(mgr);
            Staff staff = new Staff(userName, email, password);
            HttpSession session = request.getSession();
            utx.begin();
            List<Staff> emailList = staffService.findStaffByEmail(email);
            utx.commit();
            if (!emailList.isEmpty()) {
                Staff checkEmail = emailList.get(0);
                if (!(checkEmail.getSemail().equals(staff.getSemail()))) {
                    String lastUserID = staffService.findLastStaffId();
                    String newID = staff.generateStaffID(lastUserID);
                    staff.setStaffid(newID);
                    staff.setStaffstatus("staff");

                    session.setAttribute("staff", staff);
                    utx.begin();
                    boolean success = staffService.addStaff(staff);
                    utx.commit();
                    session.setAttribute("success", success);

                    response.sendRedirect("signUpConfirm.jsp");

                } else {

                    RequestDispatcher rd = request.getRequestDispatcher("StaffSignUp.jsp");
                    rd.include(request, response);
                    out.print("<script>document.getElementById(\"duplicateXemail\").classList.toggle(\"active\");</script>");
                }
            } else {

                String lastUserID = staffService.findLastStaffId();
                String newID = staff.generateStaffID(lastUserID);
                staff.setStaffid(newID);
                staff.setStaffstatus("staff");

                session.setAttribute("staff", staff);
                utx.begin();
                boolean success = staffService.addStaff(staff);
                utx.commit();
                session.setAttribute("success", success);

                response.sendRedirect("signUpConfirm.jsp");

            }

        } catch (Exception ex) {
            //Logger.getLogger(AddStaff.class.getName()).log(Level.SEVERE, null, ex);

            RequestDispatcher rd = request.getRequestDispatcher("StaffSignUp.jsp");
            rd.include(request, response);
            out.print("<script>document.getElementById(\"xerr\").classList.toggle(\"active\");</script>");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            StaffService staffService = new StaffService(mgr);
            List<Staff> staffList = staffService.findAll();
            //String userName = userList.getUsername(); 
            HttpSession session = request.getSession();
            session.setAttribute("staffList", staffList);
            response.sendRedirect("StaffHome.jsp");
            //request.getRequestDispatcher("home.jsp").forward(request, response);

        } catch (Exception ex) {

            RequestDispatcher rd = request.getRequestDispatcher("StaffSignUp.jsp");
            rd.include(request, response);
            out.print("<script>document.getElementById(\"xerr\").classList.toggle(\"active\");</script>");
        }
    }
}
