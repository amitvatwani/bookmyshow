<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="ISO-8859-1">
    <title>Insert title here</title>
    <link rel="stylesheet" href="styles1.css">

</head>

<body>
    <div class="home-main-cont">
        <!-- <div class="home-sidebar">
            <span class="sidebar-close">&times;</span>
            <div>

            </div>
            <div>

            </div>
        </div> -->
        <div class="home-screen-navbar">
            <div class="logo-adv-div">
                <a href="index"> MovieTicketBooking </a>
            </div>
            <div class="login-img-div">
                <a href="viewProfile">view Profile</a>
                <a href="theatreForm">Partner with us</a>
                <a href="logoutUser">Logout</a>
            </div>
        </div>
        <div class="home-content-div">
            <div class="search-bar-div">
                <div class="upcomin-div">

                </div>
                <form action="searchMoviesAndTheatre">
                <div class="search-bar-input-cont">
                    
                    <br><br>
                        <img width="24px" height="24px" src="search.png" alt="search" />
                        <input class="search-input-tag" name="movieTitle" type="search" placeholder="Search Movie or Theatre" />
                        <input type="submit" name="" id="" value="Search">
                        
                </div>
                </form>
                <div class="location-select-div">
                    <div class="location-drop-down">
                        <img width="24px" height="24px" src="location.png" alt="search" />
                        <form action="moviesByCity" id="cityForm">
                        <select class="search-input-tag" value="${cityId}" placeholder="Select City" name="theatreCityId" id="theatreCityId" onchange="selectCity()">
                                <option value="${city.cityId}" style="display: none;">${city.cityName}</option>
                            <c:forEach var="theatreCity" items="${theatreCity}">
                                
                                <option value="${theatreCity.cityId}"> ${theatreCity.cityName}</option>
                                
                            </c:forEach>
                
                        </select>
                    </form>
                    </div>
                </div>
            </div>
            <div class="movie-content-div">
                <div class="movie-cards-container">
                    <h1>Latest Movies</h1>

                    <div class="movie-card-holder">
                        <c:forEach var="movie" items="${movies}">
                            <div class="movie-card">
                                <div class="movie-card1">
                                    <a class="movie-card2">
                                        <div class="movie-card-img-cont1">
                                            <img class="movie-poster-img"
                                                src="https://assetscdn1.paytm.com/images/cinema/Rorschach--705x750-f4efa230-415e-11ed-b907-dd9ee200e946.jpg" />


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
                                <div class="movie-card-6">
                                    <a class="movie-card-7" href="showMovieTheatres">
                                        Book Ticket
                                    </a>
                                </div>

                            </div>
                        
                        </c:forEach>

                    </div>

                    <div class="movie-card-holder">
                        <c:forEach var="theatre" items="${theatres}">
                            <div class="movie-card">
                                <div class="movie-card1">
                                    <a class="movie-card2">
                                        
                                        <div class="movie-card3">
                                            <div>${theatre.theatreName}</div>
                                            <div class="movie-card4">
                                                <span style="margin-left: -22px;"
                                                    class="movie-card-language-div">${theatre.theatreCity.cityName}</span>
                                                <div class="movie-card-language-div">${theatre.theatreCity.state}</div>
                                                <div class="movie-card-language-div">${theatre.theatreCity.zipcode}</div>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                                <div class="movie-card-6">
                                    <a class="movie-card-7" href="showTheatreMovies">
                                        Book Ticket
                                    </a>
                                </div>

                            </div>
                        
                        </c:forEach>

                    </div>
                        
                        
                            ${theatre.theatreCity.cityName}
                            <br>

                </div>
            </div>
        </div>
    </div>
    <script>
        function selectCity(){
            let form=document.getElementById("cityForm");
            form.submit();
        }
        let data = [{ title: "rorsharch", desciption: '', poster: "https://assetscdn1.paytm.com/images/cinema/Rorschach--705x750-f4efa230-415e-11ed-b907-dd9ee200e946.jpg", language: "malayalam" }]
    </script>
</body>

</html>