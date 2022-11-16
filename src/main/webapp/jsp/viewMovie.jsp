<%@ page language="java" contentType="text/html; charset=ISO-8859-1"

    pageEncoding="ISO-8859-1"%>

<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>

<%@ page import="com.mtb.movie.model.Movie" %>

<!DOCTYPE html>

<html>

<head>

<meta charset="ISO-8859-1">

<title>Insert title here</title>

<link rel="stylesheet" href="style.css">

</head>

<body>



       

        <label for="cars">Choose a City:</label>

        

            <c:forEach var="movie" items="${movies}">
		${movie.movieTitle}
		<img src="${movie.moviePoster}" />
                

            </c:forEach>

        

        


   <br>  

</body>

</body>

</html>