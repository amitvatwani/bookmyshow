<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="style.css">

</head>
<body>
<div class="formdiv">  
    <center><span style="border:1px ; color:green">${otpSuccess}</span></center>
    <center><span style="border:1px ; color:red">${failedOtp}</span></center>

    <form action="verifyOtp">
        <table>
            <tr>
                <td>Enter Otp:</td>
                <td><input type="text" name="otp"></td>
                <td> <input type="submit" value="Submit" /></td>
            </tr>
            
        </table>
        <center></center>
    </form>
   <br>
   <a href="userSignup">Signup</a>
   <a href="userLogin">Login</a>
	
</div>     
</body>
</html>