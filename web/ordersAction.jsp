<%-- 
    Document   : index
    Created on : Apr 19, 2023, 6:26:36 PM
    Author     : User
--%>

<%@page import="model.Staff"%>
<%@page import="model.Loginuser"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="model.Item"%>
<%@page import="java.util.List"%>
<%@page import="model.Orders"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
            <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
            <title>Orders Table</title>

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
    </head>
    
    <body>

        <%
            List<Orders> orderList = (List) session.getAttribute("orderList");
            Loginuser loginuser = new Loginuser();
            Item item = new Item();
        %>

        <div class="container-fluid mb-3" style="min-height: 650px">
            <h1>Order History Table</h1>     
            <div class="btn-action float-end mb-2">
                <button type="button" class="btn btn-success mx-1"  data-bs-toggle="modal" data-bs-target="#InsertOrder">Insert</button>
                <button type="button" class="btn btn-warning mx-1" data-bs-toggle="modal" data-bs-target="#UpdateOrder">Update</button>
                <button type="button" class="btn btn-danger mx-1" data-bs-toggle="modal" data-bs-target="#DeleteOrder">Delete</button>
            </div>

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

        <!-- Insert Modal -->
        <div class="modal fade" id="InsertOrder" tabindex="-1" aria-labelledby="InsertOrderLabel" aria-hidden="true">
            <div class="modal-dialog  modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="InsertOrderLabel">Insert Order</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="InsertForm" method="post" action="AddOrder">
                            <label for="customerName">Customer Name:</label></br>
                            <input type="text" id="customerName" name="customerName" required><br>
                            <p id="customerNameError" class="text-danger py-0 m-0 d-none">Customer name should not contain numbers</p><br>
                            <label for="iName">Item Name:</label></br>
                            <input type="text" id="itemName" name="iName" required><br><br>
                            <label for="qty">Quantity: </label></br>
                            <input type="number" id="qty" name="qty" required><br>
                            <p id="qtyError" class="text-danger py-0 m-0 d-none">Quantity should be greater than 0</p><br>
                            <label for="methodName">Payment Method: </label></br>
                            <select id="methodName" name="methodName" required>
                                <option value="COD">COD</option>
                                <option value="CIMB Bank">CIMB Bank</option>
                                <option value="Maybank">Maybank</option>
                                <option value="Credit Card">Credit Card</option>
                            </select></br></br>
                            <label for="orderStatus">Order Status:</label></br>
                            <select id="orderStatus" name="orderStatus" required>
                                <option value="Packaging">Packaging</option>
                                <option value="Shipping">Shipping</option>
                                <option value="Delivered">Delivered</option>
                            </select>
                            </br>
                            <input class="btn btn-success float-end" type="submit"  onclick="return validateInsertForm()" value="Insert">

                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Insert Modal -->

        <!-- Delete Modal -->
        <div class="modal fade" id="DeleteOrder" tabindex="-1" aria-labelledby="DeleteOrderLabel" aria-hidden="true">
            <div class="modal-dialog  modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="DeleteOrderLabel">Delete Order</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form method="post" action="DeleteOrder">
                            <label for="orderId">Order Id:</label></br>
                            <input type="text" id="orderId2" name="orderId"><br>
                            <p id="orderIdError2" class="text-danger py-0 m-0 d-none">Order ID should only contain numbers</p><br>
                            <input class="btn btn-danger float-end" onclick="return validateDeleteForm()" type="submit" value="Delete">
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Delete Modal -->

        <!-- Update Modal -->
        <div class="modal fade" id="UpdateOrder" tabindex="-1" aria-labelledby="UpdateOrderLabel" aria-hidden="true">
            <div class="modal-dialog  modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="UpdateOrderLabel">Update Order's Status</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">        
                        <form method="post" action="UpdateOrder" onsubmit="return validateForm()">
                            <label for="orderId">Order Id:</label></br>
                            <input type="text" id="orderId" name="orderId"><br>
                            <p id="orderIdError" class="text-danger py-0 m-0 d-none">Order ID should only contain numbers</p><br>
                            <label for="orderStatus">Order Status:</label></br>
                            <select id="orderStatus" name="orderStatus">
                                <option value="Packaging">Packaging</option>
                                <option value="Shipping">Shipping</option>
                                <option value="Delivered">Delivered</option>
                            </select>
                            </br></br>
                            <input class="btn btn-warning float-end" onclick="return validateUpdateForm()" type="submit" value="Update">
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Update Modal -->

        <!-- Success Insert Modal -->
        <div class="modal fade" id="SuccessInsOrder" tabindex="-1" role="dialog" aria-labelledby="SuccessInsOrderLabel" aria-hidden="true">
            <div class="modal-dialog  modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-body">
                        <img class="d-block mx-auto" src="./src/img/success.png" height="200" width="200" />
                        <h3 class="text-success text-center pt-3">Order Inserted Successfully</h3>
                    </div>
                    <div class="modal-footer justify-content-center">
                        <a class="btn btn-success" href="ViewOrder">Close</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- Success Insert Modal -->

        <!-- Unsuccess Insert Modal -->
        <div class="modal fade" id="UnsuccessInsOrder" tabindex="-1" role="dialog" aria-labelledby="UnsuccessInsOrder" aria-hidden="true">
            <div class="modal-dialog  modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-body">
                        <img class="d-block mx-auto" src="./src/img/error.png" height="200" width="200" />
                        <h3 class="text-danger text-center pt-3">Order Failed to Insert</h3>
                        <p class="text-danger text-center">(Due to customer name or item name does not exist)</p>
                    </div>
                    <div class="modal-footer justify-content-center">
                        <a class="btn btn-danger" href="ViewOrder">Close</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- Unsuccess Insert Modal -->

        <!-- Success Update Modal -->
        <div class="modal fade" id="SuccessUpdOrder" tabindex="-1" role="dialog" aria-labelledby="SuccessUpdOrderLabel" aria-hidden="true">
            <div class="modal-dialog  modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-body">
                        <img class="d-block mx-auto" src="./src/img/success.png" height="200" width="200" />
                        <h3 class="text-success text-center pt-3">Order Status Updated Successfully</h3>
                    </div>
                    <div class="modal-footer justify-content-center">
                        <a class="btn btn-success" href="ViewOrder">Close</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- Success Insert Modal -->

        <!-- Unsuccess Update Modal -->
        <div class="modal fade" id="UnsuccessUpdOrder" tabindex="-1" role="dialog" aria-labelledby="UnsuccessUpdOrderLabel" aria-hidden="true">
            <div class="modal-dialog  modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-body">
                        <img class="d-block mx-auto" src="./src/img/error.png" height="200" width="200" />
                        <h3 class="text-danger text-center pt-3">Order Status Failed to be Updated</h3>
                        <p class="text-danger text-center">(Due to Order ID does not exist)</p>
                    </div>
                    <div class="modal-footer justify-content-center">
                        <a class="btn btn-danger" href="ViewOrder">Close</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- Unsuccess Update Modal -->

        <!-- Success Delete Modal -->
        <div class="modal fade" id="SuccessDelOrder" tabindex="-1" role="dialog" aria-labelledby="SuccessDelOrderLabel" aria-hidden="true">
            <div class="modal-dialog  modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-body">
                        <img class="d-block mx-auto" src="./src/img/success.png" height="200" width="200" />
                        <h3 class="text-success text-center pt-3">Order Deleted Successfully</h3>
                    </div>
                    <div class="modal-footer justify-content-center">
                        <a class="btn btn-success" href="ViewOrder">Close</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- Success Delete Modal -->

        <!-- Unsuccess Delete Modal -->
        <div class="modal fade" id="UnsuccessDelOrder" tabindex="-1" role="dialog" aria-labelledby="UnsuccessDelOrderLabel" aria-hidden="true">
            <div class="modal-dialog  modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-body">
                        <img class="d-block mx-auto" src="./src/img/error.png" height="200" width="200" />
                        <h3 class="text-danger text-center pt-3">Order Failed to be Deleted</h3>
                        <p class="text-danger text-center">(Due to Order ID does not exist)</p>
                    </div>
                    <div class="modal-footer justify-content-center">
                        <a class="btn btn-danger" href="ViewOrder">Close</a>
                    </div>
                </div>
            </div>
        </div>
        <!-- Unsuccess Delete Modal -->
    </body>





    <!-- Include Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.2.3/js/bootstrap.min.js"></script>
    <script>
                                    function validateInsertForm() {
                                        var inputCust = document.getElementById("customerName");
                                        var custValue = inputCust.value;

                                        var inputQty = document.getElementById("qty");
                                        var qtyValue = inputQty.value;

                                        var strringRegex = /^[a-zA-Z\s]*$/;
                                        var custHidden = document.getElementById('customerNameError');
                                        var qtyHidden = document.getElementById('qtyError');

                                        if (!custValue.match(strringRegex)) {
                                            custHidden.classList.remove('d-none');
                                            return false;
                                        } else if (qtyValue <= 0) {
                                            qtyHidden.classList.remove('d-none');
                                            return false;
                                        } else {
                                            if (window.confirm("Are you sure you want to insert order?")) {
                                                return true;
                                            } else {
                                                return false;
                                            }
                                        }
                                    }

                                    function validateUpdateForm() {
                                        var inputId = document.getElementById("orderId");
                                        var IdValue = inputId.value;

                                        var numericRegex = /^[0-9]+$/;
                                        var idHidden = document.getElementById('orderIdError');

                                        if (!IdValue.match(numericRegex)) {
                                            idHidden.classList.remove('d-none');
                                            return false;
                                        } else {
                                            if (window.confirm("Are you sure you want to update order status?")) {
                                                return true;
                                            } else {
                                                return false;
                                            }
                                        }
                                    }

                                    function validateDeleteForm() {
                                        var inputId = document.getElementById("orderId2");
                                        var IdValue = inputId.value;

                                        var numericRegex = /^[0-9]+$/;
                                        var idHidden = document.getElementById('orderIdError2');

                                        if (!IdValue.match(numericRegex)) {
                                            idHidden.classList.remove('d-none');
                                            return false;
                                        } else {
                                            if (window.confirm("Are you sure you want to update order status?")) {
                                                return true;
                                            } else {
                                                return false;
                                            }
                                        }
                                    }
    </script>


    <%@ include file="footer.jsp" %>
</html>