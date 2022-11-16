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
    <div class="admin-home-left-log-container"><a href="../index" style="text-decoration: none;color:white">Movie Booking</a></div>
    <form:form action="updateProfile" modelAttribute="user">
    <table>
        <tr>
            <td>
                Username :
            </td>
            <td>
                <form:input type="text" path="userName" value="${user.userName}" id="userName" disabled="true" /><br>
                <form:errors path="userName" cssClass="error" />
            </td>
        </tr>
        <tr>
            <td>
                Mobile:
            </td>
            <td>
                <form:input type="text" path="userMobile" value="${user.userMobile}" id="userMobile" disabled="true"/><br>
                <form:errors path="userMobile" cssClass="error" />
            </td>
        </tr>
        <tr>
            <td>
                Email:
            </td>
            <td>
                <form:input type="text" path="userEmail" value="${user.userEmail}" id="userEmail" disabled="true"/><br>
                <span style="color:red">${userExists}</span>
                <form:errors path="userEmail" cssClass="error" />
            </td>
        </tr>
        <tr>
            <td>
                Password:
            </td>
            <td >
                <form:input type="text" path="userPassword" id="password" value="${user.userPassword}" disabled="true"/><br>
                <span id='message' style="word-wrap: break-word;width: 20%"></span>
                <form:errors path="userPassword" cssClass="error" />
            </td>
        </tr>
        <tr id="confirmPasswordTag" style="display:none ;">
            <td>
                Confirm Password:
            </td>
            <td>
                <input type="hidden" id="confirmPassword" onkeyup="check()"/>
            </td>
        </tr>
    </table>
    
    <input type="hidden" value="Update Profile"  id="submitButton"/>
   </form:form>
   <button id="updateButton" onclick="editProfile()">Update Profile</button>
   <a href="logoutUser" style="text-decoration: none;"><button id="logout" type="submit">Logout</button></a>
<script>
    function editProfile(){
        document.getElementById("updateButton").style.display="none";
        document.getElementById("submitButton").type="submit";
        document.getElementById("userName").disabled=false;
        document.getElementById("userEmail").disabled=false;
        document.getElementById("userMobile").disabled=false;
        document.getElementById("password").disabled=false;
        document.getElementById("confirmPassword").type="text";
        document.getElementById("confirmPasswordTag").style.display="table-row";
    }

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