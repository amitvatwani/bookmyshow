<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet"  type="text/css" href="../style.css">
</head>
<body>
<div class="admin-home-main-container">

	<div class="admin-home-left-container">
<div class="admin-home-left-log-container"> <a href="../index" style="text-decoration: none;">Movie Booking</a></div>
<a id="addCity" href="addCityPage" onclick="selectTab('addCity')" class="admin-home-left-container-options" >Add City</a>
<a id="viewCity" href="viewCityPage" onclick="selectTab('viewCity')" class="admin-home-left-container-options" >View City</a>
<a id="movies" href="addMoviePage" onclick="selectTab('movies')" class="admin-home-left-container-options" 
>Add Movies</a>
<a id="showMovies" href="showMovies" onclick="selectTab('viewMovie')" class="admin-home-left-container-options" >View Movie</a>
<a id="theatres" href="viewTheatres" onclick="selectTab('theatres')" class="admin-home-left-container-options" 
>View Theatres</a>

</div>
<div class="admin-home-right-container">
	<span style="color: green;">${movieSuccess}</span>

    <span style="color: red;">${movieFailure}</span><br>
	<span style="color: green;">${success}</span>

    <span style="color: red;">${failed}</span><br>
</div>
</div>
  	
   
 
</body>
<script>
let tabs = ["movies","addCity", "theatre"]
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
</html>