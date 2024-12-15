<%-- 
    Document   : footer
    Created on : May 1, 2023, 9:07:49 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <header>
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
    </header>
    
    <footer class="text-center text-lg-start text-muted mt-3" style="background-color: black">
        <!-- Section: Links  -->
        <section class="">
            <div class="container text-center text-md-start pt-4 pb-4">
                <!-- Grid row -->
                <div class="row mt-3">
                    <!-- Grid column -->
                    <div class="col-12 col-lg-3 col-sm-12 mb-2">
                        <!-- Content -->
                        <a href="index.jsp" class="footer-logo">
                            <img src="./src/img/logo.png" height="70" width="70" />
                        </a>
                    </div>
                    <!-- Grid column -->

                    <!-- Grid column -->
                    <div class="col-6 col-sm-4 col-lg-2">
                        <!-- Links -->
                        <h4 class="footer-header mb-2">STORE</h4>
                        <ul class="list-unstyled mb-4">
                            <li><a class="footer-content" href="#">About us</a></li>

                            <li><a class="footer-content" href="#">Categories</a></li>

                        </ul>
                    </div>
                    <!-- Grid column -->

                    <!-- Grid column -->
                    <div class="col-6 col-sm-4 col-lg-2">
                        <!-- Links -->
                        <h4 class="footer-header mb-2">FOLLOW US</h4>
                        <ul class="list-unstyled d-flex flex-row mb-4">
                            <li><a class="mx-2" href="#"><i class="fa-brands fa-instagram fa-2xl"
                                                            style="color: #ffffff;"></i></a></li>
                            <li><a class="mx-2" href="#"><i class="fa-brands fa-facebook fa-2xl"
                                                            style="color: #ffffff;"></i></a></li>
                            <li><a class="mx-2" href="#"><i class="fa-brands fa-twitter fa-2xl"
                                                            style="color: #ffffff;"></i></a></li>
                        </ul>
                    </div>
                    <!-- Grid column -->

                    <!-- Grid column -->
                    <div class="col-6 col-sm-4 col-lg-2">
                        <!-- Links -->
                        <h4 class="footer-header mb-2">SUPPORT</h4>
                        <ul class="list-unstyled mb-4">
                            <li><a class="footer-content" href="#">Help center</a></li>
                            <li><a class="footer-content" href="#">Documents</a></li>
                            <li><a class="footer-content" href="#">Account restore</a></li>
                            <li><a class="footer-content" href="#">My orders</a></li>
                        </ul>
                    </div>
                    <!-- Grid column -->

                    <!-- Grid column -->
                    <div class="col-6 col-sm-4 col-lg-2">
                        <!--- payment --->
                        <h4 class="footer-header mb-2">PAYMENT</h4>
                        <div>
                            <i class="fab fa-lg fa-cc-visa text-light fa-xl"></i>
                            <i class="fab fa-lg fa-cc-amex text-light fa-xl"></i>
                            <i class="fab fa-lg fa-cc-mastercard text-light fa-xl"></i>
                            <i class="fab fa-lg fa-cc-paypal text-light fa-xl"></i>
                        </div>
                        <!--- payment --->
                    </div>
                    <!-- Grid column -->
                </div>
                <!-- Grid row -->
                <div class="copyright float-end">
                    <h6 style="font-size:0.8rem"><i class="fa-regular fa-copyright" style="color: #6C757D;"></i> <%=java.time.LocalDate.now().getYear()%> <%= getServletContext().getAttribute("copyright")%></h6>
                </div>
                <div class="email">
                    <h6 style="font-size:0.8rem"> Email Us @ <%= getServletContext().getAttribute("email")%></h6>
                </div>
            </div>
        </section>
        <!-- Section: Links  -->
    </footer>
</html>
