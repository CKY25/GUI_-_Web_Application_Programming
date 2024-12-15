<%-- 
    Document   : AdminStaffNavBar
    Created on : May 1, 2023, 9:04:24 PM
    Author     : User
--%>

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
            <div class="container-fluid">   
                <div class="nav-start">
                    <button class="btn  " type="button" data-bs-toggle="offcanvas" data-bs-target="#sidebar" aria-controls="offcanvasWithBothOptions"><i class="fa-solid fa-bars" style="color: white;"></i></button>
                    <a class="navbar-brand" href="index.jsp"><img class="rounded" src="./src/img/logo.png" height="70" width="70" /><h3 style='display: inline-flex; color: white;'><%=getServletContext().getAttribute("companyname")%></h3></a>
                </div>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav me-auto">
                        <li class="nav-item">
                            <a class="nav-link h4" href="index.jsp">Home</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link h4" href="ViewItem">Item</a>
                        </li>
                    </ul>
                </div>


                <!-- Admin-->
                <div class="order-lg-last col-lg-5 col-sm-8 col-8">
                    <div class="d-flex" style="margin-left: 600px">
                        <li class="nav-item dropdown">
                            <a class="me-1 border rounded py-1 px-3 nav-link d-flex align-items-center">
                                <i class="fa-sharp fa-solid fa-user-secret m-1 me-md-2"></i>
                                <p class="d-none d-md-block mb-0">Staff</p>
                            </a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a class="dropdown-item" href="UpdateStaffList">
                                        <i class="fas fa-user-alt mx-2" style="color: black;"></i></i>
                                        User Profile
                                    </a>
                                </li>
                                <li>
                                    <a class="dropdown-item" href="Logout">
                                        <i class="fa-solid fa-arrow-right-from-bracket  mx-2" style="color: black;"></i>
                                        Logout
                                    </a>
                                </li>
                            </ul>
                        </li>
                    </div>
                </div>
                <!-- Admin-->
            </div>
        </nav>
        <!--navigation bar -->

        <!--side bar -->
        <div class="offcanvas offcanvas-start" tabindex="-1" id="sidebar" aria-labelledby="offcanvasWithBothOptionsLabel">
            <div class="offcanvas-header">
                <h1>Dashboard</h1>
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" data-bs-target="#sidebar"
                        aria-label="Close"><i class="fa-solid fa-xmark fa-xl" style="color: white;"></i></button>
            </div>
            <div class="offcanvas-body">
                <ul class="sidebar-nav m-0 p-0">
                    <li class="sidenav-item py-2">
                        <a class="sidenav-link collapsed"href="dashboard.jsp">
                            <i class="fa-solid fa-house mx-2" style="color: white;"></i>
                            <span class="sidenav-content">  
                                Dashboard 
                            </span>
                        </a>    
                    </li>
                    <li class="sidenav-item py-2">
                        <i class="fas fa-user-alt mx-2" style="color: white;"></i>
                        <a class="sidenav-link text-decoration-none" data-bs-toggle="collapse" href="#custSubmenu" role="button" aria-expanded="false" aria-controls="custSubmenu">
                            <span class="sidenav-content">
                                Manage Customer
                            </span>
                        </a>
                        <div class="collapse" id="custSubmenu">
                            <ul class="nav flex-column">
                                <li class="sidenav-subitem py-1 ps-2">
                                    <a class="sidenav-link" href="SearchUserList"><i class="fas fa-user-alt mx-2" style="color: white;"></i><span class="sidenav-subcontent">Search Customer</span></a>
                                </li>
                                <li class="sidenav-subitem py-1 ps-2">
                                    <a class="sidenav-link" href="UpdateUserList"><i class="fas fa-user-alt mx-2" style="color: white;"></i><span class="sidenav-subcontent">Update Customer</span></a>
                                </li>
                                <li class="sidenav-subitem py-1 ps-2">
                                    <a class="sidenav-link" href="DeleteUserList"><i class="fas fa-user-alt mx-2" style="color: white;"></i><span class="sidenav-subcontent">Delete Customer</span></a>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li class="sidenav-item py-2">
                        <i class="fas fa-user-alt mx-2" style="color: white;"></i>
                        <a class="sidenav-link text-decoration-none" data-bs-toggle="collapse" href="#staffSubmenu" role="button" aria-expanded="false" aria-controls="staffSubmenu">
                            <span class="sidenav-content">
                                Manage Staff
                            </span>
                        </a>
                        <div class="collapse" id="staffSubmenu">
                            <ul class="nav flex-column">
                                <li class="sidenav-subitem py-1 ps-2">
                                    <a class="sidenav-link" href="SearchStaffList"><i class="fas fa-user-alt mx-2" style="color: white;"></i><span class="sidenav-subcontent">Search Staff</span></a>
                                </li>
                                <li class="sidenav-subitem py-1 ps-2">
                                    <a class="sidenav-link" href="signUpStaffCheck"><i class="fas fa-user-alt mx-2" style="color: white;"></i><span class="sidenav-subcontent">Add Staff</span></a>
                                </li>
                                <li class="sidenav-subitem py-1 ps-2">
                                    <a class="sidenav-link" href="UpdateStaList"><i class="fas fa-user-alt mx-2" style="color: white;"></i><span class="sidenav-subcontent">Update Staff</span></a>
                                </li>
                                <li class="sidenav-subitem py-1 ps-2">
                                    <a class="sidenav-link" href="DeleteStaffList"><i class="fas fa-user-alt mx-2" style="color: white;"></i><span class="sidenav-subcontent">Delete Staff</span></a>
                                </li>
                            </ul>
                        </div>
                    </li>
                    <li class="sidenav-item py-2">
                        <a class="sidenav-link collapsed"href="AddItem">
                            <i class="fa-solid fa-shoe-prints mx-2" style="color: white;"></i>
                            <span class="sidenav-content">  
                                Manage Item    
                            </span>
                        </a>    
                    </li>
                    <li class="sidenav-item py-2">
                        <a class="sidenav-link collapsed" href="ViewOrder">
                            <i class="fa-solid fa-file-invoice-dollar mx-2" style="color: white;"></i>
                            <span class="sidenav-content">
                                Order History
                            </span>
                        </a>
                    </li>
                    <li class="sidenav-item py-2">
                        <a class="sidenav-link collapsed" href="GenerateItemReport">
                            <i class="fas fa-chart-line fa-lg mx-2" style="color: white;"></i>
                            <span class="sidenav-content">
                                Generate Report
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
