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
<!doctype html>
<html lang="en">

    <head>
        <meta charset="utf-8">
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport" />
        <title>Check Out</title>
        <!-- CSS stylesheet -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
        <link rel="stylesheet" href="src/css/checkout.css" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="canonical" href="https://getbootstrap.com/docs/4.3/examples/checkout/">
        <!-- Bootstrap core CSS -->
        <link href="/docs/4.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">

    </style>
</head>
<%    DecimalFormat df = new DecimalFormat("#.##");
    request.setAttribute("df", df);
    List<CartItem> cartItemList = (List<CartItem>) session.getAttribute("cartItemList");
    List<CartItem> cartProduct = null;
    int cartSize = cartItemList.size();
    if (cartItemList != null) {
        ItemDao pDao = new ItemDao();
        cartProduct = pDao.getCartProducts(cartItemList);
        double total = pDao.getTotalCartPrice(cartItemList);
        //double cartTotal = Double.parseDouble((total > 0) ? (new java.text.DecimalFormat("0.00")).format(total) : "0.00");
        String formattedTotal = String.format("%.2f", total);
        System.out.print("FORMAT=" + formattedTotal);
        request.setAttribute("total", total);
        request.setAttribute("formattedTotal", formattedTotal);
        request.setAttribute("cartItemList", cartItemList);
        //CartItem cart = new CartItem();
    }%>



<%
    ItemDao pDao = new ItemDao();
    double total = pDao.getTotalCartPrice(cartItemList);
    String Shipping = "RM 0";
    if (total >= 200) {
        Shipping = "RM25";
    }
    request.setAttribute("Shipping", Shipping);
%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<body class="bg-light">
    <form id="checkout-form" action="insertOrder2" method="POST" class="needs-validation" novalidate>
        <div class="container">

            <div class="row">
                <div class="col-md-4 order-md-2 mb-4">
                    <br><br><h4 class="d-flex justify-content-between align-items-center mb-3">
                        <span class="text-muted">Your cart</span>
                        <span class="badge badge-secondary badge-pill"><%= cartSize%></span>
                    </h4>
                    <% for (CartItem item : cartProduct) {%>
                    <ul class="list-group mb-3">
                        <li class="list-group-item d-flex justify-content-between lh-condensed">
                            <div>
                                <h6 class="my-0"><%= item.getItemname()%></h6>
                                <small class="text-muted">${item.getDescription()}</small>
                            </div>
                            <span class="text-muted"><%String formattedSubtotal = String.format("%.2f", item.getItemSubtotal());%>
                                RM<%= formattedSubtotal%></span>
                        </li>

                        <% }%>
                    </ul>


                    <li class="list-group-item d-flex justify-content-between lh-condensed">
                        <div>
                            <h6 class="my-0">Delivery Charge</h6>
                            <small class="mb-0 mt-0"style="font-size: 80%;">RM 200 and above,<br>
                                delivery charges will be free</small>
                        </div>
                        <span class="text-muted">RM 25</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between bg-light">
                        <div class="text-success">
                            <h6 class="my-0">Discount</h6>
                        </div>
                        <span class="text-success">-${Shipping}</span>
                    </li>
                    <li class="list-group-item d-flex justify-content-between">
                        <span>Total (RM)</span>
                        <strong>RM${formattedTotal}</strong>
                    </li>
                    </ul>


                    <br><h4 class="mb-3">Payment</h4>

                    <div class="d-block my-3">
                        <div class="custom-control custom-radio">
                            <input id="credit" name="paymentMethod" type="radio" class="custom-control-input" data-toggle="collapse" data-target="#creditDiv" value="Credit Card" required>
                            <label class="custom-control-label" for="credit">Credit card</label>
                            <div id="creditDiv" class="panel-collapse collapse">
                                <div class="row">
                                    <div class="col-md-12 mb-3">
                                        <label for="cc-name">Name on card</label>
                                        <input type="text" class="form-control" id="cc-name" placeholder="Full name as displayed on card"  pattern="[a-zA-Z ]+" onblur="validateNameOnCard()">
                                        <div class="invalid-feedback">
                                            Please enter a valid name on card (letters and spaces only).
                                        </div>
                                    </div>

                                    <script>
                                        function validateNameOnCard() {
                                        if (nameOnCard == null) {
                                        document.getElementById("cc-name").classList.remove("is-invalid");
                                        }
                                        var nameOnCard = document.getElementById("cc-name").value.trim();
                                        if (nameOnCard.length > 0) {
                                        var regex = /^[a-zA-Z\s]*$/;
                                        if (!regex.test(nameOnCard)) {
                                        document.getElementById("cc-name").classList.remove("is-valid");
                                        document.getElementById("cc-name").classList.add("is-invalid");
                                        } else {
                                        document.getElementById("cc-name").classList.remove("is-invalid");
                                        document.getElementById("cc-name").classList.add("is-valid");
                                        }
                                        }
                                        }
                                    </script>


                                </div>
                                <div class="row">
                                    <div class="col-md-12 mb-3">
                                        <label for="cc-number">Credit card number</label>
                                        <input type="text" class="form-control" id="cc-number" placeholder="Credit card number" pattern="\d{13,16}" onblur="validateCreditCardNumber()">
                                        <div class="invalid-feedback">
                                            Credit card number is in wrong format
                                        </div>
                                        <script>
                                            function validateCreditCardNumber() {
                                            var ccNum = document.getElementById("cc-number").value.replace(/\D/g, '');
                                            if (ccNum === "") {
                                            document.getElementById("cc-number").classList.remove("is-invalid");
                                            document.getElementById("cc-number").classList.remove("is-valid");
                                            return true;
                                            }

                                            if (ccNum.length < 13 || ccNum.length > 19) {
                                            // Invalid length
                                            document.getElementById("cc-number").classList.remove("is-valid");
                                            document.getElementById("cc-number").classList.add("is-invalid");
                                            return false;
                                            } else {
                                            document.getElementById("cc-number").classList.remove("is-invalid");
                                            }
                                            var sum = 0, doubleUp = false;
                                            for (var i = ccNum.length - 1; i >= 0; i--) {
                                            var curDigit = parseInt(ccNum.charAt(i));
                                            if (doubleUp) {
                                            if ((curDigit *= 2) > 9) curDigit -= 9;
                                            }
                                            sum += curDigit;
                                            doubleUp = !doubleUp;
                                            }
                                            if ((sum % 10) == 0) {
                                            // Valid credit card number
                                            document.getElementById("cc-number").classList.remove("is-invalid");
                                            document.getElementById("cc-number").classList.add("is-valid");
                                            return true;
                                            } else {
                                            // Invalid credit card number
                                            document.getElementById("cc-number").classList.remove("is-valid");
                                            document.getElementById("cc-number").classList.add("is-invalid");
                                            return false;
                                            }
                                            }
                                        </script>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label for="cc-expiration">Expiration</label>
                                        <input type="text" class="form-control" id="cc-expiration" placeholder="MM/YY" onblur="validateExpirationDate()">
                                        <div class="invalid-feedback">
                                            Expiration date is required and should be in the format MM/YY
                                        </div>

                                        <script>
                                            function validateExpirationDate() {
                                            var input = document.getElementById("cc-expiration").value;
                                            if (!input.match(/^(0[1-9]|1[0-2])\/([0-9]{2})$/)) {
                                            // Invalid format
                                            document.getElementById("cc-expiration").classList.remove("is-valid");
                                            document.getElementById("cc-expiration").classList.add("is-invalid");
                                            return false;
                                            }
                                            // Split the input into month and year
                                            var parts = input.split("/");
                                            var month = parseInt(parts[0], 10);
                                            var year = parseInt(parts[1], 10);
                                            // Validate that the month and year are valid
                                            if (year < new Date().getFullYear() - 2000 || month < 1 || month > 12) {
                                            // Invalid expiration date
                                            document.getElementById("cc-expiration").classList.remove("is-valid");
                                            document.getElementById("cc-expiration").classList.add("is-invalid");
                                            return false;
                                            }
                                            // Expiration date is valid
                                            document.getElementById("cc-expiration").classList.remove("is-invalid");
                                            document.getElementById("cc-expiration").classList.add("is-valid");
                                            return true;
                                            }
                                        </script>

                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label for="cc-cvv">CVV</label>
                                        <input type="text" class="form-control" id="cc-cvv" placeholder="CVV">
                                        <div class="invalid-feedback">
                                            Security code is required
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12 custom-control custom-radio">
                            <input id="debit" name="paymentMethod" type="radio" class="custom-control-input" data-toggle="collapse" data-target="#BankDiv" required value="Online Banking">
                            <label class="custom-control-label" for="debit">Online Banking</label>
                            <div id="BankDiv" class="panel-collapse collapse">
                                <div class="col-md-12 mb-3 mt-3" >
                                    <input type="radio" name="bank" value="CIMB Bank" checked>
                                    <a href="#">
                                        <img src="https://play-lh.googleusercontent.com/A75cRWwhBX-txKmE6g1X4lF4MD_RgxgPopJ5eHklR5ON-B27pv5aryUPWYIO7s5_jWw=s180-rw" alt="cimb" width="50" height="40"></img>
                                    </a><label class="cimb">CIMB</label>
                                </div>
                                <div class="col-md-12">
                                    <input type="radio" name="bank" value="Maybank">
                                    <a href="#">
                                        <img src="https://www.lowyat.net/wp-content/uploads/2016/10/Maybank.png" alt="maybank" width="50" height="40" ></img>
                                    </a><label class="maybank">Maybank</label>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-12 mb-3 custom-control custom-radio">
                            <input id="paypal" name="paymentMethod" type="radio" class="custom-control-input" required checked value="COD">
                            <label class="custom-control-label" for="paypal">Cash</label>
                        </div>
                        <script>
                            $('input[class="custom-control-input"]').on('click', function () {
                            var target = $(this).data('target');
                            $('.collapse').not(target).collapse('hide');
                            });
                        </script>
                    </div>


                </div>

                <div class="col-md-8 order-md-1">
                    <br><br><h4 class="mb-3">Billing address</h4>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="firstName">First name</label>
                            <input type="text" class="form-control" id="firstName" placeholder="" value="" required>
                            <div class="invalid-feedback">
                                Valid first name is required.
                            </div>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="lastName">Last name</label>
                            <input type="text" class="form-control" id="lastName" placeholder="" value="" required>
                            <div class="invalid-feedback">
                                Valid last name is required.
                            </div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="email">Email <span class="text-muted">(Optional)</span></label>
                        <input type="email" class="form-control" id="email" placeholder="you@example.com">
                        <div class="invalid-feedback">
                            Please enter a valid email address for shipping updates.
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="address">Address</label>
                        <input type="text" class="form-control" id="address" placeholder="1234 Main St" required>
                        <div class="invalid-feedback">
                            Please enter your shipping address.
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="address2">Address 2 <span class="text-muted">(Optional)</span></label>
                        <input type="text" class="form-control" id="address2" placeholder="Apartment or suite">
                    </div>

                    <div class="row">
                        <div class="row">
                            <div class="col-md-5 mb-3">
                                <label for="country">Country</label>
                                <select class="custom-select d-block w-100" id="country" required onchange="updateStateDropdown()">
                                    <option value="">Choose...</option>
                                    <option value="US">United States</option>
                                    <option value="MY">Malaysia</option>
                                    <option value="SG">Singapore</option>
                                    <option value="JP">Japan</option>
                                    <option value="AU">Australia</option>
                                </select>
                                <div class="invalid-feedback">
                                    Please select a valid country.
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <label for="state">State/City</label>
                                <select class="custom-select d-block w-100" id="state" required>
                                    <option value="">Choose...</option>
                                </select>
                                <div class="invalid-feedback">
                                    Please provide a valid state/city.
                                </div>
                            </div>


                            <script>
                                // Define the state/city options for each country
                                const stateOptions = {
                                "US": ["California", "New York", "Texas", "Florida"],
                                        "MY": ["Johor", "Kedah", "Kelantan", "Kuala Lumpur", "Melaka", "Negeri Sembilan", "Pahang", "Perak", "Perlis", "Penang", "Sabah", "Sarawak", "Selangor", "Terengganu"],
                                        "SG": ["Central Singapore", "North East Singapore", "North West Singapore", "South East Singapore", "South West Singapore"],
                                        "JP": ["Tokyo", "Osaka", "Kyoto", "Hiroshima", "Fukuoka"],
                                        "AU": ["New South Wales", "Victoria", "Queensland", "Western Australia", "South Australia"]
                                };
                                // Function to update the state dropdown options based on the selected country
                                function updateStateDropdown() {
                                const countryDropdown = document.getElementById("country");
                                const stateDropdown = document.getElementById("state");
                                // Get the selected country option value
                                const selectedCountry = countryDropdown.value;
                                // Clear the current state dropdown options
                                stateDropdown.innerHTML = "";
                                // If the selected country is Malaysia, display all states in Malaysia
                                if (selectedCountry === "MY") {
                                const allStates = stateOptions[selectedCountry];
                                for (let i = 0; i < allStates.length; i++) {
                                const stateOption = document.createElement("option");
                                stateOption.value = allStates[i];
                                stateOption.text = allStates[i];
                                stateDropdown.add(stateOption);
                                }
                                } else {
                                // Otherwise, display the state options for the selected country
                                const countryStates = stateOptions[selectedCountry];
                                for (let i = 0; i < countryStates.length;
                                i++
                                        ) {
                                const stateOption = document.createElement("option");
                                stateOption.value = countryStates[i];
                                stateOption.text = countryStates[i];
                                stateDropdown.add(stateOption);
                                }
                                }
                                }
                            </script>

                            <div class="col-md-3 mb-3">
                                <label for="zip">Zip</label>
                                <input type="text" class="form-control" id="zip" placeholder="" required pattern="\d+">
                                <div class="invalid-feedback">
                                    Zip code required.
                                </div>
                            </div>
                        </div>
                    </div>
                    <hr class="mb-4">
                    <div class="custom-control custom-checkbox">
                        <input type="checkbox" class="custom-control-input" id="same-address">
                        <label class="custom-control-label" for="same-address">Shipping address is the same as my
                            billing address</label>
                    </div>
                    <div class="custom-control custom-checkbox">
                        <input type="checkbox" class="custom-control-input" id="save-info">
                        <label class="custom-control-label" for="save-info">Save this information for next time</label>
                    </div>
                    <hr class="mb-4">

                    <hr class="mb-4">
                    <button class="btn btn-primary btn-lg btn-block bg-black" type="submit" id="placeOrderBtn">Place Order</button>

                    <!--                    <script>
                                            document.getElementById("placeOrderBtn").addEventListener("click", function () {
                                                // Perform validation here, and return early if validation fails
                    
                                                // Redirect to success page
                                                window.location.href = "index.jsp";
                                            });
                                        </script>-->

                    </br>
                </div>
            </div>

        </div>
    </form>

    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
            integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo"
    crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="/docs/4.3/assets/js/vendor/jquery-slim.min.js"></script>')</script>
<script src="https://getbootstrap.com/docs/4.3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-xrRywqdh3PHs8keKZN+8zzc5TX0GRTLCcmivcbNJWm2rs5C8PRhcEn3czEjhAO9o"
crossorigin="anonymous"></script>
<script src="https://getbootstrap.com/docs/4.3/examples/checkout/form-validation.js"></script>
<script>
                                // Get all radio buttons with name "paymentMethod"
                                var paymentRadios = document.getElementsByName('paymentMethod');
                                // Add event listener for each radio button
                                paymentRadios.forEach(function(radio) {
                                radio.addEventListener('click', function() {
                                // If Credit card radio button is checked, make the input fields required
                                if (document.getElementById('credit').checked) {
                                document.getElementById('cc-name').setAttribute('required', '');
                                document.getElementById('cc-number').setAttribute('required', '');
                                document.getElementById('cc-expiration').setAttribute('required', '');
                                document.getElementById('cc-cvv').setAttribute('required', '');
                                } else {
                                // If Credit card radio button is not checked, remove the required attribute
                                document.getElementById('cc-name').removeAttribute('required');
                                document.getElementById('cc-number').removeAttribute('required');
                                document.getElementById('cc-expiration').removeAttribute('required');
                                document.getElementById('cc-cvv').removeAttribute('required');
                                document.getElementById('paypal').removeAttribute('required');
                                document.getElementById('debit').removeAttribute('required');
                                }
                                if (document.getElementById('debit').checked){
                                document.getElementById('cimb-radio').setAttribute('required', '');
                                document.getElementById('maybank-radio').setAttribute('required', '');
                                } else{
                                document.getElementById('cimb-radio').removeAttribute('required', '');
                                document.getElementById('maybank-radio').removeAttribute('required', '');
                                document.getElementById('credit').removeAttribute('required');
                                document.getElementById('paypal').removeAttribute('required');
                                }
                                if (document.getElementById('paypal').checked){
                                document.getElementById('credit').removeAttribute('required');
                                document.getElementById('debit').removeAttribute('required');
                                }
                                });
                                });</script> 

</body>

</html>