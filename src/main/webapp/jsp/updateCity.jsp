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
            <h2>${city.cityName}</h2>
  
    
        <form action="updateCity">
            <input type="hidden" name="cityId" value="${city.cityId}" id="">
            <table>
                <tr>
                    <td> City Name:</td>
                    <td> <input type="text" name="cityName" value="${city.cityName}"></td>
                </tr>
                <tr>
                    <td>State:</td>
                    <td><input type="text" name="state" id="" value="${city.state}"></td>
                </tr>
                <tr>
                    <td>Zipcode:</td>
                    <td><input type="text" name="zipcode" id="" value="${city.zipcode}"></td>
                </tr>
                
            </table>             
            <input type="submit" name="" value="Update City">
        </form>
   
    </div></div>
</body>
<script>
    document.getElementById("viewCity").classList.add("admin-home-left-container-options-selected");
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