<%@ page language="java" contentType="text/html; charset=ISO-8859-1"

    pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<%@ page import="com.mtb.theatre.model.TheatreCity" %>

<!DOCTYPE html>

<html>

<head>

<meta charset="ISO-8859-1">

<title>Insert title here</title>

<link rel="stylesheet" href="../style.css">

</head>

<body>

   <form action="addNewTheatre" method="post">

        Theatre Name: <input type="text" name="theatreName"/>

        <label for="cars">Choose a City:</label>

        <select name="theatreCity" id="theatreCity">

            <c:forEach var="theatreCity" items="${theatreCity}">

                <option value="${theatreCity.cityName}">${theatreCity.cityName}</option>

            </c:forEach>

        </select>

        <br><br>

        <input type="submit" value="Submit" class="btn">

   </form>

   <br>  

</body>

</body>

</html>