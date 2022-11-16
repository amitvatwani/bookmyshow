<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="styles1.css">
    <link rel="stylesheet" href="style.css">
<meta charset="ISO-8859-1">
<title>Insert title here</title>
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
                <a href="index" style="text-decoration: none;color:#00b8f5"> MovieTicketBooking </a>
            </div>
            <div class="login-img-div">
                <div class="login-button-div">
                    <a href="userLogin">Signin</a>
                </div>
            </div>
        </div>
        <div class="home-content-div">
            
            <div class="movie-content-div">
                <div class="formdiv">
                    <form:form action="addUser" modelAttribute="User">
                     <table>
                         <tr>
                             <td>
                                 Username:
                             </td>
                             <td>
                                 <form:input type="text" path="userName" /><br>
                                 <form:errors path="userName" cssClass="error" />
                             </td>
                         </tr>
                         <tr>
                             <td>
                                 Mobile:
                             </td>
                             <td>
                                 <form:input type="text" path="userMobile"/><br>
                                 <form:errors path="userMobile" cssClass="error" />
                             </td>
                         </tr>
                         <tr>
                             <td>
                                 Email:
                             </td>
                             <td>
                                 <form:input type="text" path="userEmail"/><br>
                                 <span style="color:red">${userExists}</span>
                                 <form:errors path="userEmail" cssClass="error" />
                             </td>
                         </tr>
                         <tr>
                             <td>
                                 Password:
                             </td>
                             <td >
                                 <form:input type="text" path="userPassword" id="password"/><br>
                                 <span id='message' style="word-wrap: break-word;width: 20%"></span>
                                 <form:errors path="userPassword" cssClass="error" />
                             </td>
                         </tr>
                         <tr>
                             <td>
                                 Confirm Password:
                             </td>
                             <td>
                                 <input type="text" id="confirmPassword" onkeyup="check()"/>
                             </td>
                         </tr>
                     </table>
                     <input type="submit" value="Signup" id="submitButton"/>
                    </form:form>
                 
                    <br>
                    <a href="userLogin">Login</a>
                 </div>
            </div>
        </div>
    </div>
    


   <script>

    var check = function() {

    if (document.getElementById('password').value ==

      document.getElementById('confirmPassword').value) {

      document.getElementById('message').style.color = 'green';

      document.getElementById('message').innerHTML = 'Matching';
      console.log(document.getElementById('submitButton'));
    } else {

      document.getElementById('message').style.color = 'red';

      document.getElementById('message').innerHTML = 'Not matching';

    }

  }

</script>

</body>
</html>