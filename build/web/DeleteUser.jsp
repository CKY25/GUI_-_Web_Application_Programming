<%-- 
    Document   : DeleteUser
    Created on : May 6, 2023, 8:52:35 PM
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

<%
    List<Loginuser> ctList = (List) session.getAttribute("custList");
    List<Staff> stList = (List) session.getAttribute("staffList");
    String manager = (String) session.getAttribute("manager");
    System.out.println(manager);
    //Example user
    if ((ctList != null) || (stList != null) && (!manager.equals("manager"))) {
        // Customer is not authorized to access the restricted page
        RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
        rd.include(request, response);
        out.println("<script>let myModal = new bootstrap.Modal(document.getElementById('noPermission'), {});myModal.show();</script>");
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Delete User</title>

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
            #invalidUser, #unableFind {
                margin: 0;
                padding: 0;
                display: none;
                color: red;
            }

            #invalidUser.active, #unableFind.active {
                display: inline-block;
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
            .search-form{
                text-align: center;
            }

            .search-form {
                margin: 20px auto;
                max-width: 600px;
                padding: 20px;
                border: 1px solid #ccc;
                border-radius: 10px;
                background-color: #f5f5f5;
            }

            .title {
                font-size: 24px;
                font-weight: bold;
                margin-bottom: 20px;
                text-align: center;
            }

            #delete {
                display: flex;
                flex-direction: column;
            }


            .input-box {
                display: flex;
                align-items: center;
                justify-content: center;
            }

            #delUser {
                padding: 10px;
                margin-right: 10px;
                border-radius: 5px;
                border: 1px solid #ccc;
                font-size: 16px;
            }

            #usearch {
                padding: 10px;
                border-radius: 5px;
                border: none;
                background-color: black;
                color: #fff;
                font-size: 16px;
                cursor: pointer;
            }

            #usearch:hover {
                background-color: white;
                color:black;
            }
        </style>
        <script>
            function invalidUser() {
                document.getElementById("invalidUser").classList.toggle("active");
            }
            function unableFind() {
                document.getElementById("unableFind").classList.toggle("active");
            }
        </script>
    </head>
    <body>
        <%
            List<Loginuser> deleteList = (List) session.getAttribute("deleteList");
        %>

        <div class="search-form">
            <div class="title"><b>Search Delete User</b></div>
            <form id="delete" method="post" action="FindDeleteUser">

                <div class="input-box">
                    <input type="text" id="delUser" name="delUser" placeholder="Enter user id" maxlength="6" required>
                    <input type="submit" id="usearch" name="usearch" value="Search User">
                </div>
                <p id="invalidUser">Error! This user ID does not exist in database</p>
                <p id="unableFind">Error! Unable to find this user ID</p>
            </form>
        </div>


        <br><br>
        <table class="table">
            <thead>
                <tr>
                    <th scope="col">User ID</th>
                    <th scope="col">User Name</th>
                    <th scope="col">Email</th>
                    <th scope="col">User Status</th>
                </tr>
            </thead>
            <% for (Loginuser user : deleteList) {%>
            <tbody>
                <tr>
                    <td><%= user.getUserid()%></td>
                    <td><%= user.getUsername()%> </td>
                    <td><%= user.getEmail()%></td>
                    <td><%= user.getUserstatus()%></td>
                </tr>
            </tbody>
            <% }%>
        </table>
        <br><br>
    </body>

    <%@ include file="footer.jsp" %>
</html>
