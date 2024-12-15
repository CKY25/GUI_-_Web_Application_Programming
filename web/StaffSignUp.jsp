<%-- 
    Document   : StaffSignUp
    Created on : May 8, 2023, 2:37:39 PM
    Author     : kivac
--%>

<%@page import="model.Staff"%>
<%@page import="model.Loginuser"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>      

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Staff Sign Up</title>
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
                margin-top: 40px;
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
            p {
                font-size: 10px;
            }
            #login {
                top:0;
                position:absolute;
            }
            #duplicateXemail,#xlist,#xerr{
                margin: 0;
                padding: 0;
                display: none;
                color: red;
            }
            #duplicateXemail.active,#xlist.active,#xerr.active{
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
                $('#xsupassword, #xscpassword').on('keyup', function () {
                    if ($('#xsupassword').val() == "" && $('#xscpassword').val() == "") {
                        $('#xsignup').prop('disabled', true);
                        $('#xmessage').hide();
                    } else if ($('#xsupassword').val() == $('#xscpassword').val()) {
                        $('#xsignup').prop('disabled', false);
                        $('#xmessage').show().html('Password Match').css('color', 'green');
                    } else {
                        $('#xsignup').prop('disabled', true);
                        $('#xmessage').show().html('Password do not match').css('color', 'red');
                    }
                });
            });

            function validateStaffName() {
                var inputName = document.getElementById("xsuname");
                var stringRegex = /^[a-zA-Z\s]*$/;

                if (!inputName.value.match(stringRegex)) {
                    alert('Error! The name must be only alphabet ');
                    inputName.focus();
                    return false;
                } else {
                    return true;

                }
            }

            function duplicateXemail() {
                document.getElementById("duplicateXemail").classList.toggle("active");
            }
            function xlist() {
                document.getElementById("xlist").classList.toggle("active");
            }
            function xerr() {
                document.getElementById("xerr").classList.toggle("active");
            }
        </script>
    </head>
    <body>
        <video autoplay muted loop class="myVideo">
            <source src="./src/video/video3.mp4" type="video/mp4">
            Your browser does not support HTML5 video.
        </video>

        <nav id="login" style="margin-top: 50px"><a href="index.jsp">Back to Home</a></nav>
        <div class="container">
            <input type="checkbox" id="flip">
            <div class="cover">
                <div class="front">
                    <img src="./src/img/imageTwo.jpg" alt="">
                    <div class="text">
                        <span class="text-1">Welcome to Sketchy Sneakers<br> </span>
                        <span class="text-2">Let's sign up your staff account</span>
                    </div>
                </div>
                <div class="back" id="flip">
                    <img class="backImg" src="./src/img/imageTwo.webp" alt="">
                    <div class="text">
                        <span class="text-1">Welcome to Sketchy Sneakers <br> </span>
                        <span class="text-2">Let's sign up your staff account</span>
                    </div>
                </div>
            </div>
            <div class="forms">
                <div class="form-content">
                    <div class="signup-form">
                        <div class="title">Signup</div>
                        <form method="post" action="AddStaff">
                            <div class="input-boxes">
                                <div class="input-box">
                                    <i class="fas fa-user"></i>
                                    <input type="text" id="xsuname" name="xsuname" placeholder="Enter your name" maxlength="80" size="80" required>
                                </div>
                                <div class="input-box">
                                    <i class="fas fa-envelope"></i>
                                    <input type="email" id="xsemail" name="xsemail" placeholder="Enter your email" maxlength="80" size="80" required>
                                </div>
                                <p id="duplicateXemail">This email already signup</p>
                                <p id="xlist">This email list is empty</p>
                                <p id="xerr">System Error</p>
                                <div class="input-box">
                                    <i class="fas fa-lock"></i>
                                    <input type="password" id="xsupassword" name="xsupassword" placeholder="Enter your password" maxlength="7" size="7" required>
                                </div>
                                <div class="input-box">
                                    <i class="fas fa-lock"></i>
                                    <input type="password" id="xscpassword" name="xscpassword" placeholder="Enter your confirmed password" maxlength="7" size="7" required>
                                </div>
                                <p id="xmessage"></p>
                                <div class="button input-box">
                                    <input type="submit" id="xsignup" name="xsignup" onclick="return validateStaffName()" value="SignUp">
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="login-form">
                        <div class="title">Login</div>
                        <form method="post" action="StaffLogin">
                            <div class="input-boxes">
                                <div class="input-box">
                                    <i class="fas fa-envelope"></i>
                                    <input type="text" id="xlemail" name="xlemail" placeholder="Enter your email" maxlength="80" size="80" required>
                                </div>
                                <div class="input-box">
                                    <i class="fas fa-lock"></i>
                                    <input type="password" id="xlpasswaord" name="xlpassword" placeholder="Enter your password" maxlength="7" size="7" required>
                                </div>
                                <div class="text"><a href="#">Forgot password?</a></div>
                                <p id="emailErr">Email unable to find</p>
                                <p id="passwordErr">Invalid password</p>
                                <div class="button input-box">
                                    <input type="submit" id="xlogin" name="xlogin" value="Login">
                                </div>
                                <!--<div class="text sign-up-text">Don't have an account? <label for="flip">Sigup now</label></div>-->
                                <div class="text sign-up-text">Don't have an account? <a href="StaffSignUp.jsp">Signup now</a></div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
