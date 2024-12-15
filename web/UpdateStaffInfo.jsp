<%-- 
    Document   : UpdateStaffInfo
    Created on : May 8, 2023, 6:35:50 PM
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
        <title>Update Information</title>

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

        <script>
            function confirmUpdate() {
                var inputName = document.getElementById("updStaffName");
                var inputEmail = document.getElementById("updSemail");
                var inputPass = document.getElementById("updSpw");

                var stringRegex = /^[a-zA-Z\s]*$/;

                if (!inputName.value.match(stringRegex)) {
                    alert('Error! The name must be only alphabet ');
                    inputName.focus();
                    return false;
                } else {
                    if (window.confirm("Are you sure you want to update?")) {
                        return true;
                    } else {
                        return false;
                    }
                }
            }


        </script>
    </head>
    <body>
        <%
            List<Staff> staList = (List) session.getAttribute("staList");
        %>

        
        <br>
        <h2>Update Staff Information (Staff)</h2>
        <form id="updstaff" action="UpdateStaffInfo" method="post">
            <table id="stafftable" name="stafftable" border="0">
                <% for (Staff staff : staList) {%>
                <tr>
                    <td>Staff ID</td>
                    <td><input type="text" id="updstaffid" name="updstaffid"
                               value="<%=staff.getStaffid()%>" readonly></td>
                </tr>
                <tr>
                    <td>Staff Name</td>
                    <td><input type="text" id="updStaffName" name="updStaffName"
                               value="<%=staff.getStaffname()%>" readonly></td>
                </tr>
                <tr>
                    <td>Staff Email</td>
                    <td><input type="email" id="updSemail" name="updSemail" 
                               value="<%=staff.getSemail()%>" maxlength="80"></td>
                </tr>
                <tr>
                    <td>Staff Password</td>
                    <td><input type="text" id="updSpw" name="updSpw"
                               value="<%=staff.getSpassword()%>" maxlength="7"></td>
                </tr>
                <tr>
                    <td>Staff Status</td>
                    <td><input type="text" id="updStatus" name="updStatus"
                               value="<%=staff.getStaffstatus()%>" readonly></td>
                </tr>
            </table>

            <% }%>

            <br><input type="submit" id="upd" name="upd" onclick="return confirmUpdate()" value="Update Staff Information">

        </form>
    </body>
    <%@ include file="footer.jsp" %>
</html>
