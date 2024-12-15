<%-- 
    Document   : DeleteConfirm
    Created on : May 8, 2023, 2:16:55 AM
    Author     : user
--%>

<%@page import="model.Staff"%>
<%@page import="model.Loginuser"%>
<%@page import="java.util.List"%>
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
        <title>Delete Confirmation</title>

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
                font-size: 24px;
                font-weight: bold;
                margin: 20px 0;
                text-align: center;
            }

            .bi {
                font-size: 1.5rem;
                margin-right: 10px;
            }
            #home {
                text-align: center;
                margin-top: 20px;
            }

            #link {
                color: #0066cc;
                text-decoration: none;
                border-bottom: 1px solid #0066cc;
            }

            #link:hover {
                color: #003d7f;
                border-bottom: 2px solid #003d7f;
            }
        </style>

    </head>
    <body>
        <br><br><br><br><br><br><br><br>
        <p id="home"><a id="link" href="index.jsp">Back to home page</a></p>
        <h2>
            <% List<Loginuser> deleList = (List) session.getAttribute("deleList");
                boolean success = (Boolean) session.getAttribute("success");
                if (success) {%>
            <i class="bi bi-check-circle-fill text-success"></i>
            <%= session.getAttribute("userId")%> 's Information deleted successfully.
            <% } else { %>
            <i class="bi bi-exclamation-circle-fill text-danger"></i>
            Error: Unable to delete user information.
            <% }%>
        </h2>
        <br><br><br><br><br><br><br><br>
    </body>

    <%@ include file="footer.jsp" %>
</html>
