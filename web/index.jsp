<%-- 
    Document   : index
    Created on : Apr 19, 2023, 6:26:36 PM
    Author     : User
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

<% if (custListtest != null) { %>
<% for (Loginuser user : custListtest) {%>

<%
    String userid = user.getUserid();
    String username = user.getUsername();
    session.setAttribute("userid", userid);
    session.setAttribute("username", username);
%>

<% }%>
<% }%>

<% if (staffListtest != null) { %>
<% for (Staff staff : staffListtest) {%>
<%
    String staffid = staff.getStaffid();
    session.setAttribute("staffid", staffid);
    session.setAttribute("manager", staff.getStaffstatus());
%>
<% }%>
<% }%>

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
    </head>

    <body>
        <!-- Jumbotron -->
        <div class="container-fluid banner">
            <div class="banner-content">
                <h1 clas="fw-bold">Nike Dunk Low Retro Black White Panda</h1>
                <p>The next Dunk 'Panda' restock scheduled is on April 28, 2023.</p>
                <div class="pt-3">
                    <a href="#!" class="btn btn-outline-light banner-button">Learn More</a>
                </div>
            </div>
        </div>
        <!-- Jumbotron -->
        <!-- Products -->
        <section>
            <div class="container my-5">
                <header class="mb-4 text-center">
                    <h1 class="arrivals-header">New Arrivals</h1>
                </header>

                <div class="row">
                    <div class="col-lg-3 col-md-6 col-sm-6 d-flex">
                        <div class="card w-100 my-2 shadow-2-strong">
                            <img src="./src/img/airjordan.png" class="card-img-top" style="aspect-ratio: 1 / 1" />
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title">Nike Dunk High Retro</h5>
                                <p class="card-text">RM490.00</p>

                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-6 d-flex">
                        <div class="card w-100 my-2 shadow-2-strong">
                            <img src="./src/img/newbalance.png" class="card-img-top" style="aspect-ratio: 1 / 1" />
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title">
                                    New Balance 2002R
                                </h5>
                                <p class="card-text">RM610.00</p>

                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-6 d-flex">
                        <div class="card w-100 my-2 shadow-2-strong">
                            <img src="./src/img/jordanair6.png" class="card-img-top" style="aspect-ratio: 1 / 1" />
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title">
                                    Jordan Air 6 Retro
                                </h5>
                                <p class="card-text">RM800.00</p>

                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-6 d-flex">
                        <div class="card w-100 my-2 shadow-2-strong">
                            <img src="./src/img/airmax.png" class="card-img-top" style="aspect-ratio: 1 / 1" />
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title">
                                    Nike Air Max Pulse
                                </h5>
                                <p class="card-text">RM669.00</p>

                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-6 d-flex">
                        <div class="card w-100 my-2 shadow-2-strong">
                            <img src="./src/img/newbalance2.png" class="card-img-top" style="aspect-ratio: 1 / 1" />
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title">
                                    New Balance 2002R
                                </h5>
                                <p class="card-text">RM610.00</p>

                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-6 d-flex">
                        <div class="card w-100 my-2 shadow-2-strong">
                            <img src="./src/img/jordanair.png" class="card-img-top" style="aspect-ratio: 1 / 1" />
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title">
                                    Jordan Air Legacy 312 Low
                                </h5>
                                <p class="card-text">RM600.00</p>

                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-6 d-flex">
                        <div class="card w-100 my-2 shadow-2-strong">
                            <img src="./src/img/airforce.png" class="card-img-top" style="aspect-ratio: 1 / 1" />
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title">Nike Air Force 1 '07 LV8</h5>
                                <p class="card-text">RM520.00</p>

                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 col-sm-6 d-flex">
                        <div class="card w-100 my-2 shadow-2-strong">
                            <img src="./src/img/adidas.png" class="card-img-top" style="aspect-ratio: 1 / 1" />
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title">
                                    Adidas Originals Superstar
                                </h5>
                                <p class="card-text">RM430.00</p>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <!-- Products -->

        <!-- Feature -->
        <section class="mt-5" style="background-color: #f5f5f5">
            <div class="container text-dark pt-3">
                <header class="pt-4 pb-3 text-center">
                    <h1 class="choose-header  pb-4">Why Choose Us</h1>
                </header>

                <div class="row mb-4">
                    <div class="col-lg-4 col-md-6">
                        <figure class="d-flex align-items-center mb-4">
                            <span class="rounded-circle bg-white p-3 d-flex me-2 mb-2">
                                <i class="fas fa-camera-retro fa-2x fa-fw text-dark floating"></i>
                            </span>
                            <figcaption class="info">
                                <h6 class="title fw-bolder">Reasonable prices</h6>
                                <p>
                                    Our prices are competitive and reasonable. We offer a wide range of high-quality sneakers at affordable prices.
                                </p>
                            </figcaption>
                        </figure>
                        <!-- itemside // -->
                    </div>
                    <!-- col // -->
                    <div class="col-lg-4 col-md-6">
                        <figure class="d-flex align-items-center mb-4">
                            <span class="rounded-circle bg-white p-3 d-flex me-2 mb-2">
                                <i class="fas fa-star fa-2x fa-fw text-dark floating"></i>
                            </span>
                            <figcaption class="info">
                                <h6 class="title fw-bolder">Best quality</h6>
                                <p>
                                    Our sneakers are made with the finest materials and expert craftsmanship, ensuring that they not only look great, but also last longer than any other sneakers on the market. 
                                </p>
                            </figcaption>
                        </figure>
                        <!-- itemside // -->
                    </div>
                    <div class="col-lg-4 col-md-6">
                        <figure class="d-flex align-items-center mb-4">
                            <span class="rounded-circle bg-white p-3 d-flex me-2 mb-2">
                                <i class="fas fa-users fa-2x fa-fw text-dark floating"></i>
                            </span>
                            <figcaption class="info">
                                <h6 class="title fw-bolder">Customer satisfaction</h6>
                                <p>
                                    Customer satisfaction is our top priority. We strive to provide the best possible shopping experience for our customers by offering a wide selection of high-quality sneakers at reasonable prices.
                                </p>
                            </figcaption>
                        </figure>
                        <!-- itemside // -->
                    </div>
                </div>
            </div>
            <!-- container end.// -->
        </section>
        <!-- Feature -->

        <!--Image and Gallery-->
        <div class="container-fluid d-none d-lg-block d-md-none" id="img-section">
            <h1 class="img-header text-center">Image & Gallery</h1>
            <div class="swiper">
                <div class="swiper-wrapper">
                    <div class="swiper-slide p-auto sec-prev">
                        <img src="./src/img/poster1.jpg" class="rounded-5 poster poster1">
                    </div>
                    <div class="swiper-slide p-auto prev">
                        <img src="./src/img/poster2.jpg" class="rounded-5 poster poster2">
                    </div>
                    <div class="swiper-slide p-auto selected">
                        <img src="./src/img/poster3.jpg" class="rounded-5 poster poster3">
                    </div>
                    <div class="swiper-slide p-auto next">
                        <img src="./src/img/poster4.jpg" class="rounded-5 poster poster4">
                    </div>
                    <div class="swiper-slide p-auto sec-next">
                        <img src="./src/img/poster5.jpg" class="rounded-5 poster poster5">
                    </div>
                </div>
                <div class="swiper-button-prev">
                    <i class="fa-solid fa-chevron-left"></i>
                </div>
                <div class="swiper-button-next">
                    <i class="fa-solid fa-chevron-right"></i>
                </div>
            </div>
        </div>
        <!--Image and Gallery-->
        <!-- Blog -->
        <section class="mt-2 mb-1" id="blog-section">
            <div class="container text-dark">
                <header class="mb-4 pt-4 text-center">
                    <h1 class="blog-header pb-4">Blog Posts</h1>
                    <div class="row">
                        <div class="col-lg-3 col-md-6 col-sm-6 col-12">
                            <article>
                                <a href="#" class="img-fluid">
                                    <img class="rounded w-100"
                                         src="https://i0.wp.com/justfreshkicks.com/wp-content/uploads/2023/01/jordans2023-1-scaled.jpg?resize=640%2C393&ssl=1"
                                         style="object-fit: cover" height="160" />
                                </a>
                                <div class="mt-2 text-muted small d-block mb-1">
                                    <span>
                                        <i class="fa fa-calendar-alt fa-sm"></i>
                                        20.4.2023
                                    </span>
                                    <a href="https://justfreshkicks.com/air-jordan-release-dates-2023/">
                                        <h6 class="text-dark">Top Air Jordan Sneaker Release for 2023</h6>
                                    </a>
                                    <p>2023 is officially here with an entire lineup of new Air Jordans we can look
                                        forward to.</p>
                                </div>
                            </article>
                        </div>
                        <!-- col.// -->
                        <div class="col-lg-3 col-md-6 col-sm-6 col-12">
                            <article>
                                <a href="#" class="img-fluid">
                                    <img class="rounded w-100"
                                         src="https://vegconom.de/vegconomistcom/wp-content/uploads/sites/3/Classic_Vegan_Rise_Milk_Makeup_Blanco_IG9802_03_standard.webp"
                                         style="object-fit: cover" height="160" />
                                </a>
                                <div class="mt-2 text-muted small d-block mb-1">
                                    <span>
                                        <i class="fa fa-calendar-alt fa-sm"></i>
                                        11.4.2023
                                    </span>
                                    <a
                                        href="https://vegconomist.com/fashion-design-and-beauty/shoes/reebok-milk-makeup-cruelty-free-footwear/">
                                        <h6 class="text-dark">Reebok & Milk Makeup Launch 100% Cruelty-Free Footwear
                                            Collection</h6>
                                    </a>
                                    <p>company Reebok and vegan cosmetics brand Milk Makeup have partnered to launch
                                        a new cruelty-free footwear collection made with 100% vegan materials and
                                        zero animal byproducts.</p>
                                </div>
                            </article>
                        </div>
                        <!-- col.// -->
                        <div class="col-lg-3 col-md-6 col-sm-6 col-12">
                            <article>
                                <a href="#" class="img-fluid">
                                    <img class="rounded w-100"
                                         src="https://images.lifestyleasia.com/wp-content/uploads/sites/5/2023/03/21032628/adidas-gucci-2023-1350x900.jpeg?tr=w-1600"
                                         style="object-fit: cover" height="160" />
                                </a>
                                <div class="mt-2 text-muted small d-block mb-1">
                                    <span>
                                        <i class="fa fa-calendar-alt fa-sm"></i>
                                        21.03.2023
                                    </span>
                                    <a href="https://malaysia.news.yahoo.com/adidas-x-gucci-second-drop-053000048.html">
                                        <h6 class="text-dark">Adidas x Gucci’s second drop this spring 2023 is every
                                            sneakerhead’s dream</h6>
                                    </a>
                                    <p>Adidas and Gucci are teaming up yet again to release a Spring/Summer 2023
                                        collection.</p>
                                </div>
                            </article>
                        </div>
                        <!-- col.// -->
                        <div class="col-lg-3 col-md-6 col-sm-6 col-12">
                            <article>
                                <a href="#" class="img-fluid">
                                    <img class="rounded w-100"
                                         src="https://stylecaster.com/wp-content/uploads/2022/10/Untitled-design.png"
                                         style="object-fit: cover" height="160" />
                                </a>
                                <div class="mt-2 text-muted  small d-block mb-1">
                                    <span>
                                        <i class="fa fa-calendar-alt fa-sm"></i>
                                        7.3.2023
                                    </span>
                                    <a href="https://stylecaster.com/sneaker-trends-2023/">
                                        <h6 class="text-dark">Sneaker Trends 2023</h6>
                                    </a>
                                    <p>10 Pairs Guaranteed To Up Your Street Style</p>
                                </div>
                            </article>
                        </div>
                    </div>
            </div>
        </section>
        <!-- Blog -->
        
        <!--No permission Modal -->
        <div class="modal fade" id="noPermission" tabindex="-1" role="dialog" aria-labelledby="noPermissionLabel" aria-hidden="true">
            <div class="modal-dialog  modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-body">
                        <img class="d-block mx-auto" src="./src/img/error.png" height="200" width="200" />
                        <h3 class="text-danger text-center pt-3">You do not have permission to access </h3>
                    </div>
                    <div class="modal-footer justify-content-center">
                        <a class="btn btn-danger" href="index.jsp">Close</a>
                    </div>
                </div>
            </div>
        </div>
        <!--No permission Modal -->

        <!-- Include Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.2.3/js/bootstrap.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>

        <script>
            //var nav = document.querySelector('nav');


            window.addEventListener('scroll', function () {
                if (this.window.pageYOffset > 100) {
                    nav.classList.add('bg-light', 'shadow');
                } else {
                    nav.classList.remove('bg-light', 'shadow');
                }
            });

            var swiper = new Swiper(".swiper", {
                effect: "coverflow",
                grabCursor: true,
                centeredSlides: true,
                slidesPerView: 4,
                spaceBetween: 30,
                coverflowEffect: {
                    rotate: 0,
                    stretch: 0,
                    depth: 100,
                    modifier: 2,
                    slideShadows: true,
                    watchSlidesProgress: true,
                },

                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                },
            });
        </script>

        <%@include file="footer.jsp" %>
    </body>

</html>