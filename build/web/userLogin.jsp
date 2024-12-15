<%-- 
    Document   : userLogin
    Created on : May 2, 2023, 5:30:27 PM
    Author     : user
--%>

<%@page import="model.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <title>User Sign Up</title>
        
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
            h2 {
                text-align: center;
                margin-top: 20px;
                font-size: 24px;
                font-weight: bold;
                color: black;
            }

            #butt {
                display: block;
                margin: 20px auto 0;
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                background-color: black;
                color: #fff;
                font-size: 16px;
                cursor: pointer;
            }

            #butt:hover {
                background-color: grey;
            }
        </style>
        
    </head>
    <body>
        <br><br><br><br><br><br><br><br>
        <h2>You already sign up the new account!</h2>

        <button onclick=location.href='LoginHome' id="butt">Back to Login</button>
        <br><br><br><br><br><br><br><br>
    </body>
    <%@ include file="footer.jsp" %>
</html>
