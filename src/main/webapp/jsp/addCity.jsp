<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="../style.css">
<style>  
        .error {color:red}  
    </style> 
</head>
<body>

    <div class="admin-home-main-container">

        <div class="admin-home-left-container">
    <div class="admin-home-left-log-container"><a href="index" style="text-decoration: none;">Movie Booking</a></div>
         
    <a id="addCity" href="addCityPage" onclick="selectTab('addCity')" class="admin-home-left-container-options" >Add City</a>
	<a id="viewCity" href="viewCityPage" onclick="selectTab('viewCity')" class="admin-home-left-container-options" >View City</a>
	<a id="movies" href="addMoviePage" onclick="selectTab('movies')" class="admin-home-left-container-options" 
>Add Movies</a>
<a id="showMovies" href="showMovies" onclick="selectTab('viewMovie')" class="admin-home-left-container-options" >View Movie</a>
<a id="theatres" href="viewTheatres" onclick="selectTab('theatres')" class="admin-home-left-container-options" 
>View Theatres</a>

    </div>
    <div class="admin-home-right-container">
        <div style="margin-left:10% ;" id="tab-addCity">
            <span style="border:1px; background-color: rgb(171, 254, 171); border-radius: 0.5rem;";>${success}</span>
   
            <h2>Add City</h2>
            <br>
   
    <form action="addCity">

    <table>
        <tr>
            <td>city name:</td>
            <td><input type="text" name="cityName"/></td>
        </tr>
        <tr>
            <td>State:</td>
            <td><input type="text" name="state"/></td>
        </tr>
        <tr>
            <td>zipcode:</td>
            <td><input type="text" name="zipcode"/></td>
        </tr>
    </table> 
    
    <input type="submit" value="Add City" class="btn"/>
   </form>
        </div>
    </div>
    </div>
          
       
     
    </body>
    <script>
    document.getElementById("addCity").classList.add("admin-home-left-container-options-selected");
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
    selectTab('addCity')
    </script>

    

   <br>
   
      
</body>
</html>