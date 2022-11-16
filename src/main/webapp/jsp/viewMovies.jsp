<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="../style.css">
</head>
<body>
    
    <div class="admin-home-main-container">

        <div class="admin-home-left-container">
    <div class="admin-home-left-log-container"><a href="../index" style="text-decoration: none;">Movie Booking</a></div>
         
    <a id="addCity" href="addCityPage" onclick="selectTab('addCity')" class="admin-home-left-container-options" >Add City</a>
	<a id="viewCity" href="viewCityPage" onclick="selectTab('viewCity')" class="admin-home-left-container-options" >View City</a>
	<a id="movies" href="addMoviePage" onclick="selectTab('movies')" class="admin-home-left-container-options" 
>Add Movies</a>
<a id="showMovies" href="showMovies" onclick="selectTab('viewMovie')" class="admin-home-left-container-options" >View Movie</a>
<a id="theatres" href="viewTheatres" onclick="selectTab('theatres')" class="admin-home-left-container-options" 
>View Theatres</a>
    </div>
    <div class="admin-home-right-container">
        <div style="margin-left:10% ;">
            <h2>Movies</h2>
  
    <c:forEach var="x" items="${movies}">
        <form action="updateMoviePage">
           
            <input type="hidden" name="movieId" value="${x.movieId}" id="">
            <table>
                <tr>
                    
                    <h3>${x.movieTitle}</h3> 
                </tr>
                <tr>
                    <td>Movie Description:</td>
                    <td>${x.movieDescription}</td>
                </tr>
                <tr>
                    <td> Movie Duration:</td>
                    <td>${x.movieDuration}</td>
                </tr>
                <tr>
                    <td>Movie Language:</td>
                    <td>${x.movieLanguage}</td>
                </tr>
                <tr>
                    <td>Release Date:</td>
                    <td>${x.releaseDate}</td>
                </tr>
                <tr>
                    <td>Country:</td>
                    <td>${x.country}</td>
                </tr>
                <tr>
                    <td>Genre:</td>
                    <td>${x.genre}</td>
                </tr>
            </table>             
            <input type="submit" name="" value="Update Movie">
        </form>
        <form action="deleteMovie">
            <input type="hidden" name="movieId" value="${x.movieId}" id="">
            <input type="submit" name="" value="Delete Movie">
        </form><br>
        <hr>
    </c:forEach>
    </div>
</div>
</body>
<script>
    document.getElementById("showMovies").classList.add("admin-home-left-container-options-selected");
    let tabs = ["movies","viewCity","addCity","showMovies","theatre"]
        function selectTab(e){
        tabs.map((tab)=>{
            if(tab===e){
                document.getElementById(e).classList.add("admin-home-left-container-options-selected");
                document.getElementById("tab-"+e).display="block";
            }else{
                document.getElementById(tab).classList.remove("admin-home-left-container-options-selected");
                document.getElementById("tab-"+e).display="none";	
            }
    });	
    }

    </script>
</html>