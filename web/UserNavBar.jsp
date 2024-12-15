<%-- 
    Document   : UserNavbar
    Created on : May 1, 2023, 9:01:31 PM
    Author     : User
--%>

<%@page import="model.Loginuser"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    if (getServletContext().getAttribute("copyright") == null || getServletContext().getAttribute("companyname") == null || getServletContext().getAttribute("email") == null) {
        response.sendRedirect("LoadInitServlet");
    }
%>
<!DOCTYPE html>
<html>
    <header>
        <meta charset="utf-8" />
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
        <title>Sketchy</title>

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



        <!-- navigation bar -->
        <nav class="navbar navbar-expand-lg p-0">
            <div class="container-fluid" style="max-height: 70px">
                <div class="nav-start">
                    <button class="btn d-lg-none" type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebar"
                            aria-controls="offcanvasWithBothOptions"><i class="fa-solid fa-bars" style="color: white;"></i></button>
                    <a class="navbar-brand" href="index.jsp"><img class="rounded" src="./src/img/logo.png" height="70" width="70" /><h3 style='display: inline-flex; color: white;'><%=getServletContext().getAttribute("companyname")%></h3></a>
                </div>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false"
                        aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link h4" href="index.jsp">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link h4" href="ViewItem">Item</a>
                        </li>
                    </ul>
                    <div class="input-group d-flex flex-row-reverse">
                        <form class="d-flex" role="search" method="post" action="SearchItem">
                            <input class="form-control me-2 search" type="search" placeholder="Search" aria-label="Search" name="itemsearch">
                            <button class="btn search" type="submit"><i class="fas fa-search "></i></button>
                        </form>
                    </div>
                </div>
                <%
                    List<Loginuser> custList = (List) session.getAttribute("custList");
                %>

                <% for (Loginuser user : custList) {%> 

                <b><%= user.getUsername()%></b>

                <% }%>


                <!-- User-->
                <div class="order-lg-last col-lg-5 col-sm-8 col-8">
                    <div class="d-flex float-end">
                        <li class="nav-item dropdown">
                            <a class="me-1 border rounded py-1 px-3 nav-link d-flex align-items-center">
                                <i class="fas fa-user-alt m-1 me-md-2"></i>
                                <% for (Loginuser user : custList) {%> 

                                <p class="d-none d-md-block mb-0"><%= user.getUsername()%></p>

                                <% }%>
                            </a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a class="dropdown-item" href="UpdUserList"><i class="fas fa-user-alt mx-2" style="color: black;"></i> User Profile</a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="MyOrders.jsp"><i class="fa-solid fa-file-invoice mx-2" style="color: black;"></i>My Orders</a>
                                </li>
                                <li>
                                    <hr class="dropdown-divider">
                                </li>
                                <li>
                                    <a class="dropdown-item" href="Logout"><i class="fa-solid fa-arrow-right-from-bracket  mx-2" style="color: black;"></i>Logout</a>
                                </li>
                            </ul>
                        </li>
                        <li>
                            <a href="cart.jsp" class="border rounded py-1 px-3 nav-link d-flex align-items-center">
                                <i class="fas fa-shopping-cart m-1 me-md-2"></i>
                                <p class="d-none d-md-block mb-0">My cart</p>
                            </a>
                        </li>
                    </div>
                </div>
                <!-- User-->
            </div>
        </nav>
        <!--navigation bar -->

        <!--side bar -->
        <div class="offcanvas-lg d-lg-none offcanvas-start" tabindex="-1" id="sidebar"
             aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-header">
                <form role="search">
                    <input class="form-control me-2 search" type="search" placeholder="Search" aria-label="Search">
                </form>
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" data-bs-target="#sidebar"
                        aria-label="Close"><i class="fa-solid fa-xmark fa-xl" style="color: white;"></i></button>
            </div>
            <div class="offcanvas-body">
                <ul class="sidebar-nav m-0 p-0">
                    <li class="sidenav-item py-2">
                        <a class="sidenav-link text-decotion-none" href="index.jsp">
                            <i class="fa-solid fa-house mx-2" style="color: white;"></i>
                            <span class="sidenav-content">
                                Home
                            </span>
                        </a>
                    </li>
                    <li class="sidenav-item py-2">
                        <a class="sidenav-link text-decotion-none" href="index.jsp">
                            <i class="fa-solid fa-shoe-prints mx-2" style="color: white;"></i>
                            <span class="sidenav-content">
                                Item
                            </span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
        <!--side bar -->
    </header>

    <!-- Include Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.2.3/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>
</html>
