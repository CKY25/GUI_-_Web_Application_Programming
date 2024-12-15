<%-- 
    Document   : dashboard
    Created on : May 5, 2023, 1:21:51 PM
    Author     : User
--%>

<%@page import="model.Staff"%>
<%@page import="model.Loginuser"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.math.BigDecimal"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="javax.persistence.Query"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="model.Orders"%>
<%@page import="java.util.List"%>
<%@page import="javax.persistence.TypedQuery"%>
<%@page import="javax.persistence.TypedQuery"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
<html>
    <header>
        <meta charset="utf-8" />
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
        <title>Admin Dashboard</title>

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


        <%@ include file="AdminStaffNavBar.jsp" %>

    </header>       
    <body>
        <div class="container">
            <h1>Dashboard</h1>
        </div>
        <div class="container row justify-content-evenly p-3 mx-auto">        
            <div class="container row justify-content-evenly p-3 mx-auto">      
                <div class="row col-lg-2 col-md-6 col-sm-12 shadow-lg rounded-4 mx-2 my-0 p-0">
                    <%                    EntityManagerFactory emf = Persistence.createEntityManagerFactory("Assignment1PU");
                        EntityManager em = emf.createEntityManager();
                        Query totalQuery = em.createQuery("SELECT SUM(o.totalPrice) FROM Orders o");
                        Double totalPrice = (Double) totalQuery.getSingleResult();
                    %>
                    <div class="col-3">
                        <span class="rounded-circle bg-dark py-3 px-3">
                            <i class="fa-solid fa-dollar-sign fa-xl py-5 " style="color: white;"></i>
                        </span>
                    </div>
                    <div class="col-9">
                        <div class="row">
                            <p></p>
                        </div>
                        <div class="row">
                            <h5 class="text-secondary my-0 pb-2">Revenue</h5>
                        </div>
                        <div class="row">   
                            <h5 class="fw-bold my-0">RM<%= String.format("%.2f", totalPrice)%></h5>
                        </div>
                    </div>
                </div>
                <%
                    Query monthlyQuery = em.createQuery("SELECT SUM(o.totalPrice) FROM Orders o WHERE FUNCTION('YEAR', o.orderDate) = :currentYear AND FUNCTION('MONTH', o.orderDate) = :currentMonth");
                    monthlyQuery.setParameter("currentYear", Calendar.getInstance().get(Calendar.YEAR));
                    monthlyQuery.setParameter("currentMonth", Calendar.getInstance().get(Calendar.MONTH) + 1);

                    Double monthlyEarnings = (Double) monthlyQuery.getSingleResult();
                %>
                <div class="row col-lg-2 col-md-6 col-sm-12 shadow-lg rounded-4 mx-2 my-0 p-0">
                    <div class="col-3">
                        <span class="rounded-circle bg-dark py-3 px-3">
                            <i class="fa-solid fa-bag-shopping fa-xl py-5 " style="color: #fff0f0;"></i>
                        </span>
                    </div>
                    <div class="col-9">
                        <div class="row">
                            <p></p>
                        </div>
                        <div class="row">
                            <h5 class="text-secondary my-0 pb-2">Monthly Sales</h5>
                        </div>
                        <div class="row">   
                            <h5 class="fw-bold my-0">RM<%= String.format("%.2f", monthlyEarnings)%></h5>
                        </div>
                    </div>
                </div>
                <%
                    Query dailyQuery = em.createQuery("SELECT SUM(o.totalPrice) FROM Orders o WHERE o.orderDate = :date", Orders.class).setParameter("date", java.sql.Date.valueOf(java.time.LocalDate.now()));
                    Double dailySales = (Double) dailyQuery.getSingleResult();
                %>
                <div class="row col-lg-2 col-md-6 col-sm-12 shadow-lg rounded-4 mx-2 my-0 p-0">
                    <div class="col-3">
                        <span class="rounded-circle bg-dark py-3 px-3">
                            <i class="fa-solid fa-qrcode fa-xl py-5 " style="color: #ffffff;"></i>
                        </span>
                    </div>
                    <div class="col-9">
                        <div class="row">
                            <p></p>
                        </div>
                        <div class="row">
                            <h5 class="text-secondary my-0 pb-2">Daily Sales</h5>
                        </div>
                        <% if (dailySales == null) {%>
                        <div class="row">   
                            <h5 class="fw-bold my-0">RM0</h5>
                        </div>
                        <% } else {%>
                        <div class="row">   
                            <h5 class="fw-bold my-0">RM<%= dailySales%></h5>
                        </div>
                        <% } %>
                    </div>
                </div>
                <%
                    Query orderQuery = em.createQuery("SELECT COUNT(o) FROM Orders o");
                    Long totalOrder = (Long) orderQuery.getSingleResult();
                %>
                <div class="row col-lg-2 col-md-6 col-sm-12 shadow-lg rounded-4 mx-2 my-0 p-0">
                    <div class="col-3">
                        <span class="rounded-circle bg-dark py-3 px-2">
                            <i class="fa-solid fa-truck fa-xl py-5 " style="color: #fafafa;"></i>
                        </span>
                    </div>
                    <div class="col-9">
                        <div class="row">
                            <p></p>
                        </div>
                        <div class="row">
                            <h5 class="text-secondary my-0 pb-2">Orders</h5>
                        </div>
                        <div class="row">   
                            <h5 class="fw-bold my-0"><%= totalOrder%> Orders</h5>
                        </div>
                    </div>
                </div>       
            </div>

            <%  TypedQuery<Orders> query = em.createQuery("SELECT o FROM Orders o ORDER BY o.orderDate DESC", Orders.class);
                List<Orders> orderList = query.getResultList();
            %>

            <div class="container rounded-4 shadow-lg p-4 mt-4 mb-5">
                <h3 class="pb-2">Latest Orders</h3>
                <table class="table table-hover table-striped table-bordered">
                    <thead>
                        <tr>    
                            <th>Order ID</th>
                            <th>Customer Name</th>
                            <th>Item Ordered</th>
                            <th>Quantity</th>
                            <th>Payment Method</th>
                            <th>Total Amount</th>
                            <th>Order Date</th>
                            <th>Order Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Orders orders : orderList) {%>
                        <tr>
                            <td><%= orders.getOrderId()%></td>
                            <td><%= orders.getLoginuser().getUsername()%></td>
                            <td><%= orders.getItem().getItemname()%></td>
                            <td><%= orders.getQuantity()%></td>
                            <td><%= orders.getPaymentMethod()%></td>
                            <td><%= orders.getTotalPrice()%></td>
                            <%
                                DateFormat targetDateFormat = new SimpleDateFormat("d MMM yyyy");
                                String orderDate = targetDateFormat.format(orders.getOrderDate());
                            %>    
                            <td><%= orderDate%></td>

                            <% if (orders.getOrderStatus().equals("Packaging")) {%>
                            <td class="text-danger"><%= orders.getOrderStatus()%></td>

                            <% } else if (orders.getOrderStatus().equals("Shipping")) {%>
                            <td class="text-warning"><%= orders.getOrderStatus()%></td>

                            <% } else if (orders.getOrderStatus().equals("Delivered")) {%>
                            <td class="text-success"><%= orders.getOrderStatus()%></td>

                            <% } %>
                        </tr>
                        <% }%>    
                    </tbody>
                </table>
            </div>
        </div>
    </body>
    <!-- Include Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.2.3/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


    <%@ include file="footer.jsp" %>
</html>
