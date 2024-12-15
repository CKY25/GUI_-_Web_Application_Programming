<%-- 
    Document   : UpdateStaffConfirm
    Created on : May 8, 2023, 8:35:01 PM
    Author     : user
--%>

<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="model.*"%>
<%
    List<Loginuser> custListtest = (List) session.getAttribute("custList");
    List<Staff> staffListtest = (List) session.getAttribute("staffList");
%>
<% if (staffListtest != null) {%>
<%@include file="AdminStaffNavBar.jsp"%> 
<% } else if (custListtest != null) {%>
<%@include file="UserNavBar.jsp"%>
<% } else {%>
<%@include file="GuestNavBar.jsp"%>
<% } %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Staff Information Confirm</title>
        
        <!-- Favicon -->
        <link rel="icon" type="image/png" href="./src/img/logo.png" />

        <!-- Fonts-->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Oswald:wght@500&display=swap" rel="stylesheet">

        <!-- CSS stylesheet -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.2.3/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css" />
        <link rel="stylesheet" href="./src/css/style.css" />
        
        <style>
            /* Style for table */
            table {
                border-collapse: collapse;
                width: 100%;
                max-width: 600px;
            }

            th, td {
                padding: 8px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }

            /* Style for form input fields */
            input[type=text], input[type=email], input[type=password] {
                width: 100%;
                padding: 12px 20px;
                margin: 8px 0;
                box-sizing: border-box;
                border: none;
                border-bottom: 1px solid #ddd;
                background-color: #f8f8f8;
            }

            input[type=submit] {
                background-color: black;
                color: white;
                padding: 12px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                float: center;
            }

            input[type=submit]:hover {
                background-color: grey;
                color: white;
            }

            /* Style for form label */
            label {
                font-weight: bold;
                display: block;
                margin-bottom: 10px;
            }

            /* Style for form heading */
            h2 {
                font-size: 28px;
                margin-bottom: 20px;
                text-align: center;
            }
            #updstaff {
                
                margin-left: 25%;
            }
            #upd {
                margin-left: 20%;
            }
            </style>
    </head>
    <body>
        <br>

        <%
            List<Staff> updList = (List) session.getAttribute("updList");
            boolean success = (Boolean) session.getAttribute("success");
            if (success)
                out.println("<h2>Staff Information updated successfully.</h2>");
            else
                out.println("<h2>Error: Unable to update staff information.</h2>");
        %>

        <% for (Staff staff : updList) {%>
        <form id="updstaff" name="updstaff">
        
            <table id="stafftable" name="stafftable" border="0">
                <tr>
                    <td>Staff ID</td>
                    <td><input type="text" value="<%=staff.getStaffid()%>" readonly></td>
                </tr>
                <tr>
                    <td>Staff Name</td>
                    <td><input type="text" value="<%=staff.getStaffname()%>" readonly></td>
                </tr>
                <tr>
                    <td>Staff Email</td>
                    <td><input type="text" value="<%=staff.getSemail()%>" readonly></td>
                </tr>
                <tr>
                    <td>Staff Password</td>
                    <td><input type="text" value="<%=staff.getSpassword()%>" readonly></td>
                </tr>
                <tr>
                    <td>Staff Status</td>
                    <td><input type="text" value="<%=staff.getStaffstatus()%>" readonly></td>
                </tr>
            </table>
            <% }%>
            <br><br><br>
        </form>
    </body>
    
    <%@ include file="footer.jsp" %>
    
</html>
