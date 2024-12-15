<%-- 
    Document   : manageItem
    Created on : Apr 29, 2023, 5:19:21 PM
    Author     : User
--%>

<%@page import="model.Staff"%>
<%@page import="model.Loginuser"%>
<%@page import="model.Item"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Loginuser> c = (List) session.getAttribute("custList");
    List<Loginuser> s = (List) session.getAttribute("staffList");
%>
<%@include file="AdminStaffNavBar.jsp"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
        <title>Manage Item</title>

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
        <link rel="stylesheet" href="./src/css/itemstyle.css"/>
    </head>


    <body>
        <div id="blur">
            <!-- Heading -->
            <div class="bg-primary mb-4" style="background-color: #3e3e3e !important">
                <div class="container py-4">
                    <h3 class="text-white mt-2">Manage Items</h3>
                </div>
            </div>

            <!-- Heading -->
        </header>

        <% String userStatus = (String) session.getAttribute("isManager"); %>
        <!-- sidebar + content -->
        <section class="" id="blur">
            <div class="itemTable">
                <table class="table table-striped" style="width: 80%; border-collapse: collapse">
                    <thead class="table-dark">
                        <tr>
                            <th>Item ID</th>
                            <th>Item Name</th>
                            <th>Item Price</th>
                            <th>Item Stock</th> 
                            <th>Item Sold Quantity</th>
                            <th>Item Description</th>
                            <th>Item Image</th>
                            <% if(userStatus.equals("manager")) { %>
                            <th>Manage Item</th>
                            <% } %>
                        </tr>
                    </thead>


                    <%
                        List<Item> itemList = (List) session.getAttribute("itemList");
                    %>
                    <tbody class="table-group-divider">
                        <% for (Item item : itemList) {%>
                        <tr>
                            <td id="<%= item.getItemid()%>"><%= item.getItemid()%></td>
                            <td id="<%= item.getItemname()%>"><%= item.getItemname()%></td>
                            <td id="<%= item.getItemprice()%>"><%= item.getItemprice()%>0</td>
                            <td id="<%= item.getItemstock()%>"><%= item.getItemstock()%></td>
                            <td id="<%= item.getItemsoldqty()%>"><%= item.getItemsoldqty()%></td>
                            <td id="<%= item.getItemdesc()%>"><%= item.getItemdesc()%></td>
                            <td style=""><img src="<%=item.getItemimage()%>" height="200" width="300"></td>
                            <% if(userStatus.equals("manager")) { %>
                            <td>
                                <button class="btn-u" id="btn-u<%=item.getItemid()%>" style="margin-top: 40px" onclick="togglePopupUpdate(<%=item.getItemid()%>)" data-name="<%=item.getItemname()%>" data-price="<%=item.getItemprice()%>" data-stock="<%=item.getItemstock()%>" data-soldqty="<%=item.getItemsoldqty()%>" data-desc="<%=item.getItemdesc()%>" data-img="<%=item.getItemimage()%>"><i class="fa-solid fa-pen-to-square fa-xl"></i><br/>Edit</button>
                                <br/><br/>
                                <button class="btn-d" id="btn-d<%=item.getItemid()%>" onclick="togglePopupDelete(<%=item.getItemid()%>)"data-name="<%=item.getItemname()%>" data-price="<%=item.getItemprice()%>" data-stock="<%=item.getItemstock()%>" data-soldqty="<%=item.getItemsoldqty()%>" data-desc="<%=item.getItemdesc()%>" data-img="<%=item.getItemimage()%>"><i class="fa-solid fa-trash fa-xl"></i>Delete</button>
                            </td>
                            <% } %>
                        </tr>    
                        <% }%>
                    </tbody>
                </table>
            </div>


            <div class="buttondiv">
                <button class="additembtn" onclick="togglePopupAdd()"><i class="fa-solid fa-plus"></i>&nbsp;&nbsp;Add New Item</button>
                <button class="refreshbtn" onclick="location.href = 'AddItem'"><i class="fa-solid fa-arrows-rotate fa-spin"></i>&nbsp;&nbsp;Refresh Table</button>
            </div>
        </section>
        <!-- sidebar + content -->

        <%@include file="footer.jsp" %>
    </div>

    <div class="form-additem" id="popupAdd">
        <form method="post" id="addform" action="AddItem">
            <h3 style="text-align: center; padding: 20px">Add New Item</h3>
            <label for="itemid">Item ID: </label>
            <input type="text" id="itemid" name="itemid" required>
            <p id="errId">Item ID already exist!</p>
            <label for="itemname">Item name: </label>
            <input type="text" id="itemname" name="itemname" required><br/><br/>
            <label for="itemprice">Price: </label>
            <input type="text" id="itemprice" name="itemprice" required><br/><br/>
            <label for="itemstock">Stock: </label>
            <input type="text" id="itemstock" name="itemstock" required><br/><br/>
            <label for="itemsoldqty">Sold Quantity: </label>
            <input type="text" id="itemsoldqty" name="itemsoldqty" required><br/><br/>
            <label for="itemimage">Select Image: </label>
            <input type="file" id="itemimage" name="itemimage" accept="image/*" required><br/><br/>
            <label for="itemdesc">Description: </label>
            <input type="text" id="itemdesc" name="itemdesc" required><br/><br/>
            <p id="errFieldsAdd">Please fill in all the fields with correct formats!</p>
            <input type="submit" value="Submit">
            <input type="reset" value="Close" onclick="togglePopupAdd()">
        </form>
    </div>   

    <div class="form-updateitem" id="popupUpdate">
        <form method="post" id="updateform" action="UpdateItem">
            <h3 style="text-align: center; padding: 20px">Update Item</h3>
            <label for="itemid">Item ID: </label>
            <input type="text" id="itemidupdate" name="itemid" readonly><br/><br/>
            <label for="itemname">Item name: </label>
            <input type="text" id="itemnameupdate" name="itemname"><br/><br/>
            <label for="itemprice">Price: </label>
            <input type="text" id="itempriceupdate" name="itemprice"><br/><br/>
            <label for="itemstock">Stock: </label>
            <input type="text" id="itemstockupdate" name="itemstock"><br/><br/>
            <label for="itemsoldqty">Sold Quantity: </label>
            <input type="text" id="itemsoldqtyupdate" name="itemsoldqty"><br/><br/>
            <label for="itemimage">Select Image: </label>
            <input type="file" id="itemimageupdate" name="itemimage" accept="image/*" required><br/><br/>
            <label for="itemdesc">Description: </label>
            <input type="text" id="itemdescupdate" name="itemdesc"><br/><br/>
            <p id="errFieldsUpdate">Please fill in all the fields with correct formats!</p>
            <input type="submit" value="Submit">
            <input type="reset" value="Close" onclick="togglePopupUpdate()">
        </form>
    </div>

    <div class="form-deleteitem" id="popupDelete">
        <form method="post" id="deleteform" action="DeleteItem">
            <h3 style="text-align: center; padding: 20px">Delete Item</h3>
            <label for="itemid">Item ID: </label>
            <input type="text" id="itemiddelete" name="itemid" readonly><br/><br/>
            <label for="itemname">Item name: </label>
            <input type="text" id="itemnamedelete" name="itemname" readonly disabled><br/><br/>
            <label for="itemprice">Price: </label>
            <input type="text" id="itempricedelete" name="itemprice" readonly disabled><br/><br/>
            <label for="itemstock">Stock: </label>
            <input type="text" id="itemstockdelete" name="itemstock" readonly disabled><br/><br/>
            <label for="itemsoldqty">Sold Quantity: </label>
            <input type="text" id="itemsoldqtydelete" name="itemsoldqty" readonly disabled><br/><br/>
            <label for="itemimage">Select Image: </label>
            <input type="file" id="itemimagedelete" name="itemimage" accept="image/*" readonly disabled><br/><br/>
            <label for="itemdesc">Description: </label>
            <input type="text" id="itemdescdelete" name="itemdesc" readonly disabled><br/><br/>
            <input type="button" onclick="deleteItem()" value="Submit">
            <input type="reset" value="Close" onclick="togglePopupDelete()">
        </form>
    </div>

    <div class="form-additem" id="popupSuccessAdd">
        <img src="http://www.atlantisresort-bg.com/wp-content/uploads/2019/05/animated-check-mark.gif" width="200" height="200" style="border-radius: 200px;"/>
        <h1>Item added to database successfully</h1>
        <input type="submit" value="OK" onclick="location.href = 'AddItem'">
    </div> 

    <div class="form-updateitem" id="popupSuccessUpdate">
        <img src="http://www.atlantisresort-bg.com/wp-content/uploads/2019/05/animated-check-mark.gif" width="200" height="200" style="border-radius: 200px;"/>
        <h1>Item updated successfully</h1>
        <input type="submit" value="OK" onclick="location.href = 'AddItem'">
    </div> 

    <div class="form-deleteitem" id="popupSuccessDelete">
        <img src="http://www.atlantisresort-bg.com/wp-content/uploads/2019/05/animated-check-mark.gif" width="200" height="200" style="border-radius: 200px;"/>
        <h1>Item deleted successfully</h1>
        <input type="submit" value="OK" onclick="location.href = 'AddItem'">
    </div> 

    <!-- MDB -->
    <!-- Include Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.2.3/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>
    <script>
            let popupAdd = document.getElementById("popupAdd");
            let popupUpdate = document.getElementById("popupUpdate");
            let popupDelete = document.getElementById("popupDelete");
            let blur = document.getElementById("blur");
            let popupSuccessAdd = document.getElementById("popupSuccessAdd");
            let popupSuccessUpdate = document.getElementById("popupSuccessUpdate");
            let popupSuccessDelete = document.getElementById("popupSuccessDelete");
            function togglePopupAdd() {
                document.getElementById("errFieldsAdd").classList.remove("active");
                blur.classList.toggle("active");
                popupAdd.classList.toggle("active");
            }

            function toggleSuccessAdd() {
                popupAdd.classList.toggle("active");
                popupSuccessAdd.classList.toggle("active");
            }

            function toggleCloseSuccessAdd() {
                blur.classList.toggle("active");
                popupSuccessAdd.classList.toggle("active");
            }

            function togglePopupUpdate(id) {
                document.getElementById("errFieldsUpdate").classList.remove("active");
                blur.classList.toggle("active");
                popupUpdate.classList.toggle("active");
                let btn = document.getElementById("btn-u" + id);
                document.getElementById("itemidupdate").value = id;
                document.getElementById("itemnameupdate").value = btn.getAttribute("data-name");
                document.getElementById("itempriceupdate").value = btn.getAttribute("data-price");
                document.getElementById("itemstockupdate").value = btn.getAttribute("data-stock");
                document.getElementById("itemsoldqtyupdate").value = btn.getAttribute("data-soldqty");
                document.getElementById("itemimageupdate").src = btn.getAttribute("data-img");
                document.getElementById("itemdescupdate").value = btn.getAttribute("data-desc");
            }

            function toggleSuccessUpdate() {
                popupUpdate.classList.toggle("active");
                popupSuccessUpdate.classList.toggle("active");
            }

            function toggleCloseSuccessUpdate() {
                blur.classList.toggle("active");
                popupSuccessUpdate.classList.toggle("active");
            }

            function togglePopupDelete(id) {
                blur.classList.toggle("active");
                popupDelete.classList.toggle("active");
                let btn = document.getElementById("btn-d" + id);
                document.getElementById("itemiddelete").value = id;
                document.getElementById("itemnamedelete").value = btn.getAttribute("data-name");
                document.getElementById("itempricedelete").value = btn.getAttribute("data-price");
                document.getElementById("itemstockdelete").value = btn.getAttribute("data-stock");
                document.getElementById("itemsoldqtydelete").value = btn.getAttribute("data-soldqty");
                document.getElementById("itemimagedelete").src = btn.getAttribute("data-img");
                document.getElementById("itemdescdelete").value = btn.getAttribute("data-desc");
            }

            function deleteItem() {
                if (window.confirm("Are you sure you want to delete this item?")) {
                    document.getElementById("deleteform").submit();
                } else {
                    blur.classList.toggle("active");
                    popupDelete.classList.toggle("active");
                }
            }

            function toggleSuccessDelete() {
                popupDelete.classList.toggle("active");
                popupSuccessDelete.classList.toggle("active");
            }

            function toggleCloseSuccessDelete() {
                blur.classList.toggle("active");
                popupSuccessDelete.classList.toggle("active");
            }
    </script>
</body>
</html>
