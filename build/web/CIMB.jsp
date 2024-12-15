<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>CIMB Bank Login</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <link rel="icon" href="https://th.bing.com/th/id/OIP.6xiR50g_7K4j16W0rMDsLQHaG4?w=185&h=177&c=7&r=0&o=5&dpr=1.4&pid=1.7" type="image/png">
        <style>
            body {
                background-image: url("https://www.example.com/background.jpg");
                background-size: cover;
                background-position: center;
            }
            .card {
                margin-top: 50px;
                background-color: rgba(255, 255, 255, 0.85);
                border-radius: 10px;
                box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.3);
            }
            .card-header {
                background-color: red;
                color: #fff;
                border-radius: 10px 10px 0 0;
            }
            .card-body {
                padding: 30px;
            }
            .form-control {
                border: none;
                border-radius: 0px;
                border-bottom: 2px solid red;
            }
            .form-control:focus {
                box-shadow: none;
                border-color: red;
            }
            .btn-primary {
                border-radius: 20px;
                background-color: red;
                border: none;
                width: 100%;
            }
            .btn-primary:hover {
                background-color: darkred;
            }
        </style>
    </head>
    <%
        String input1Value = request.getParameter("input1"); // Retrieve the input1 value from the URL parameter or form submission
    %>
    <body>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <div class="card">
                        <div class="card-header">
                            <h4>CIMB Click Login</h4>
                        </div>
                        <div class="card-body">
                            <form id="login-form" action="insertOrder2" method="post">
                                <div class="form-group">
                                    <label for="username">Username</label>
                                    <input type="text" class="form-control" id="username" name="username" required>
                                </div>
                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input type="password" class="form-control" id="password" name="password" required>
                                </div>
                                <input type="hidden" name="input1" value="<%= input1Value%>">
                                <button type="submit" class="btn btn-primary">Login</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- jQuery and Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/1.1.3/sweetalert.min.js"></script>

        <script>
            // Get the login form
            var form = document.getElementById("login-form");
            // Add an event listener to the form submit event
            form.addEventListener("submit", function (event) {
                event.preventDefault();
                // Get the username and password values
                var username = document.getElementById("username").value;
                var password = document.getElementById("password").value;
                // Check if the username and password are equal to "cimb"
                if (username === "cimb" && password === "cimb") {
                    // Redirect to the successful page
                    $("#loadMe").modal({
                        backdrop: "static", //remove ability to close modal with click
                        keyboard: false, //remove option to close with keyboard
                        show: true //Display loader!
                    });
                    setTimeout(function () {
                        $("#loadMe").modal("hide");
                    }, 3500);
                    //setTimeout(function () {
                    window.location.href = "insertOrder2?paymentMethod=<%= input1Value%>";
                    //}, 3500);
                } else {
                    // Show an error message
                    alert("Invalid username or password");
                }
            });
        </script>

        <style id="INLINE_PEN_STYLESHEET_ID">

            /** SPINNER CREATION **/
            .loader {
                position: relative;
                text-align: center;
                margin: 15px auto 35px auto;
                z-index: 9999;
                display: block;
                width: 80px;
                height: 80px;
                border: 10px solid rgba(0, 0, 0, 0.3);
                border-radius: 50%;
                border-top-color: #000;
                animation: spin 1s ease-in-out infinite;
                -webkit-animation: spin 1s ease-in-out infinite;
            }
            @keyframes spin {
                to {
                    -webkit-transform: rotate(360deg);
                }
            }
            @-webkit-keyframes spin {
                to {
                    -webkit-transform: rotate(360deg);
                }
            }
            /** MODAL STYLING **/
            .modal-content {
                border-radius: 0px;
                box-shadow: 0 0 20px 8px rgba(0, 0, 0, 0.7);
            }
            .modal-backdrop.show {
                opacity: 0.75;
            }
            .loader-txt p {
                font-size: 13px;
                color: #666;
            }
            .loader-txt p small {
                font-size: 11.5px;
                color: #999;
            }
            #output {
                padding: 25px 15px;
                background: #222;
                border: 1px solid #222;
                max-width: 350px;
                margin: 35px auto;
                font-family: 'Roboto', sans-serif !important;
            }
            #output p.subtle {
                color: #555;
                font-style: italic;
                font-family: 'Roboto', sans-serif !important;
            }
            #output h4 {
                font-weight: 300 !important;
                font-size: 1.1em;
                font-family: 'Roboto', sans-serif !important;
            }
            #output p {
                font-family: 'Roboto', sans-serif !important;
                font-size: 0.9em;
            }
            #output p b {
                text-transform: uppercase;
                text-decoration: underline;
            }

        </style>

        <!-- Modal -->
        <div class="modal fade" id="loadMe" tabindex="-1" role="dialog" aria-labelledby="loadMeLabel">
            <div class="modal-dialog modal-sm text-center" role="document">
                <div class="modal-content">
                    <div class="modal-body text-center">
                        <div class="loader"></div>
                        <div clas="loader-txt">
                            <p>Processing...</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>