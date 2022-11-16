<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <%@ page import="java.util.*" %>
    <%@ page import="com.mtb.user.model.User" %>
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
                            <c:if test='<%=user.getUserRole().equals("user")%>'>
                                <a href="viewProfile" style="text-decoration: none;color:#00b8f5;margin-top:5%">View Profile</a>
                                <a href="theatreForm" style="text-decoration: none;color:#00b8f5;margin-top:5%">Partner with us</a>
                                <a href="logoutUser"  style="text-decoration: none;color:#00b8f5;margin-top:5%">Logout</a>
                            </c:if>
                            <c:if test='<%=user.getUserRole().equals("theatreOwner")%>'>
                                <a href="viewProfile" style="text-decoration: none;color:#00b8f5;margin-top:5%">View Profile</a>
                                <a href="getAllTheatres" style="text-decoration: none;color:#00b8f5;margin-top:5%">View Theatre</a>
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
                            <c:if test = "${fn:length(movies) > 0}">
                                <h1>Latest Movies</h1>
                            </c:if>
                            <div class="movie-card-holder">
                                <c:forEach var="movie" items="${movies}">
                                    <div class="movie-card">
                                        <div class="movie-card1">
                                            <a class="movie-card2">
                                                <div class="movie-card-img-cont1">
                                                    <img class="movie-poster-img"
                                                        src="${movie.moviePoster}" />


                                                </div>
                                                <div class="movie-card3">
                                                    <div>${movie.movieTitle}</div>
                                                    <div class="movie-card4">
                                                        <span style="margin-left: -22px;"
                                                            class="movie-card-language-div">${movie.movieDescription}</span>
                                                        <div class="movie-card-language-div">${movie.movieLanguage}</div>
                                                        <div class="movie-card-language-div">${movie.movieDuration}</div>
                                                        <div class="movie-card-language-div">${movie.releaseDate}</div>
                                                        <div class="movie-card-language-div">${movie.genre}</div>
                                                    </div>
                                                </div>
                                            </a>
                                        </div>
                                        <form action="selectShows?date=<%=(new java.util.Date())%>" id="selectShows">
                                            <div class="movie-card-6">
                                                <input type="hidden" name="theatreId" value="${theatreId}">
                                                <input type="hidden" name="movieId" value="${movie.movieId}">
                                                <a class="movie-card-7" onclick="submitShowForm()">
                                                    Book Ticket
                                                </a>
                                            </div>
                                        </form>
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

                function submitMovieForm(){
                    let form=document.getElementById("selectMovieTheatres");
                    let cityId = document.getElementById("theatreCityId").value;
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
movieAnchorTag.href = "http://localhost:8080/selectMovieTheatres?movieId="+e.movieId+"&cityId="+document.getElementById("theatreCityId").value
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