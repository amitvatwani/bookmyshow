<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="style.css">
<style>  
  .error {color:red}  
</style> 
</head>
<body>
<div class="formdiv">  
   <center><span style="border:1px ; color:green">${successOtp}</span></center>
    <span style="border:1px ; color:red;">${passwordChangeFailed}</span>
    <form:form action="passwordChangeSuccess"  modelAttribute="User">
        <table>
            <tr>
                <td>Enter password:</td>
                <td><form:input type="text" path="userPassword" id="password" /></td>
                <td><span id='message'></span><br></td>
                <form:errors path="userPassword" cssClass="error" />
            </tr>
            <tr>
                <td>Confirm password:</td>
                <td><input type="text" id="confirmPassword" name="confirmPassword" onkeyup="check()"/></td>
                
            </tr>
            
        </table>
        <center> <input type="submit" value="Signup" id="submitButton" class="btn"/></center>
    </form:form>
   <br>
   <a href="userSignup">Signup</a>
   <a href="userLogin">Login</a>
	
</div>     
<script>

    var check = function() {

    if (document.getElementById('password').value ==

      document.getElementById('confirmPassword').value) {

      document.getElementById('message').style.color = 'green';

      document.getElementById('message').innerHTML = 'Matching';
    } else {

      document.getElementById('message').style.color = 'red';

      document.getElementById('message').innerHTML = 'Not matching';

    }

  }

</script>
</body>
</html>