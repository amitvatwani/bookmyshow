<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="ISO-8859-1">
                <title>Insert title here</title>
                <link rel="stylesheet" href="../style1.css">
                <link rel="stylesheet" href="../styles.css">
            </head>
            <style>
                .box {
                    display: flex;
                    justify-content: center;
                    align-items: center;
                    width: 100vw;
                    height: 100vh;
                    background: #000;
                }

                .container {
                    height: 15px;
                    width: 105px;
                    display: flex;
                    position: relative;
                }
                .container .square {
                    width: 15px;
                    height: 15px;
                    background-color: #fff;
                    animation: move 500ms linear 0ms infinite;
                    margin-right: 30px;
                }
                .container .square:first-child {
                    position: absolute;
                    top: 0;
                    left: 0;
                    animation: grow 500ms linear 0ms infinite;
                }
                .container .square:last-child {
                    position: absolute;
                    top: 0;
                    right: 0;
                    margin-right: 0;
                    animation: grow 500ms linear 0s infinite reverse;
                }
                @keyframes grow {
                    from {
                        transform: scale(0, 0);
                        opacity: 0;
                    }
                    to {
                        transform: scale(1, 1);
                        opacity: 1;
                    }
                }
                @keyframes move {
                    from {
                        transform: translateX(0px);
                    }
                    to {
                        transform: translateX(45px);
                    }
                }
            </style>
            <body>
                <div class="box" style="display: none;">
                    <div class="container">
                      <span class="square"></span>
                      <span class="square"></span>
                      <span class="square"></span>
                      <span class="square"></span>
                    </div>
                  </div>
                <div class="view-screen-main-container">
                    <span id="message-show-bar"></span>
                    <div id="myModal" class="modal-general">

                        <!-- Modal content -->
                        <div class="modal-content">
                            <span class="close">&times;</span>
                            <div class="add-seat-heading"></div>
                            <div class="modal-content-div-show"></div>
                            <div id="modal-button-div">
                                <div onclick="" class='modal-submit-button'></div>
                            </div>
                        </div>

                    </div>
                    <div class="view-screen-navbar">

                        <div class="theatre-name-heading"><a style="text-decoration: none;" href="getAllTheatres"><img src="../left-arrow.png" width="25"
                                class="delete-img" alt="back icon"></a><span>Theatre
                                Screen Name :
                                ${screen.screenName}</span></div>
                        <div class="seat-insert-submit-button" onclick="openModal('','','','','add')">Add Show</div>
                    </div>
                    <div class="view-screen-display-container">


                        <c:forEach var="show" items="${shows}">
                            <div class="view-screen-single-div">
                                <div class="screen-name-div">Show Date : ${show.showDate}</div>
                                <div class="screen-name-div">Show Start Time : ${show.startTime}</div>
                                <div class="screen-name-div">Show End Time : ${show.endTime}</div>
                                <div class="screen-options-div">
                                    <img onclick="openModal('${show.showId}','${show.showDate}','${show.startTime}','${show.endTime}','delete')"
                                        id="delete-img" src="../delete.png" class="delete-img" width="25"
                                        alt="delete icon">
                                    <img onclick="openModal('${show.showId}','${show.showDate}','${show.startTime}','${show.endTime}','edit')"
                                        src="../edit.png" class="delete-img" width="25" alt="edit icon">
                                </div>
                            </div>



                        </c:forEach>

                    </div>
                </div>
                <script>
                    var modal = document.getElementById("myModal");
                    let selectedMovie="";
                    // Get the button that opens the modal
                    let showTimings = []
                    let showTimeDetails={}

                    // Get the <span> element that closes the modal
                    var span = document.getElementsByClassName("close")[0];

                    // When the user clicks on the button, open the modal
                    function openModal(showId, showDate, startTime, endTime, type) {
                        let headerDiv = document.getElementsByClassName('add-seat-heading')[0]
                        headerDiv.textContent = type === "delete" ? "Delete Screen" : type === "edit" ? "Edit Screen" : "Add Screen"
                        let contentDiv = document.getElementsByClassName("modal-content-div-show")[0]
                        let buttonComp = document.getElementsByClassName("modal-submit-button")[0]
                        buttonComp.textContent = ""
                        contentDiv.textContent = ""
                        if (type === "delete") {
                            let form  = document.createElement("form")
                            form.setAttribute("action", "deleteShow")
							form.setAttribute("method", "post")
                            let input = document.createElement("input")
                            input.setAttribute("name", "showId")
                            input.value = showId
                            input.setAttribute("type", "hidden")
                            form.appendChild(input)
                            let input1 = document.createElement("input")
                            input1.setAttribute("name", "screenId")
                            input1.value = "${screen.screenId}"
                            input1.setAttribute("type", "hidden")
                            form.appendChild(input1)
                            contentDiv.textContent = `Are you sure want to delete Show `
                            buttonComp.textContent = "Delete Show"
                            contentDiv.appendChild(form)
                            buttonComp.style.backgroundColor = "#F54337"
                            buttonComp.addEventListener("click", () => { form.submit() })
                            // contentDiv.textContent = `Are you sure want to delete screen ` + screenName
                            // buttonComp.textContent = "Delete Screen"
                            // buttonComp.style.backgroundColor = "#F54337"
                            // buttonComp.addEventListener("click", () => { deleteScreen(showId) })

                        } else if (type === "edit") {
                            let form  = document.createElement("form")
                            form.setAttribute("action", "updateShow")
							form.setAttribute("method", "post")
                            let screenId = document.createElement("input")
                            screenId.setAttribute("name", "screenId")
                            screenId.value = "${screen.screenId}"
                            screenId.setAttribute("type", "hidden")
                            form.appendChild(screenId)
                            let input = document.createElement("input")
                            input.setAttribute("name", "showId")
                            input.value = showId
                            input.setAttribute("type", "hidden")
                            form.appendChild(input)
                            let label1 = document.createElement("span")
                            label1.textContent = "Show Date : "
                            let input1 = document.createElement("input")
                            input1.setAttribute("type", "date")
                            input1.setAttribute("min", new Date())
                            input1.setAttribute("name", "showStringDate")
                            let label2 = document.createElement("span")
                            label2.textContent = "Show Start Time : "
                            let input2 = document.createElement("input")
                            input2.setAttribute("name", "startTime")
                            input2.classList.add("modal-general-input")
                            let label3 = document.createElement("span")
                            label3.textContent = "Show End Time : "
                            let input3 = document.createElement("input")
                            input3.setAttribute("name", "endTime")
                            input3.classList.add("modal-general-input")
                            form.appendChild(label1)
                            form.appendChild(input1)
                            form.appendChild(label2)
                            form.appendChild(input2)
                            form.appendChild(label3)
                            form.appendChild(input3)
                            contentDiv.appendChild(form)
                            buttonComp.textContent = "Edit Show"
                            buttonComp.addEventListener("click", ()=>{
                                form.submit()
                            })

                        } else if (type === "add") {
                            "<c:forEach var='movie' items='${movies}'>"
                                var movieCard = document.createElement("div")
                                movieCard.setAttribute("id", "${movie.movieId}")
                                movieCard.classList.add("movie-card-show")
                                if(selectedMovie === "${movie.movieId}"){
                                    movieCard.style.boxShadow = "0px 3px 10px 2px #444"
                                }
                                var moviePoster = document.createElement("img")
                                moviePoster.setAttribute("src", "${movie.moviePoster}")
                                moviePoster.setAttribute("alt", "${movie.moviePoster}")
                                moviePoster.classList.add("movie-poster-img")
                                var movieDetails = document.createElement("div")
                                movieDetails.classList.add("movie-details")
                                movieDetails.textContent = "${movie.movieTitle}"
                                movieCard.addEventListener("click", ()=>{
                                    selectMovie("${movie.movieId}")
                                })
                                movieCard.appendChild(moviePoster)
                                movieCard.appendChild(movieDetails)
                                contentDiv.appendChild(movieCard)
                            "</c:forEach>"
                            buttonComp.textContent = "Next"
                            
                            buttonComp.addEventListener("click",selectedMovie!==""?displayShowForm:showMessage("select a movie", "#F54337"))


                        }
                        modal.style.display = "block";
                    }

                    // When the user clicks on <span> (x), close the modal
                    span.onclick = function () {
                        modal.style.display = "none";
                    }

                    // When the user clicks anywhere outside of the modal, close it
                    window.onclick = function (event) {
                        if (event.target == modal) {
                            modal.style.display = "none";
                        }
                    }
                    function displayShowForm(){
                        let buttonComp = document.getElementsByClassName("modal-submit-button")[0]
                        buttonComp.removeEventListener("click", displayShowForm)
                        buttonComp.textContent="Submit"
                        buttonComp.addEventListener("click", submitForm)
                        let contentDiv = document.getElementsByClassName("modal-content-div-show")[0]
                        contentDiv.textContent = ""
                        let div = document.createElement("div")
                        div.classList.add("formDiv")
                        let label1 = document.createElement("label")
                        label1.textContent = "Date from : "
                        let dateFromInput = document.createElement("input")
                        dateFromInput.id = "dateFrom"
                        dateFromInput.setAttribute("type","date")
                        let currentDate = new Date()
                        let yyyy = currentDate.getFullYear()
                        let dd = currentDate.getDate()<10?"0"+currentDate.getDate():currentDate.getDate()
                        let mm = currentDate.getMonth()+1<10?"0"+currentDate.getMonth()+1:currentDate.getMonth()+1
                        let today  = yyyy+"-"+mm+"-"+dd
                        dateFromInput.setAttribute("min",today)
                        let label2 = document.createElement("label")
                        label2.textContent = "Date to : "
                        let dateToInput = document.createElement("input")
                        dateToInput.setAttribute("type","date")
                        dateToInput.setAttribute("min",today)
                        dateToInput.id="dateTo"
                        div.appendChild(label1)
                        div.appendChild(dateFromInput)
                        div.appendChild(label2)
                        div.appendChild(dateToInput)
                        let timingDiv =  document.createElement("div")
                        timingDiv.classList.add("input-div")
                        let label3 = document.createElement("label")
                        label3.textContent = "Starting Time"
                        let startTimeInput = document.createElement("input")
                        startTimeInput.setAttribute("type","text")
                        // startTimeInput.setAttribute("id","start-input")
                        startTimeInput.id ="start-input"
                        let label4 = document.createElement("label")
                        label4.textContent = "End Time"
                        let endTimeInput = document.createElement("input")
                        endTimeInput.setAttribute("type","text")

                        // startTimeInput.setAttribute("id","end-input")
                        endTimeInput.id ="end-input"


                        let addShowDetailBtn = document.createElement("button")
                        addShowDetailBtn.textContent ="add timing"
                        addShowDetailBtn.addEventListener("click",()=>{
                            addShowDetails()
                        })
                        let timingShowDiv = document.createElement("div")
                        timingShowDiv.id = "timing-div"
                        timingShowDiv.style.display = "flex"
                        timingShowDiv.style.flexDirection = "column"
                        timingShowDiv.style.padding = "5%"
                        timingDiv.appendChild(label3)
                        timingDiv.appendChild(startTimeInput)
                        timingDiv.appendChild(label4)
                        timingDiv.appendChild(endTimeInput)
                        //timingDiv.appendChild(timingShowDiv)
                        timingDiv.appendChild(addShowDetailBtn)

         
                        
                        contentDiv.appendChild(div)
                        contentDiv.appendChild(timingDiv)
                        contentDiv.appendChild(timingShowDiv)
                    }
                    function submitForm(){
                        document.getElementsByClassName("modal-content")[0].style.display = "none"
                        document.getElementsByClassName("box")[0].style.display = "flex"
                        let fromDate = document.getElementById("dateFrom").value
                        let endDate = document.getElementById("dateTo").value
                        showTimeDetails = {
                            movieId:selectedMovie,
                            screenId: "${screen.screenId}",
                            fromDate,
                            endDate,
                            timings: showTimings
                        }
                        //console.log(showTimeDetails);
                        const options={
                            method:"POST",
                            headers:{
                                "Content-Type":"application/json"
                            },
                            body:JSON.stringify(showTimeDetails)
                        }
                        fetch("http://localhost:8080/theatre/addShow", options)
                        .then(res=>{
                            document.getElementsByClassName("box")[0].style.display = "none"
                            //history.back()
                            let contentDiv = document.getElementsByClassName("modal-content-div-show")[0]
                            let form = document.createElement("form")
                            let screenId = document.createElement("input")
                            screenId.setAttribute("name", "screenId")
                            screenId.value = "${screen.screenId}"
                            screenId.setAttribute("type", "hidden")
                            form.appendChild(screenId)
                            form.setAttribute("action", "displayShowPage")
                            contentDiv.appendChild(form)
                            form.submit()
                        })
                    }
                    function selectMovie(movieId){
                        selectedMovie=movieId
                        console.log(selectedMovie)
                        openModal('','','','','add')
                    }
                    function addShowDetails(){
                        let startTime = document.getElementById("start-input").value
                        let endTime = document.getElementById("end-input").value
                        let showDetail = {
                            startTime,
                            endTime
                        }
                        showTimings.push(showDetail)
                        if(startTime!=="" && endTime!==""){
                        let showDiv  = document.getElementById("timing-div")
                        showDiv.textContent = ""
                        showTimings.map((e)=>{
                        var timeDiv = document.createElement("div")
                        timeDiv.style.display = "flex"
                        timeDiv.style.justifyContent = "space-evenly"
                        var span1 = document.createElement("span")
                        var span2 = document.createElement("span")
                        span1.textContent = "Starting Time : " + e.startTime
                        span2.textContent = "End Time : " + e.endTime
                        timeDiv.appendChild(span1)
                        timeDiv.appendChild(span2)
                        showDiv.appendChild(timeDiv)
                        })
                        console.log(showTimings);
                        }else{
                        showMessage("input must be filled", "#F54337")
                        }
                        
                    }
                    const addScreen = () => {
                        let input1Value = document.getElementsByClassName("modal-general-input")[0].value
                        let input2Value = document.getElementsByClassName("modal-general-input")[1].value

                        if (input1Value.length > 0 && input2Value.length > 0) {
                            let form = document.createElement("form")
                            form.append("screenName", input1Value)
                            form.append("totalSeats", input1Value)
                            const request = new XMLHttpRequest();
                            request.open("POST", "http://localhost:8080/addScreen");
                            request.send(formData);
                        } else {
                            showMessage("input must be filled", "#F54337")
                        }
                    }
                    const deleteScreen = (showId) => {
                        let form = document.createElement("form")
                        form.append("showId", showId)
                        const request = new XMLHttpRequest();
                        request.open("POST", "http://localhost:8080/deleteScreen");
                        request.send(formData);
                    }
                    const edit = (showId) => {
                        let input1Value = document.getElementsByClassName("modal-general-input")[0].value
                        let input2Value = document.getElementsByClassName("modal-general-input")[1].value

                        if (input1Value.length > 0 && input2Value.length > 0) {
                            let form = document.createElement("form")
                            form.append("screenName", input1Value)
                            form.append("totalSeats", input1Value)

                            const request = new XMLHttpRequest();
                            request.open("POST", "http://localhost:8080/updateScreen");
                            request.send(formData);
                        } else {
                            showMessage("input must be filled", "#F54337")
                        }
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
                    "<c:if test = '${fn:length(deleteShowSuccess) > 0}'>"
                        showMessage("${deleteShowSuccess}", "#F54337")
                    "</c:if>"
                    "<c:if test = '${fn:length(updateShowSuccess) > 0}'>"
                        showMessage("${updateShowSuccess}", "#4DAE50")
                    "</c:if>"
                    "<c:if test = '${fn:length(addShowSuccess) > 0}'>"
                        showMessage("${addShowSuccess}", "#4DAE50")
                    "</c:if>"
                    
                    
                </script>


            </body>

            </html>