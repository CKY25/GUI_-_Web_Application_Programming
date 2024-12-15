<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Maybank Login</title>
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
        <link rel="icon" href="data:image/jpeg;base64,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" type="image/png">
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
            .card-container {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }
            .card-header {
                background-color: #f9a825;
                color: #fff;
                border-radius: 10px 10px 0 0;
            }
            .card-body {
                padding: 30px;
            }
            .form-control {
                border: none;
                border-radius: 0px;
                border-bottom: 2px solid #f9a825;
            }
            .form-control:focus {
                box-shadow: none;
                border-color: #f9a825;
            }
            .btn-primary {
                border-radius: 20px;
                background-color: #f9a825;
                border: none;
                width: 100%;
            }
            .btn-primary:hover {
                background-color: #e69115;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6 ">
                    <div class="card">
                        <div class="card-header">
                            <h4>Maybank4u Login</h4>
                        </div>
                        <div class="card-body">
                            <form id="login-form">
                                <div class="form-group">
                                    <label for="username">Username</label>
                                    <input type="text" class="form-control" id="username" name="username" required>
                                </div>
                                <div class="form-group">
                                    <label for="password">Password</label>
                                    <input type="password" class="form-control" id="password" name="password" required>
                                </div>
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
                if (username === "maybank" && password === "maybank") {
                    // Redirect to the successful page
                     $("#loadMe").modal({
                            backdrop: "static", //remove ability to close modal with click
                                    keyboard: false, //remove option to close with keyboard
                                    show: true //Display loader!
                            });
                                    setTimeout(function() {
                                    $("#loadMe").modal("hide");
                                    }, 3500);
                    setTimeout(function () {
                    window.location.href = "./insertOrder2";}, 3500);
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