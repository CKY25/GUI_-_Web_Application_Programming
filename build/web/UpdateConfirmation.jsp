<%-- 
    Document   : UpdateConfirmation
    Created on : May 7, 2023, 3:01:35 PM
    Author     : user
--%>

<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <title>Update User Information</title>

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
            #update {
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

            function validateUpdateForm() {
                var inputName = document.getElementById("updUserName");
                var inputEmail = document.getElementById("updEmail");
                var inputPass = document.getElementById("updPw");

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
            List<Loginuser> updList = (List) session.getAttribute("updList");
        %>
        <p><a href="index.jsp">Back to home page</a></p>

        <br><h2>Update User Information</h2>

        <form id="update" action="UpdateUserInfo" method="post">
            <table border="0">
                <% for (Loginuser user : updList) {%>
                <tr>
                    <td>User ID</td><br>
                <td><input type="text" id="updateuserid" name="updateuserid"
                           value="<%=user.getUserid()%>" readonly></td>
                </tr>
                <tr>
                    <td>User Name</td>
                    <td><input type="text" id="updUserName" name="updUserName"
                               value="<%=user.getUsername()%>" maxlength="80" required></td>
                </tr>
                <tr>
                    <td>Email</td>
                    <td><input type="email" id="updEmail" name="updEmail" 
                               value="<%=user.getEmail()%>" maxlength="80" required></td>
                </tr>
                <tr>
                    <td>Password</td>
                    <td><input type="text" id="updPw" name="updPw"
                               value="<%=user.getPassword()%>" maxlength="7" required></td>
                </tr>
                <tr>
                    <td>User Status</td>
                    <td><input type="text" id="updStatus" name="updStatus"
                               value="<%=user.getUserstatus()%>" readonly></td>
                </tr>
            </table>

            <% }%>
            <br><input type="submit" id="updInfo" onclick="return validateUpdateForm()" value="Update User Information">

        </form>

    </body>

    <%@ include file="footer.jsp" %>

</html>
