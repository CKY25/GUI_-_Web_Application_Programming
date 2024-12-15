<%-- 
    Document   : DisplayItem
    Created on : Apr 29, 2023, 5:05:24 PM
    Author     : User
--%>

<%@page import="model.*"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    List<Loginuser> c = (List) session.getAttribute("custList");
    List<Loginuser> s = (List) session.getAttribute("staffList");
    boolean admin;
%>
<% if(s != null) { %>
<%@include file="AdminStaffNavBar.jsp"%> 
<% admin = true; %>
<% } else if(c != null){ %>
<%@include file="UserNavBar.jsp"%>
<% admin = false; %>
<% } else{ %>
<%@include file="GuestNavBar.jsp"%>
<% admin = false; %>
<% } %>

<%
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setDateHeader("Expires", 0); // Proxies.
%>
<!DOCTYPE html>
<html>
    <head>
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
        <link rel="stylesheet" href="./src/css/itemstyle.css"/>
    </head>
    <body>
        <div id="blur">

                <!-- Heading -->
                <div class="bg-primary mb-4" style="background-color: #3e3e3e !important">
                    <div class="container py-4">
                        <h3 class="text-white mt-2">Shoes</h3>
                    </div>
                </div>
                <!-- Heading -->

            <!-- sidebar + content -->
            <section class="" id="itemSection">
                <div class="container">
                    <div class="row">
                        <!-- sidebar -->
                        <div class="col-lg-3">
                            <!-- Toggle button -->
                            <button
                                class="btn btn-outline-secondary mb-3 w-100 d-lg-none"
                                type="button"
                                data-mdb-toggle="collapse"
                                data-mdb-target="#navbarSupportedContent"
                                aria-controls="navbarSupportedContent"
                                aria-expanded="false"
                                aria-label="Toggle navigation"
                                >
                                <span>Show filter</span>
                            </button>
                            <!-- Collapsible wrapper -->
                            <div class="collapse card d-lg-block mb-5" id="navbarSupportedContent">
                                <div class="accordion" id="accordionPanelsStayOpenExample">
                                    <div class="accordion-item">
                                        <h2 class="accordion-header" id="headingThree">
                                            <button
                                                class="accordion-button text-dark bg-light"
                                                type="button"
                                                data-mdb-toggle="collapse"
                                                data-mdb-target="#panelsStayOpen-collapseThree"
                                                aria-expanded="false"
                                                aria-controls="panelsStayOpen-collapseThree"
                                                >
                                                Price
                                            </button>
                                        </h2>
                                        <div id="panelsStayOpen-collapseThree" class="accordion-collapse collapse show" aria-labelledby="headingThree">
                                            <div class="accordion-body">
                                                <form action="SearchPrice" method="post">
                                                    <div class="row mb-3">
                                                        <div class="col-6">
                                                            <p class="mb-0">
                                                                Min
                                                            </p>
                                                            <div class="form-outline">
                                                                <input type="number" id="typeNumber" class="form-control" name="minprice" min="0" required/>
                                                                <label class="form-label" id="min" for="typeNumber">RM0</label>
                                                            </div>
                                                        </div>
                                                        <div class="col-6">
                                                            <p class="mb-0">
                                                                Max
                                                            </p>
                                                            <div class="form-outline">
                                                                <input type="number" id="typeNumber" class="form-control" name="maxprice" max="1000" required/>
                                                                <label class="form-label" id="max" for="typeNumber">RM1,000</label>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <button type="submit" class="btn btn-white w-100 border border-secondary" id="applybtn">apply</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- sidebar -->
                        <!-- content -->
                        <div class="col-lg-9">
                            <%
                                List<Item> itemList = (List) session.getAttribute("itemList");
                            %>
                            <div class="row">
                                <% for (Item item : itemList) {%>
                                <div class="col-lg-4 col-md-6 col-sm-6 d-flex" id="dispitem" style="min-height: 500px">
                                    <div class="card w-100 my-2 shadow-2-strong">

                                        <img id="dataimage<%=item.getItemid()%>" src="<%=item.getItemimage()%>" class="card-img-top" height="200" width="300" onclick="showItem(<%=item.getItemid()%>)" data-image="<%=item.getItemimage()%>"/>

                                        <div class="card-body d-flex flex-column">
                                            <h3 id="dataname<%=item.getItemid()%>" class="mb-1 me-1" data-name="<%=item.getItemname()%>"><%= item.getItemname()%></h3>
                                            <div class="d-flex flex-row">
                                                <h5 id="dataprice<%=item.getItemid()%>" class="mb-1 me-1" data-price="<%=item.getItemprice()%>">RM<%= item.getItemprice()%>0</h5>
                                            </div>
                                            <p id="datadesc<%=item.getItemid()%>" class="card-text" data-desc="<%=item.getItemdesc()%>"><%= item.getItemdesc()%></h5>
                                            <p id="datastock<%=item.getItemid()%>" class="card-text" data-stock="<%=item.getItemstock()%>">Stock left: <%= item.getItemstock()%></p>
                                            <% if(!admin) {%>
                                            <div class="card-footer d-flex align-items-end pt-3 px-0 pb-0 mt-auto">
                                                <a class="btn btn-primary shadow-0 me-1" href="CartServlet?id=<%=item.getItemid()%>">Add to cart</a>
                                            </div>
                                            <% } %>
                                        </div>
                                    </div>
                                </div>
                                <% }%>
                            </div>
                            <hr />
                        </div>
                    </div>
                </div>            
            </section>
            <!-- sidebar + content -->
        </div>

        <!--popup item-->                    
        <div class="popupItem" id="popupItem" style="border-radius: 40px;">
            <div>
                <button id="closebtn" onclick="closeItem()"><i class="fa-solid fa-xmark"></i></button>
            </div>

            <div id="pName">
                <h1 id="popupitemname"></h1><br/>
            </div>

            <div id="pPrice">
                <h1 id="popupitemprice"></h1><br/>
            </div>

            <div id="pStock">
                <h3 id="popupitemstock"></h3><br/>
            </div>

            <div id="pDesc">
                <h5 id="popupitemdesc"></h5><br/>
            </div>   

            <div id="pImage">
                <img id="popupitemimage" src="src" width="400px" height="300px" style="border-radius: 20px"/>
                <h1 id="test"></h1>
            </div>
        </div> 

        <!-- MDB -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.2.3/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>
        <script>
                    let popupItem = document.getElementById("popupItem");
                    let popupName = document.getElementById("pName");
                    let popupPrice = document.getElementById("pPrice");
                    let popupStock = document.getElementById("pStock");
                    let popupDesc = document.getElementById("pDesc");
                    let popupImage = document.getElementById("pimage");
                    let blur = document.getElementById("blur");
                    function showItem(itemid) {
                        blur.classList.toggle("active");
                        popupItem.classList.toggle("active");

                        let dataname = document.getElementById("dataname" + itemid);
                        let p1 = document.getElementById("popupitemname");
                        p1.textContent = dataname.getAttribute("data-name");
                        popupName.appendChild(p1);
                        let dataprice = document.getElementById("dataprice" + itemid);
                        let p2 = document.getElementById("popupitemprice");
                        p2.textContent = "RM" + dataprice.getAttribute("data-price") + "0";
                        popupPrice.appendChild(p2);
                        let datastock = document.getElementById("datastock" + itemid);
                        let p3 = document.getElementById("popupitemstock");
                        p3.textContent = "Stock Left: " + datastock.getAttribute("data-stock");
                        popupStock.appendChild(p3);
                        let datadesc = document.getElementById("datadesc" + itemid);
                        let p4 = document.getElementById("popupitemdesc");
                        p4.textContent = datadesc.getAttribute("data-desc");
                        popupDesc.appendChild(p4);
                        let dataimg = document.getElementById("dataimage" + itemid);
                        let img = document.getElementById("popupitemimage");
                        img.setAttribute("src", dataimg.getAttribute("data-image"));
                        img.setAttribute("alt", dataimg.getAttribute("data-image"));
                        popupImage.appendChild(img);
                    }

                    function closeItem() {
                        popupItem.classList.toggle("active");
                        blur.classList.toggle("active");
                    }
        </script>
    </body>
    
    <%@include file="footer.jsp" %>
</html>