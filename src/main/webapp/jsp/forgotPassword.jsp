<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="style.css">

</head>
<body>
<div class="formdiv">  
   
    <center><span style="border:1px ; color:red;">${failedEmail}${error}</span></center>
    <center><span style="border:1px ; color:green" id="otpSuccess">${otpSuccess}</span></center>
    <center><span style="border:1px ; color:red" id="otpFailed">${failedOtp}</span></center>
    
    <form action="sendOtp" style="display:block" id="emailForm">
        <table>
            <tr>
                <td>Enter Email:</td>
                <td><input type="text" name="userEmail" id="userEmail"></td>
                <td> <input type="submit" value="Send Otp"  /></td>
            </tr>
            
        </table>
        <center></center>
    </form>
    
    <c:if test="${checkOtp==true}">
    <form action="verifyOtp" id="otpForm" >
        <table>
            <tr>
                <td>Enter Otp:</td>
                <td><input type="text" name="otp"></td>
                <td> <input type="submit" value="Submit" /></td>
            </tr>
            
        </table>
        <center></center>
    </form>
    <form action="sendOtp">
        <table>
            <tr>
                <td></td>
                <td><input type="hidden" name="userEmail" id="userEmail" value="${userEmail}"></td>
                <td> <input type="submit" value="Resend Otp"  /></td>
            </tr>
            
        </table>
        <center></center>
    </form>
    </c:if>
   <br>
   <a href="userSignup">Signup</a>
   <a href="userLogin">Login</a>
	
</div>
<script>

function showOtp(){
    let otpSuccess=document.getElementById("otpSuccess").innerText;
    let otpFailed=document.getElementById("otpFailed").innerText;
    if(otpSuccess.length>5 || otpFailed.length>5){
        //document.getElementById("otpForm").style.display="none";
        document.getElementById("emailForm").style.display="none";
        //document.getElementById("resendOtpForm").style.display="block";
    }
}
showOtp()
</script>     
</body>
</html>