<%-- 
    Document   : index
    Created on : May 2, 2023, 5:25:40 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" dir="ltr">
    <head>
        <meta charset="UTF-8">
        <!--<title> Login and Registration Form in HTML & CSS | CodingLab </title>-->
        <!--<link rel="stylesheet" href="style.css">-->
        <!-- Fontawesome CDN Link -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <style>
            @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700&display=swap');
            *{
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: "Poppins" , sans-serif;
            }
            body{
                min-height: 100vh;
                display: flex;
                align-items: center;
                justify-content: center;
                background: white;
                padding: 30px;
                margin: 0;
                font-family: Arial;
                font-size: 17px;
            }

            .myVideo {
                position: absolute;
                right: 0;
                bottom: 0;
                min-width: 100%;
                min-height: 100%;
                z-index: -1;
            }


            .container{
                position: relative;
                max-width: 850px;
                width: 100%;
                background: #fff;
                padding: 40px 30px;
                box-shadow: 0 5px 10px rgba(0,0,0,0.2);
                perspective: 2700px;

            }
            .container .cover{
                position: absolute;
                top: 0;
                left: 50%;
                height: 100%;
                width: 50%;
                z-index: 98;
                transition: all 1s ease;
                transform-origin: left;
                transform-style: preserve-3d;
            }
            .container #flip:checked ~ .cover{
                transform: rotateY(-180deg);
            }
            .container .cover .front,
            .container .cover .back{
                position: absolute;
                top: 0;
                left: 0;
                height: 100%;
                width: 100%;
            }
            .cover .back{
                transform: rotateY(180deg);
                backface-visibility: hidden;
            }
            .container .cover::before,
            .container .cover::after{
                content: '';
                position: absolute;
                height: 100%;
                width: 100%;
                background: black;
                opacity: 0.5;
                z-index: 12;
            }
            .container .cover::after{
                opacity: 0.3;
                transform: rotateY(180deg);
                backface-visibility: hidden;
            }
            .container .cover img{
                position: absolute;
                height: 100%;
                width: 100%;
                object-fit: cover;
                z-index: 10;
            }
            .container .cover .text{
                position: absolute;
                z-index: 130;
                height: 100%;
                width: 100%;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
            }
            .cover .text .text-1,
            .cover .text .text-2{
                font-size: 26px;
                font-weight: 600;
                color: #fff;
                text-align: center;
            }
            .cover .text .text-2{
                font-size: 15px;
                font-weight: 500;
            }
            .container .forms{
                height: 100%;
                width: 100%;
                background: #fff;
            }
            .container .form-content{
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
            .form-content .login-form,
            .form-content .signup-form{
                width: calc(100% / 2 - 25px);
            }
            .forms .form-content .title{
                position: relative;
                font-size: 24px;
                font-weight: 500;
                color: #333;
            }
            .forms .form-content .title:before{
                content: '';
                position: absolute;
                left: 0;
                bottom: 0;
                height: 3px;
                width: 25px;
                background: #7d2ae8;
            }
            .forms .signup-form  .title:before{
                width: 20px;
            }
            .forms .form-content .input-boxes{
                margin-top: 30px;
            }
            .forms .form-content .input-box{
                display: flex;
                align-items: center;
                height: 50px;
                width: 100%;
                margin: 10px 0;
                position: relative;
            }
            .form-content .input-box input{
                height: 100%;
                width: 100%;
                outline: none;
                border: none;
                padding: 0 30px;
                font-size: 16px;
                font-weight: 500;
                border-bottom: 2px solid rgba(0,0,0,0.2);
                transition: all 0.3s ease;
            }
            .form-content .input-box input:focus,
            .form-content .input-box input:valid{
                border-color: black;
            }
            .form-content .input-box i{
                position: absolute;
                color: black;
                font-size: 17px;
            }
            .forms .form-content .text{
                font-size: 14px;
                font-weight: 500;
                color: #333;
            }
            .forms .form-content .text a{
                text-decoration: none;
            }
            .forms .form-content .text a:hover{
                text-decoration: underline;
            }
            .forms .form-content .button{
                color: #fff;
                margin-top: 30px;
            }
            .forms .form-content .button input{
                color: #fff;
                background: black;
                border-radius: 6px;
                padding: 0;
                cursor: pointer;
                transition: all 0.4s ease;
            }
            .forms .form-content .button input:hover{
                background: grey;
                -webkit-text-stroke: 1px black;
                color: transparent;

            }
            .forms .form-content label{
                color: #5b13b9;
                cursor: pointer;
            }
            .forms .form-content label:hover{
                text-decoration: underline;
            }
            .forms .form-content .login-text,
            .forms .form-content .sign-up-text{
                text-align: center;
                margin-top: 25px;
            }
            .container #flip{
                display: none;
            }
            a{
                color:blue;
            }
            p {
                font-size: 12px;
                margin: 15px 0;
                display: inline-block;
                color: black;
                padding: 5px 10px;
            }
            #staff{
                position:absolute;
                top:0;
                text-align: center;
            }
            #passErr, #emErr, #duplicateEmail,#list,#err,#error{
                margin: 0;
                padding: 0;
                display: none;
                color: red;
            }
            #passErr.active, #emErr.active, #duplicateEmail.active,#list.active,err.active,error.active{
                display: inline-block;
            }


            @media (max-width: 730px) {
                .container .cover{
                    display:block;
                }
                .form-content .login-form,
                .form-content .signup-form{
                    width: 100%;
                }
                .form-content .signup-form{
                    display: none;
                }
                .container #flip:checked ~ .forms .signup-form{
                    display: block;
                }
                .container #flip:checked ~ .forms .login-form{
                    display: none;
                }
            }
        </style>

        <!-- import query -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <!-- check password confirmation -->
        <script>
            $(() => {
                $('#supassword, #scpassword').on('keyup', function () {
                    if ($('#supassword').val() == "" && $('#scpassword').val() == "") {
                        $('#signup').prop('disabled', true);
                        $('#message').hide();
                    } else if ($('#supassword').val() == $('#scpassword').val()) {
                        $('#signup').prop('disabled', false);
                        $('#message').show().html('Password Match').css('color', 'green');
                    } else {
                        $('#signup').prop('disabled', true);
                        $('#message').show().html('Password do not match').css('color', 'red');
                    }
                });
            });

            function validateName() {
                var inputName = document.getElementById("suname");
                var stringRegex = /^[a-zA-Z\s]*$/;

                if (!inputName.value.match(stringRegex)) {
                    alert('Error! The name must be only alphabet ');
                    inputName.focus();
                    return false;
                } else {
                    return true;

                }
            }

            function errPass() {
                document.getElementById("passErr").classList.toggle("active");
            }

            function errEm() {
                document.getElementById("emErr").classList.toggle("active");
            }
            function duplicateEmail() {
                document.getElementById("duplicateEmail").classList.toggle("active");
            }
            function list() {
                document.getElementById("list").classList.toggle("active");
            }
            function err() {
                document.getElementById("err").classList.toggle("active");
            }
            function error() {
                document.getElementById("error").classList.toggle("active");
            }


        </script>
    </head>
    <body>
        <video autoplay muted loop class="myVideo">
            <source src="./src/video/video.mp4" type="video/mp4">
            Your browser does not support HTML5 video.
        </video>

        <nav id="staff" style="margin-top: 50px;"><a href="index.jsp">Back to Home</a></nav>
        <nav id="staff"><a href="StaffLogin.jsp">Staff Login</a></nav>

        <div class="container">
            <input type="checkbox" id="flip">
            <div class="cover">
                <div class="front">
                    <img src="./src/img/imageOne.webp" alt="">
                    <div class="text">
                        <span class="text-1">Welcome to Sketchy Sneakers<br> to purchase your favorite sneakers </span>
                        <span class="text-2">Let's login your account</span>
                    </div>
                </div>
                <div class="back" id="flip">
                    <img class="backImg" src="./src/img/imageOne.webp" alt="">
                    <div class="text">
                        <span class="text-1">Welcome to Sketchy Sneakers <br> </span>
                        <span class="text-2">Let's sign up your own account</span>
                    </div>
                </div>
            </div>
            <div class="forms">
                <div class="form-content">
                    <div class="login-form">
                        <div class="title">Login</div>
                        <form method="post" action="Login">
                            <div class="input-boxes">
                                <div class="input-box">
                                    <i class="fas fa-envelope"></i>
                                    <input type="email" id="lemail" name="lemail" placeholder="Enter your email" maxlength="80" size="80" required>
                                </div>
                                <div class="input-box">
                                    <i class="fas fa-lock"></i>
                                    <input type="password" id="lpasswaord" name="lpassword" placeholder="Enter your password" maxlength="7" size="7" required>
                                </div>

                                <div class="text"><a href="#">Forgot password?</a></div>
                                <p id="emErr">Email unable to find</p>
                                <p id="passErr">Invalid password</p>
                                <p id="error">System Error</p>
                                <div class="button input-box">
                                    <input type="submit" id="login" name="login" value="Login">
                                </div>
                                <div class="text sign-up-text">Don't have an account? <label for="flip">Sigup now</label></div>
                            </div>
                        </form>
                    </div>
                    <div class="signup-form">
                        <div class="title">Signup</div>
                        <form method="post" action="AddUser">
                            <div class="input-boxes">
                                <div class="input-box">
                                    <i class="fas fa-user"></i>
                                    <input type="text" id="suname" name="suname" placeholder="Enter your name" maxlength="80" size="80" required>
                                </div>
                                <div class="input-box">
                                    <i class="fas fa-envelope"></i>
                                    <input type="email" id="semail" name="semail" placeholder="Enter your email" maxlength="80" size="80" required>
                                </div>
                                <p id="duplicateEmail">This email already signup</p>
                                <p id="list">This email list is empty</p>
                                <p id="err">System Error</p>
                                <div class="input-box">
                                    <i class="fas fa-lock"></i>
                                    <input type="password" id="supassword" name="supassword" placeholder="Enter your password" maxlength="7" size="7" required>
                                </div>
                                <div class="input-box">
                                    <i class="fas fa-lock"></i>
                                    <input type="password" id="scpassword" name="scpassword" placeholder="Enter your confirmed password" maxlength="7" size="7" required>
                                </div>
                                <p id="message"></p>
                                <div class="button input-box">
                                    <input type="submit" id="signup" onclick="return validateName()" name="signup" value="SignUp">
                                </div>
                                <div class="text sign-up-text">Already have an account? <label for="flip">Login now</label></div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>
