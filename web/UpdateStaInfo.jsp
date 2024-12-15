<%-- 
    Document   : UpdateStaInfo
    Created on : May 8, 2023, 10:28:36 PM
    Author     : kivac
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.util.List"%>
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
            #invalidStaff, #unableFindStaff {
                margin: 0;
                padding: 0;
                display: none;
                color: red;
            }

            #invalidStaff.active, #unableFindStaff.active {
                display: inline-block;
            }
            
            .title {
                font-size: 24px;
                font-weight: bold;
                text-align: center;
                margin-bottom: 20px;
            }

            .table {
                width: 100%;
                max-width: 100%;
                margin-bottom: 1rem;
                background-color: #fff;
                border-collapse: collapse;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0px 0px 10px rgba(0,0,0,0.2);
            }
            
            .search-form{
                text-align: center;
            }
            
            .search-form {
                margin: 20px auto;
                max-width: 600px;
                padding: 20px;
                border: 0px solid #ccc;
                border-radius: 10px;
                background-color: white;
            }

            .table thead th {
                font-size: 16px;
                font-weight: 600;
                color: #fff;
                background-color: black;
                border-color: black;
                border-radius: 0px;
                text-align: left;
                vertical-align: middle;
                padding: 0.75rem;
                border-bottom: 0px;
            }

            .table tbody tr {
                border-bottom: 1px solid #dee2e6;
            }

            .table tbody td {
                font-size: 14px;
                color: #000;
                vertical-align: middle;
                padding: 0.75rem;
                border: 0px;
            }

            .table tbody tr:last-child td {
                border-bottom: 0px;
            }

            .input-box {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: 20px;
            }

            input[type=text] {
                padding: 10px;
                width: 200px;
                border: none;
                border-bottom: 2px solid #ccc;
                font-size: 16px;
                margin-right: 10px;
            }

            input[type=submit] {
                background-color: black;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
            }

            input[type=submit]:hover {
                background-color: grey;
            }
        </style>
        <script>
            function invalidStaff() {
                document.getElementById("invalidStaff").classList.toggle("active");
            }
            function unableFind() {
                document.getElementById("unableFindStaff").classList.toggle("active");
            }
        </script>
    </head>
    <body>
        <%
            List<Staff> updateList = (List) session.getAttribute("updateList");
        %>
        <br>

        <div class="search-form">
            <div class="title"><b>Search Update Staff</b></div>
            <form method="post" action="FindUpdateStaff">
                <div class="input-box">
                    <input type="text" id="updstaffid" name="updstaffid" placeholder="Enter staff id" maxlength="6" required>
                    <input type="submit" id="search" name="search" value="Search">
                </div>
                <p id="invalidStaff">Error! This staff ID does not exist in database</p>
                <p id="unableFindStaff">Error! Unable to find this staff ID</p>
            </form>
        </div>


        <br><br>
        <table class="table">
            <thead>
                <tr>
                    <th scope="col">Staff ID</th>
                    <th scope="col">Staff Name</th>
                    <th scope="col">Staff Email</th>
                    <th scope="col">Staff Password</th>
                    <th scope="col">Staff Status</th>
                </tr>
            </thead>
            <% for (Staff staff : updateList) {%>
            <tbody>
                <tr>
                    <td><%= staff.getStaffid()%></td>
                    <td><%= staff.getStaffname()%> </td>
                    <td><%= staff.getSemail()%></td>
                    <td><%= staff.getSpassword()%></td>
                    <td><%= staff.getStaffstatus()%></td>
                </tr>
            </tbody>
            <% }%>
        </table>
        <br><br>
    </body>
    <%@ include file="footer.jsp" %>
</html>
