<%-- 
    Document   : UpdateStaConfirmation
    Created on : May 8, 2023, 11:00:47 PM
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
        <title>Update Staff Information</title>
        
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
            #updat {
                margin: 20px auto;
                max-width: 600px;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 10px;
                background-color: #f5f5f5;
            }

            h2 {
                font-size: 24px;
                font-weight: bold;
                margin-bottom: 20px;
                text-align: center;
            }

            table {
                width: 100%;
            }

            td {
                padding: 10px;
            }

            input[type="text"],
            input[type="email"],
            input[type="password"] {
                width: 100%;
                padding: 10px;
                border-radius: 5px;
                border: 1px solid #ccc;
                font-size: 16px;
            }

            input[type="submit"] {
                margin-top: 20px;
                padding: 10px;
                border-radius: 5px;
                border: none;
                background-color: black;
                color: #fff;
                font-size: 16px;
                cursor: pointer;
            }

            input[type="submit"]:hover {
                background-color: grey;
            }
        </style>
        
        <script>
            function validateUpdForm() {
                var inputName = document.getElementById("updateStaffName");
                var inputEmail = document.getElementById("updateSemail");
                var inputPass = document.getElementById("updateSpw");

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
            List<Staff> updList = (List) session.getAttribute("updList");
        %>
        
        <br>

        <h2>Update Staff Information</h2>
        <form id="updat" action="UpdateStaInfo" method="post">
            <table border="0">
                <% for (Staff staff : updList) {%>
                <tr>
                    <td>Staff ID</td>
                    <td><input type="text" id="updatestaffid" name="updatestaffid"
                               value="<%=staff.getStaffid()%>" readonly></td>
                </tr>
                <tr>
                    <td>Staff Name</td>
                    <td><input type="text" id="updateStaffName" name="updateStaffName"
                               value="<%=staff.getStaffname()%>" maxlength="80" required></td>
                </tr>
                <tr>
                    <td>Staff Email</td>
                    <td><input type="email" id="updateSemail" name="updateSemail" 
                               value="<%=staff.getSemail()%>" maxlength="80" required></td>
                </tr>
                <tr>
                    <td>Staff Password</td>
                    <td><input type="text" id="updateSpw" name="updateSpw"
                               value="<%=staff.getSpassword()%>" maxlength="7" required></td>
                </tr>
                <tr>
                    <td>Staff Status</td>
                    <td><input type="text" id="updateStaffStatus" name="updateStaffStatus"
                               value="<%=staff.getStaffstatus()%>" readonly></td>
                </tr>
            </table>

            <% }%>
            <br><input type="submit" onclick="return validateUpdForm()" value="Update Staff Information">

        </form>

    </body>
    <%@ include file="footer.jsp" %>
</html>
