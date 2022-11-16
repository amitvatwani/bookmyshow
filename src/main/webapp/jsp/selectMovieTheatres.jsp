<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <%@ page import="com.mtb.user.model.User" %>
    <%@ page import="com.mtb.movie.model.Shows" %>
    <%@ page import="java.util.*" %>
    <%@ page import="java.util.Calendar" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@page import="java.text.SimpleDateFormat"%>
    
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="ISO-8859-1">
            <title>Insert title here</title>
            <link rel="stylesheet" href="styles1.css">

        </head>

        <body>
            <%
	            User user = (User)session.getAttribute("user");
	        %>
            <div class="home-main-cont">
                <span id="message-show-bar"></span>
                <div class="sidebar-background"></div>
                <div class="home-sidebar">
                    <span class="sidebar-close" onclick="closeSidebar()">&times;</span>
                    <div class="userLogo-div">
                        <c:if test="<%=user!=null%>">
                            <img width="24px" height="24px" src="user.png" alt="user" /> <p style="margin-top: 3px;">Hi, <%=user.getUserName()%></p>
                        </c:if>
                        
                    </div>
                    <div class="sidebar-items">
                        <c:if test="<%=user!=null%>">
                            <c:if test='<%=user.getUserRole().equals("ROLE_USER")%>'>
                                <a href="viewProfile" style="text-decoration: none;color:#00b8f5;margin-top:5%">View Profile</a>
                                <a href="viewTicketsByUser" style="text-decoration: none;color:#00b8f5;margin-top:5%">My Bookings</a>
                                <a href="theatreForm" style="text-decoration: none;color:#00b8f5;margin-top:5%">Partner with us</a>
                                <a href="logoutUser"  style="text-decoration: none;color:#00b8f5;margin-top:5%">Logout</a>
                            </c:if>
                            <c:if test='<%=user.getUserRole().equals("ROLE_THEATREOWNER")%>'>
                                <a href="viewProfile" style="text-decoration: none;color:#00b8f5;margin-top:5%">View Profile</a>
                                <a href="theatre/getAllTheatres" style="text-decoration: none;color:#00b8f5;margin-top:5%">View Theatre</a>
                                <a href="viewTicketsByUser" style="text-decoration: none;color:#00b8f5;margin-top:5%">My Bookings</a>
                                <a href="logoutUser"  style="text-decoration: none;color:#00b8f5;margin-top:5%">Logout</a>
                            </c:if>
                            <c:if test='<%=user.getUserRole().equals("ROLE_ADMIN")%>'>
                                <a href="viewProfile" style="text-decoration: none;color:#00b8f5;margin-top:5%">View Profile</a>
                                <a href="admin/adminHome" style="text-decoration: none;color:#00b8f5;margin-top:5%">Admin Home</a>
                                <a href="viewTicketsByUser" style="text-decoration: none;color:#00b8f5;margin-top:5%">My Bookings</a>
                                <a href="logoutUser"  style="text-decoration: none;color:#00b8f5;margin-top:5%">Logout</a>
                            </c:if>
                        </c:if>
                    </div>
                </div>
                <div class="home-screen-navbar">
                    <div class="logo-adv-div">
                        <a href="index" style="text-decoration: none;color:#00b8f5"> MovieTicketBooking </a>
                    </div>
                    <div class="login-img-div" id="menuToggle">
                        
                            <c:choose>
                                    <c:when test="<%=user!=null%>">
                                        <!-- <img width="24px" height="24px" src="user.png" alt="user" /> <p style="margin-top: 3px;">Hi, <%=user.getUserName()%></p> -->
                                        <div class="hamburger-div" onclick="showSidebar()">
                                            <span class="hamburger-span"></span>
                                            <span class="hamburger-span"></span>
                                            <span class="hamburger-span"></span>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="login-button-div">
                                            <a href="userLogin" style="text-decoration: none;color:black">Signin</a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            
                        
                    </div>
                </div>
                <div class="home-content-div">
                    <div class="search-bar-div">
                        <div class="upcomin-div">

                        </div>
                        
                        <div class="search-bar-input-cont">
                            
                            
                                <img width="24px" height="24px" src="search.png" alt="search" />
                                <input onkeyup="searchMovies()" class="search-input-tag" name="movieTitle" type="search" placeholder="Search Movie or Theatre" />
                               <div class="search-drop-down" ></div>
                                
                        </div>
                        
                        <div class="location-select-div">
                            <div class="location-drop-down">
                                <img width="24px" height="24px" src="location.png" alt="search" />
                                <form action="moviesByCity" id="cityForm">
                                <select class="search-input-tag" value="${cityId}"  name="theatreCityId" id="theatreCityId" onchange="selectCity()">
                                        <option value="${city.cityId}" style="display: none;">${city.cityName}</option>
                                        <c:choose>
                                            <c:when test="${firstLocation==true}">
                                                <c:forEach var="theatreCity" items="${theatreCity}" varStatus="stat">
                                                    <c:if test="${stat.first}">
                                                        <option value="${theatreCity.cityId}" selected> ${theatreCity.cityName}</option>
                                                    </c:if>
                                                    <c:if test="${!stat.first}">
                                                        <option value="${theatreCity.cityId}"> ${theatreCity.cityName}</option>
                                                    </c:if>
                                            </c:forEach>
                                            </c:when>    
                                            <c:otherwise>
                                                <c:forEach var="theatreCity" items="${theatreCity}">
                                                    <option value="${theatreCity.cityId}"> ${theatreCity.cityName}</option>
                                            </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                </select>
                            </form>
                            </div>
                        </div>
                    </div>
                    <div class="movie-content-div">
                        <div class="movie-cards-container">
                            <c:if test = "${fn:length(theatres) > 0}">
                                <h1 class="dateContainer">Theatres in ${city.cityName} showing ${movie.movieTitle}</h1>
                            </c:if>
                            <div class="movie-card-holder-theatre">
                                <c:forEach var="theatre" items="${theatres}">
                                    <div class="theatre-card">
                                        <div class="theatre-card-left">
                                           
                                                
                                                <div class="theatre-card3">
                                                    <div>${theatre.theatreName}</div>
                                                    <div class="theatre-card4">
                                                        <span 
                                                            class="theatre-card-language-div">${theatre.theatreCity.cityName}</span>
                                                        <div class="theatre-card-language-div">${theatre.theatreCity.state}</div>
                                                        <div class="theatre-card-language-div">${theatre.theatreCity.zipcode}</div>
                                                        
                                                    </div>
                                                </div>
                                          
                                        </div>
                                        <div class="theatre-card-right-half">
                                            <c:forEach var="screen" items="${theatre.theatreScreens}">
                                                <c:forEach var="show" items="${screen.shows}">
                                                    <c:forEach var="mov" items="${movie.shows}">
                                                        <c:if test = "${show.showId == mov.showId}">
                                                            <fmt:formatDate value="${show.showDate}" pattern="yyyy-MM-dd" var="parsedDate" />
                                                            <fmt:formatDate value="${date}" pattern="yyyy-MM-dd" var="newParsedDate" />
                                                            <c:if test ="${parsedDate == newParsedDate}">
                                                                     
                                                                <a href="http://localhost:8080/getSeatLayout?movieId=${movie.movieId}&showId=${show.showId}&date=${date}" class="seat-insert-submit-button" style="position:relative;">${show.startTime}</a>
                                                                
                                                            </c:if>
                                                            
                                                        </c:if>
                                                    </c:forEach>
                                            </c:forEach>
                                        </c:forEach>
                                        </div>

                                       

                                    </div>
                                
                                </c:forEach>

                            </div>

                        </div>
                    </div>
                </div>
            </div>
            <script>
                function submitShowForm(){
                    let form=document.getElementById("selectShows");
                    form.submit();
                }
                const hideMessage = () => {
                    let messageSpan = document.getElementById("message-show-bar")
                    messageSpan.style.display = "none"
                }
                const showMessage = (message, color) => {
                    let messageSpan = document.getElementById("message-show-bar")
                    messageSpan.textContent = message
                    messageSpan.style.backgroundColor = color
                    messageSpan.style.display = "inline"
                    setTimeout(hideMessage, 3000)
                }
                "<c:if test = '${fn:length(theatreRequestSuccess) > 0}'>"
                    showMessage("${theatreRequestSuccess}", "#4DAE50")
                "</c:if>"
                function submitTheatreForm(){
                    let form=document.getElementById("selectTheatreMovies");
                    form.submit();
                }
                let today = new Date()
                const endDateNew = new Date()
                endDateNew.setDate(endDateNew.getDate()+2)
                console.log(today)
                console.log(endDateNew)
                let selectedDate = today.getDate()
                let showBar = document.getElementsByClassName("dateContainer")[0]
                let dateDiv = document.createElement("div")
                dateDiv.style.display = "flex"
                function changeSelectedDate(date){
                    dateDiv.textContent = ""
                    selectedDate = date
                    
                    for(let i=today.getDate(); i<=endDateNew.getDate(); i++){
                    
                    var span = document.createElement("a")
                    span.style.textDecoration = "none"
                    span.addEventListener("click", ()=>{
                        changeSelectedDate(i)
                    })
                    if(selectedDate === i){
                        span.classList.add("show-bar-single-selected")
                    }else{
                        span.classList.add("show-bar-single")
                    }
                    span.textContent = i     
                    span.href = "http://localhost:8080/selectMovieTheatresByDate?movieId=${movie.movieId}&cityId=${city.cityId}&date="+i
                    dateDiv.appendChild(span)
                    }
                    showBar.appendChild(dateDiv)
                }
                changeSelectedDate(new Date())
                
			
			
                function submitMovieForm(){
                    let form=document.getElementById("selectMovieTheatres");
                    let cityId = document.getElementById("theatreCityId").value;
                    let date = document.createElement("input")
                    date.setAttribute("name", "date")
                    date.setAttribute("type", "hidden")
                    date.value = "<%=(new java.util.Date())%>"
                    form.append(date)
                    form.append(cityId);
                    form.submit();
                }
                function selectCity(){
                    let form=document.getElementById("cityForm");
                    form.submit();
                }
                function showSidebar(){
                    let sidebar = document.getElementsByClassName("home-sidebar")[0];
                    sidebar.style.display="flex";
                    let sidebarBackground = document.getElementsByClassName("sidebar-background")[0];
                    sidebarBackground.style.display="block";
                }
                function closeSidebar(){
                    let sidebar = document.getElementsByClassName("home-sidebar")[0];
                    sidebar.style.display="none";
                    let sidebarBackground = document.getElementsByClassName("sidebar-background")[0];
                    sidebarBackground.style.display="none";
                }
                window.onclick = function(e){
                    let sidebarBackground = document.getElementsByClassName("sidebar-background")[0];
                    if(e.target===sidebarBackground){
                        sidebar.style.display="none";
                    }
                }
                let data = [{ title: "rorsharch", desciption: '', poster: "https://assetscdn1.paytm.com/images/cinema/Rorschach--705x750-f4efa230-415e-11ed-b907-dd9ee200e946.jpg", language: "malayalam" }]


let searchBarDropDown = document.getElementsByClassName("search-drop-down")[0]
window.onclick = function (event) {
if (event.target != searchBarDropDown) {
searchBarDropDown.style.display = "none"

}
}


function searchMovies(){
let searchInputValue = document.getElementsByClassName("search-input-tag")[0].value

if (searchInputValue.length != "") {


searchBarDropDown.style.display = "flex"
searchBarDropDown.textContent = ""

fetch("http://localhost:8080/searchMoviesAndTheatre/"+searchInputValue,{
method : "GET"
})
.then(res => res.json())
.then(json => {

movies = json.movies
theatres = json.theatres
if (movies != null && movies.length > 0) {
let movieHeading = document.createElement("span")

movies.length === 1 ? movieHeading.textContent = "1 movie found" : movieHeading.textContent = movies.length + " movies found"
movieHeading.classList.add("movie-head-tag")
searchBarDropDown.appendChild(movieHeading)
movies.map((e) => {

let movieDisplayDiv = document.createElement("div")
let movieAnchorTag = document.createElement("a")
movieAnchorTag.style.textDecoration = "none"
movieAnchorTag.href = "http://localhost:8080/selectMovieTheatres?movieId="+e.movieId+"&cityId="+document.getElementById("theatreCityId").value+"&date=<%=(new java.util.Date())%>"
movieAnchorTag.classList.add("movie-search-card")
let anchorImg = document.createElement("img")
anchorImg.classList.add("anchor-img")
anchorImg.setAttribute("src", e.moviePoster)
let titleDiv = document.createElement("div")
titleDiv.classList.add("title-div-anchor")
titleDiv.textContent = e.movieTitle
let br = document.createElement("br")
let languageDiv = document.createElement("div")
languageDiv.classList.add("language-div-anchor")
languageDiv.textContent = e.movieLanguage
titleDiv.appendChild(br)
titleDiv.appendChild(languageDiv)
movieAnchorTag.appendChild(anchorImg)
movieAnchorTag.appendChild(titleDiv)
movieDisplayDiv.appendChild(movieAnchorTag)
searchBarDropDown.appendChild(movieDisplayDiv)
})
} else if ((movies === null && theatres === null) || (movies.length === 0 && theatres.length === 0)) {
searchBarDropDown.style.justifyContent = "center"
searchBarDropDown.textContent = "No results found"

}
if (theatres != null && theatres.length > 0) {
let theatreHeading = document.createElement("span")
theatres.length === 1 ? theatreHeading.textContent = "1 theatre found" : theatreHeading.textContent = theatres.length + " theatres found"


theatreHeading.classList.add("movie-head-tag")
searchBarDropDown.appendChild(theatreHeading)
theatres.map((e) => {

let movieDisplayDiv = document.createElement("div")
let movieAnchorTag = document.createElement("a")
movieAnchorTag.href = "http://localhost:8080/selectTheatreMovies?theatreId="+e.theatreId+"&cityId="+document.getElementById("theatreCityId").value
movieAnchorTag.style.textDecoration = "none"

movieAnchorTag.classList.add("movie-search-card")
let anchorImg = document.createElement("img")
anchorImg.classList.add("anchor-img")
anchorImg.setAttribute("src", "https://in.bmscdn.com/webin/common/icons/qb-venues.png")
anchorImg.style.width = "30px"
anchorImg.style.height = "30px"
let titleDiv = document.createElement("div")
titleDiv.classList.add("title-div-anchor")
titleDiv.textContent = e.theatreName
movieAnchorTag.appendChild(anchorImg)
movieAnchorTag.appendChild(titleDiv)
movieDisplayDiv.appendChild(movieAnchorTag)
searchBarDropDown.appendChild(movieDisplayDiv)
})
}
})


} else {
// let searchBarDropDown = document.getElementsByClassName("search-drop-down")[0]

searchBarDropDown.style.display = "none"
}

} 
            </script>
        </body>

        </html>