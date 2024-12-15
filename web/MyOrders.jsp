<%-- 
    Document   : MyPurchase
    Created on : May 1, 2023, 8:16:28 PM
    Author     : User
--%>

<%@page import="model.Loginuser"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="model.Item"%>
<%@page import="model.Orders"%>
<%@page import="java.util.List"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="javax.persistence.TypedQuery"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setDateHeader("Expires", 0); // Proxies.
%>
<!DOCTYPE html>
<html>
    <header>
        <meta charset="utf-8" />
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
        <title>My Orders</title>

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


        <%@ include file="UserNavBar.jsp" %>

    </header>
    <body>
        <div class="container my-2" id="myOrders" style="min-height: 650px">
            <h1 class="text-center ">My Orders</h1>
            <div class="pb-5">
                <%
                    EntityManagerFactory emf = Persistence.createEntityManagerFactory("Assignment1PU"); // change to Assignment1PU
                    EntityManager em = emf.createEntityManager();

                    List<Loginuser> cust = (List) session.getAttribute("custList");

                    String custName = cust.get(0).getUsername();

                    TypedQuery<Loginuser> customerQuery = em.createNamedQuery("Loginuser.findByUsername", Loginuser.class).setParameter("username", custName);
                    Loginuser loginuser = customerQuery.getSingleResult();

                    TypedQuery<Orders> orderQuery = em.createNamedQuery("Orders.findByUserId", Orders.class).setParameter("userid", loginuser.getUserid());
                    List<Orders> orderList = orderQuery.getResultList();

                    if (!orderList.isEmpty()) {
                        for (Orders orders : orderList) {%>
                <div class="shadow-lg bg-body rounded-5 p-3 mx-5 my-5">
                    <div class="row order-details p-2">

                        <% TypedQuery<Item> itemQuery = em.createNamedQuery("Item.findByItemname", Item.class).setParameter("itemname", orders.getItem().getItemname());// change this to ur item entity
                            List<Item> itemList = itemQuery.getResultList();

                            for (Item item : itemList) {%>
                        <div class="col-3"> 
                            <img class="rounded d-block mx-auto"  src="<%= item.getItemimage()%>" height="200" width="250" /> 
                        </div>
                        <div class="col-4">
                            <div class="row">
                                <div class="col-12">
                                    <h3><%= item.getItemname()%></h3>  
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-6">
                                    <p class="fw-bold">RM<%= String.format("%.2f", item.getItemprice())%></p>
                                </div>    
                                <% }%>
                                <div class="col-6">
                                    <p class="fw-bold float-end">Qty:   <%= orders.getQuantity()%></p>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-12">
                                    <p class="py-4"></p>
                                </div>  
                            </div>
                            <%
                                double subtotal = orders.getItem().getItemprice() * orders.getQuantity();
                            %>
                            <div class="row">
                                <div class="col-12">
                                    <p class="m-0 pt-3 float-end">Total (<%= orders.getQuantity()%> item): <span class="fw-bold">RM<%= String.format("%.2f", subtotal)%></span></p>
                                </div>
                            </div>
                        </div>  
                        <%
                            DateFormat targetDateFormat = new SimpleDateFormat("d MMM yyyy");
                            String orderDate = targetDateFormat.format(orders.getOrderDate());
                        %>      
                        <div class="col-5 border-start">    
                            <p class="fw-bold m-0">Order Id: <span class="float-end"><%= orders.getOrderId()%></span></p>
                            <p class="text-secondary m-0">Payment Method: <span class="float-end"><%= orders.getPaymentMethod()%></span></p>
                            <p class="text-secondary m-0">Order Placed On: <span class="float-end"><%= orderDate%></span></p>
                            <p></p>
                            <p class="text-secondary m-0">Subtotal: <span class="float-end">RM<%= String.format("%.2f", subtotal)%></span></p>
                            <% if (subtotal >= 200) {%>
                            <p class="text-secondary m-0">Shipping Fee: <span class="float-end">RM0</span></p>
                            <%double total = subtotal;%>
                            <p class="fw-bold m-0">Total: <span class="float-end">RM<%= String.format("%.2f", total)%></span></p>
                            <%} else {%>
                            <p class="text-secondary m-0">Shipping Fee: <span class="float-end">RM25.00</span></p>
                            <%double total = subtotal + 25;%>
                            <p class="fw-bold m-0">Total: <span class="float-end">RM<%= String.format("%.2f", total)%></span></p>
                            <% }%>

                        </div>
                    </div>
                    <hr>
                    <div class="">  
                        <h4 class="text-center py-2">Order Status</h4>
                        <% if (orders.getOrderStatus().equals("Packaging")) {%>
                        <div class="progress pl-5" style="width: 100%;">
                            <div class="progress-bar bg-secondary progress-bar-striped progress-bar-animated" role="progressbar" aria-label="Animated striped example" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 28%"></div>
                        </div>
                        <% } else if (orders.getOrderStatus().equals("Shipping")) {%>
                        <div class="progress pl-5" style="width: 100%;">
                            <div class="progress-bar bg-secondary progress-bar-striped progress-bar-animated" role="progressbar" aria-label="Animated striped example" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 54%"></div>
                        </div>
                        <% } else if (orders.getOrderStatus().equals("Delivered")) {%>
                        <div class="progress pl-5" style="width: 100%;">
                            <div class="progress-bar bg-secondary progress-bar-striped progress-bar-animated" role="progressbar" aria-label="Animated striped example" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 80%"></div>
                        </div>
                        <% } %>
                        <div class="progress-icon row">
                            <div class="col-3"> 
                                <p></p>
                            </div>
                            <div class="col-3">
                                <i class="fa-solid fa-box fa-xl px-3  py-3"></i><br>
                                <p class="fw-bold">Packaging</p>
                            </div>
                            <div class="col-3">
                                <i class="fa-solid fa-truck-fast fa-xl px-3  py-3"></i><br>     
                                <p class="fw-bold">Shipping</p>
                            </div>
                            <div class="col-3">
                                <i class="fa-solid fa-truck-ramp-box fa-xl px-3  py-3"></i><br>
                                <p class="fw-bold">Delivered</p>
                            </div>
                        </div>
                    </div>
                </div>
                <%}%>
                <%} else {%>
                <div class="container my-5 py-5">
                    <div class="my-5 py-5">
                        <h1 class="text-secondary text-center">No Order Found</h1>
                    </div>
                </div>
                <% }%>
            </div>
        </div>
    </div>



</body> 
<!-- Include Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.2.3/js/bootstrap.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>

<%@ include file="footer.jsp" %>
</html>
