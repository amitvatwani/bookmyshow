<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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

        <div style="margin-left: 10%;">

            <h2>Add Movies</h2><br>
        <form:form action="addMovie" modelAttribute="movie">
        <table>
            <tr>
                <td>Movie Title</td>
                <td><form:input type="text" path="movieTitle" id=""/></td>
                <td><form:errors path="movieTitle" cssClass="error"/></td>
            </tr>
            <tr>
                <td>Movie Description</td>
                <td><form:input type="text" path="movieDescription" id=""/></td>
                <td><form:errors path="movieDescription" cssClass="error"/></td>
            </tr>

            <tr>
                <td>Movie Duration</td>
                <td><form:input type="text" path="movieDuration" id=""/></td>
                <td><form:errors path="movieDuration" cssClass="error"/></td>
            </tr>
            <tr>
                <td>Movie Poster</td>
                <td><form:input type="text" path="moviePoster" id=""/></td>
            </tr>

            <tr>
                <td>Movie Language</td>
                <td><form:input type="text" path="movieLanguage" id=""/></td>
                <td><form:errors path="movieLanguage" cssClass="error"/></td>
            </tr>
            <tr>
                <td>Release Date</td>
                <td><form:input type="date" path="releaseDate" id=""/></td>
                <td><form:errors path="releaseDate" cssClass="error"/></td>
            </tr>
            <tr>
                <td>Country</td>
                <td><form:input type="text" path="country" id=""/></td>
                <td><form:errors path="country" cssClass="error"/></td>
            </tr>
            <tr>
                <td>Genre</td>
                <td><form:input type="text" path="genre" id=""/></td>
                <td><form:errors path="genre" cssClass="error"/></td>
            </tr>
        </table>
        <input type="Submit" value="Add movie">
    </form:form>
    </div>
    </div>
    
    <script>
        document.getElementById("movies").classList.add("admin-home-left-container-options-selected");
        let tabs = ["movies","addCity","showMovies","theatre"]
            function selectTab(e){
            tabs.map((tab)=>{
                if(tab===e){
                    document.getElementById(e).classList.add("admin-home-left-container-options-selected");
                }else{
                    document.getElementById(tab).classList.remove("admin-home-left-container-options-selected");	
                }
        });	
        }
        </script>
</body>
</html>