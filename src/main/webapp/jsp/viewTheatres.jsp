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
<a id="theatres" href="viewTheatres" onclick="selectTab('theatres');" class="admin-home-left-container-options" 
>View Theatres</a>
    </div>
    <div class="admin-home-right-container">
        <div style="margin-left:10% ;">
    <span style="border:1px ; color:green">${theatreApproveSuccess}</span>
    <span style="border:1px ; color:red">${theatreDisApproveSuccess}</span>
    <h2>Theatres</h2>
    <br>
    <table border="1px" id="theatres" >
    <tr>
        <td>Id</td>
        <td>Theatre Name</td>
        <td>Theatre City</td>
        <td>Approve/DisApprove</td>
        <td>Delete</td>
    </tr>
    <c:forEach var="theatre" items="${theatres}">
        <tr>
            <td>${theatre.theatreId}</td>
            <td>${theatre.theatreName}</td>
            <td>${theatre.theatreCity.cityName}</td>
            <c:choose>
                <c:when test="${theatre.theatreApproval!=true}">
                    <td><a href="approveTheatre?id=${theatre.theatreId}" style="text-decoration:none"><button>Approve</button></a></td>
                    <td><a href="deleteTheatreByAdmin?id=${theatre.theatreId}" style="text-decoration:none"><button>Delete</button></a></td>
                </c:when>    
                <c:otherwise>
                    <td><a href="disApproveTheatre?id=${theatre.theatreId}" style="text-decoration:none"><button>DisApprove</button></a></td>
                </c:otherwise>
            </c:choose>
            <!-- <td><a href="approveCustomer?id=${customer.customerId}" style="text-decoration:none"><button>Approve</button></a></td> -->
        </tr>
    </c:forEach>
    </table>
</div>
</div>
    <!-- <script>
        function showTheatres(){
            document.getElementById("theatres").style.display="block";
        }
    </script> -->
</body>
</html>