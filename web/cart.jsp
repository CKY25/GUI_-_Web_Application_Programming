<%@page import="dao.ItemDao"%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="model.*"%>
<%@page import="controller.*"%>
<%@include file="UserNavBar.jsp"%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setDateHeader("Expires", 0); // Proxies.
%>
<!-- retrieve session object. cart-list -->
<%
    DecimalFormat df = new DecimalFormat("#.##");
    request.setAttribute("df", df);
    List<CartItem> cartItemList = (List<CartItem>) session.getAttribute("cartItemList");
    List<CartItem> cartProduct = null;
    // set attribute "itemList" to value "initial"
//    if(itemList == null)
//        request.setAttribute("itemList", cartProduct);
    double total = 0;
    String formattedTotal = String.format("%.2f", total);
    if (cartItemList != null) {
        ItemDao pDao = new ItemDao();
        cartProduct = pDao.getCartProducts(cartItemList);
        total = pDao.getTotalCartPrice(cartItemList);
        //double cartTotal = Double.parseDouble((total > 0) ? (new java.text.DecimalFormat("0.00")).format(total) : "0.00");
        formattedTotal = String.format("%.2f", total);
        System.out.print("FORMAT=" + formattedTotal);

        request.setAttribute("cartItemList", cartItemList);
        //CartItem cart = new CartItem();
    }
    request.setAttribute("total", total);
    request.setAttribute("formattedTotal", formattedTotal);
%>
<%
    ItemDao pDao = new ItemDao();
    String Shipping = "RM 25";
    if (total >= 200) {
        Shipping = "FREE";
    } else if (total == 0) {
        Shipping = "0";
    }
    request.setAttribute("Shipping", Shipping);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Shopping Cart</title>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="src/css/checkout.css"/>
    </head>
    <body>
        <div class="container mt-5" style="min-height: 650px">
            <h1 class="text-center mb-5">Shopping Cart</h1>

            <table class="table">
                <thead class="table-dark">
                    <tr>
                        <th>Product</th>
                        <th class="text-center">Quantity</th>
                        <th style="text-align: right;">Subtotal</th>
                        <th></th>
                    </tr>
                </thead>

                <tbody>
                    <% if (cartItemList == null) { %>
                    <tr><td><h5>There's nothing in your cart yet.</h5></td></tr>
                    <% } %>

                    <% if (cartItemList != null) { %>
                    <% for (CartItem item : cartProduct) {%>
                    <%-- Iterate over cart items and display information --%>

                    <tr>
                        <td><div style="display: flex; flex-wrap: wrap;">
                                <img src="<%= item.getItemimage()%>" height="100" width="150"/>
                                <div>  
                                    <br><span class="fw-bold text-dark fs-5"><%= item.getItemname()%><br></span>

                                    <small><%String formattedPrice = String.format("%.2f", item.getItemprice());%>
                                        Price: RM<%= formattedPrice%></small>
                                </div>
                            </div>
                        </td>

                        <td class="text-left" width='150px'><br>							
                            <div class="form-group d-flex justify-content-between">
                                <a class="btn bnt-sm btn-incre" href="quantity-inc-dec?action=inc&id=<%=item.getItemid()%>"><i class="fas fa-plus-square"></i></a> 
                                <input type="text" name="quantity" class="form-control"  value="<%=item.getItemqty()%>" readonly> 
                                <a class="btn btn-decre" href="quantity-inc-dec?action=dec&id=<%=item.getItemid()%>"><i class="fas fa-minus-square"></i></a>
                            </div></td>

                        <td style="text-align: right;"><br><%String formattedSubtotal = String.format("%.2f", item.getItemSubtotal());%>
                            RM<%= formattedSubtotal%></td>

                        <td style="text-align: center;"><br><a href='#' data-toggle="modal" data-target="#confirmModal" class="btn btn-danger btn-sm">x</a></td>
                        <!--                        <
                        <!-- Confirm Modal -->
                <div class="modal fade" id="confirmModal" tabindex="-1" role="dialog" aria-labelledby="confirmModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="confirmModalLabel">Confirmation</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                Are you sure you want to remove this item?
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                                <a href="RemoveFromCartServlet?id=<%=item.getItemid()%>" class="btn btn-danger">Remove</a>
                            </div>
                        </div>
                    </div>
                </div>
                </tr>
                <% }%>
                <% }%>
                </tbody>

                <tfoot>
                    <tr>
                        <td colspan="3" class="text-end">Shipping Fee :<br>(RM200 or above, free delivery charge)</td>
                        <td>${Shipping}</td>

                    </tr>
                    <tr>
                        <td colspan="3" class="text-end">Total:</td>
                        <td>RM${formattedTotal}</td>
                    </tr>
                </tfoot>
            </table>

            <div>
                <h5 id='errMsg'>You do not have any items in your cart yet!</h5>
            </div>

            <div class="text-center">
                <a href="ViewItem" class="btn btn-outline-dark shadow-0 me-1">Continue Shopping</a>
                <% if (cartItemList != null) { %>
                <div id="checkoutModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="exampleModalLiveLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title text-center" id="exampleModalLiveLabel">Confirmation</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <p>Confirm to Check Out?</p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">No</button>
                                <a href="checkout.jsp" class="btn btn-primary">Yes</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!--                <div class="bd-example">-->
                <button type="button" class="btn btn-outline-success shadow-0" data-toggle="modal" data-target="#checkoutModal">
                    Checkout 
                </button>
                <% } else { %>
                <a class="btn btn-outline-success shadow-0" onclick='showError()'>Checkout</a>
                <% }%>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                    function showError() {
                        document.getElementById("errMsg").classList.add("active");
                    }
        </script>    
    </body>
    <%@include file="footer.jsp" %>
</html>