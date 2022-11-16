<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="styles1.css">
<link rel="stylesheet" href="style.css">
<style>  
        .error {color:red}  
    </style> 
</head>
<body>

    <div class="home-main-cont">
        <!-- <div class="home-sidebar">
            <span class="sidebar-close">&times;</span>
            <div>

            </div>
            <div>

            </div>
        </div> -->
        <div class="home-screen-navbar">
            <div class="logo-adv-div">
                <a href="index"> MovieTicketBooking </a>
            </div>
            <div class="login-img-div">
                <div class="login-button-div">
                    <a href="userLogin" style="text-decoration: none;color:#00b8f5">Signin</a>
                </div>
            </div>
        </div>
        <div class="home-content-div">
            
            <div class="movie-content-div">
                <div class="formdiv">
                    <span style="border:1px; background-color: rgb(171, 254, 171); border-radius: 0.5rem;";>${signupSuccess}</span>
                    <span style="border:1px; background-color: rgb(171, 254, 171); border-radius: 0.5rem;";>${userLogoutSuccess}</span>
                    ${SPRING_SECURITY_LAST_EXCEPTION.message}
                    <form action="/userLogin" method="post">
                        <table>
                            <tr>
                                <td>Email:</td>
                                <td><input type="text" name="username"/></td>
                            </tr>
                            <tr>
                                <td>Password:</td>
                                <td><input type="password" name="password"/></td>
                            </tr>
                        </table>
                         <br>
                         
                        <span  style="border:1px; background-color: red; border-radius: 0.5rem;">${message}</span>
                        <input type="submit" value="Login" />
                    </form>

                    <br>
                    <a href="userSignup">Signup</a>
                    <a href="forgotPassword">Forgot Password?</a>
                </div>
            </div>
        </div>
    </div>
    
      
</body>
</html>