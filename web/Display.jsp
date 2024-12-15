<%-- 
    Document   : Display
    Created on : May 6, 2023, 11:44:12 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.util.List"%>
<%@page import="model.*"%>
<%
    List<Loginuser> c = (List) session.getAttribute("custList");
    List<Loginuser> s = (List) session.getAttribute("staffList");
%>
<% if(s != null) { %>
<%@include file="AdminStaffNavBar.jsp"%> 
<% } else if(c != null){ %>
<%@include file="UserNavBar.jsp"%>
<% } else{ %>
<%@include file="GuestNavBar.jsp"%>
<% } %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Display</title>

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

        <!-- Link to Bootstrap CSS file -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.2/css/bootstrap.min.css">

        <!-- Link to Bootstrap Icons CSS file -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.7.2/font/bootstrap-icons.min.css">

        <style>
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
            .search-form {
                text-align: center;
            }
            p {
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

            #search {
                display: flex;
                flex-direction: column;
            }


            .input-box {
                display: flex;
                align-items: center;
                justify-content: center;
            }

            #display {
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
                color: black;
            }
        </style>

    </head>
    <body>
        <%
            List<Loginuser> searchList = (List) session.getAttribute("searchList");
        %>
        <p><a href="index.jsp">Back to home page</a></p>

        <% for (Loginuser user : searchList) {%>
        <div class="search-form">
            <div class="title"><b>Search User</b></div>
            <form id="search">
                
                <div class="input-box">
                    <input type="text" id="display" name="display" value="<%=user.getUserid()%>" maxlength="6" readonly>
                    <input type="submit" id="usearch" name="search" value="Search">
                </div>

            </form>
        </div>
        <% }%>
        <br><br>
        <table class="table">
            <thead>
                <tr>
                    <th scope="col">User ID</th>
                    <th scope="col">User Name</th>
                    <th scope="col">Email</th>
                    <th scope="col">Password</th>
                    <th scope="col">User Status</th>
                </tr>
            </thead>
            <% for (Loginuser user : searchList) {%>
            <tbody>
                <tr>
                    <td><%= user.getUserid()%></td>
                    <td><%= user.getUsername()%> </td>
                    <td><%= user.getEmail()%></td>
                    <td><%= user.getPassword()%></td>
                    <td><%= user.getUserstatus()%></td>
                </tr>
            </tbody>
            <% }%>
        </table>
        <br><br>
        <p><a href="SearchUser.jsp" style="font-size: 1.5em;"><i class="bi bi-arrow-clockwise"></i></a></p>
        <br><br>

    </body>
    <%@ include file="footer.jsp" %>
</html>
