<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="ISO-8859-1">
            <title>Insert title here</title>
            <link rel="stylesheet" href="../seatLayout.css">

        </head>

        <body>
            <div class="seat-main-div">
                <span id="message-show-bar"></span>

                <div class="view-screen-navbar">
                    <div class="theatre-name-heading"><img onclick="history.back()" src="../left-arrow.png" width="25"
                            class="delete-img" alt="back icon"> <span>Theatre
                            Name :
                            ${singleShow.theatreScreen.theatre.theatreName}</span></div>
                    <div class="show-display">
                        <div class="date-display-div"></div>
                        <div class="show-bar-display">
 			
                        </div>
                    </div>
                    <div class="catalog-display">
                        <span class="active-seat-catalog"></span> :
                        <span>Available</span>
                        <span class="booked-seat-catalog"></span> :
                        <span> Booked</span>
                    </div>
                </div>
                <div class="seat-div" id="seats-container">

                </div>
                <div class="image-main-container">
                    <img class="img-tag" width={300}
                        src="https://assetscdn1.paytm.com/movies_new/_next/static/media/screen-icon.8dd7f126.svg"
                        alt="scs" />
                    <!-- <div class='seat-insert-submit-button' onclick="submit()">submit</div> -->

                </div>
                <div class="bottom-tab-maincont">
                    <div class="seat-number-display-div">
                        <span class="seat-count-display"></span>
                        <span class="seat-number-display"></span>
                    </div>
                    <div class="book-ticket-btn-container">
                        <div onclick="bookticket()" class='seat-insert-submit-button' style="width: 200px;">Book Tickets</div>
                    </div>
                </div>
            </div>
        </body>
        <script>
            function bookticket(){
                let seatToBeShared = [];
                data.map((e)=>{
                    if(Array.from(selectedSeat).includes(e.seatNumber)){
                        seatToBeShared.push(e.showSeatId);
                    }
                })
                const options = {
                    method:"post",
                    headers: {
                        'Content-Type': 'application/json',
                    },
                    body:JSON.stringify(seatToBeShared)
                }
                fetch("http://localhost:8080/ticket/bookTicket", options)
                .then(res=>{
                    let contentDiv = document.getElementsByClassName("show-display")[0]
                    let form = document.createElement("form")
                    form.setAttribute("action", "ticket/showTicketPage")
                    let input1 = document.createElement("input")
                    input1.setAttribute("type", "hidden")
                    input1.setAttribute("name", "movieId")
                    input1.value="${movie.movieId}"
                    form.append(input1)
                    let input2 = document.createElement("input")
                    input1.setAttribute("type", "hidden")
                    input2.setAttribute("name", "showId")
                    input2.value="${singleShow.showId}"
                    form.append(input2)
                    let input3 = document.createElement("input")
                    input1.setAttribute("type", "hidden")
                    input3.setAttribute("name", "date")
                    input3.value="${date}"
                    form.append(input3)
                    contentDiv.appendChild(form)
                    form.submit()
                })
            }
            let data = []
            let seatDetails = []
            let gapSeat = new Set()
            let seats = new Set()
            let bookedSeats = []
            let selectedSeat = new Set();
            let n;
		let date = "<c:out value='${singleShow.showDate}' />"
		let showDate = date.split(" ")[0]
		let dateTag = document.getElementsByClassName("date-display-div")[0]
		dateTag.textContent = showDate
            "<c:forEach var = 'show' items='${singleShow.showSeats}'>"

            n = {
                showSeatId: "<c:out value='${show.seatId}' />",
                status: "<c:out value='${show.status}' />",
                seatNumber: "<c:out value='${show.theatreSeat.seatNumber}' />",
                seatType: "<c:out value='${show.theatreSeat.seatType}' />",
                seatPrice: "<c:out value='${show.theatreSeat.price}' />",
            }
            data.push(n)
            "</c:forEach>"
            console.log(data)
		let showBar = document.getElementsByClassName("show-bar-display")[0]
		"<c:forEach var='show' items='${shows}'>"
			var span = document.createElement("a")
            span.style.textDecoration = "none"
			if("${show.showId}"==="${singleShow.showId}"){
				span.classList.add("show-bar-single-selected")
			}else{
				span.classList.add("show-bar-single")
			}
                             span.textContent = "${show.startTime}"                  
                            span.href = "http://localhost:8080/getSeatLayout?movieId=${show.movie.movieId}&showId=${show.showId}&date=${date}"
                           showBar.appendChild(span)
			"</c:forEach>"
            const showMessage = (message, color) => {
                let messageSpan = document.getElementById("message-show-bar")
                messageSpan.textContent = message
                messageSpan.style.backgroundColor = color
                messageSpan.style.display = "inline"
                setTimeout(hideMessage, 3000)
            }
            const hideMessage = () => {
                let messageSpan = document.getElementById("message-show-bar")
                messageSpan.style.display = "none"
            }
            "<c:if test = '${fn:length(seatsBooked) > 0}'>"
                showMessage("${seatsBooked}", "#F54337")
            "</c:if>"
            if (data.length > 0) {

                let seatTypes = new Set()
                data.map((e) => {

                    if (e.seatNumber.split("-")[1]) {
                        seatTypes.add(e.seatNumber.split("-")[1])
                    }
                    if (e.seatNumber.split("-")[2] && e.seatNumber.split("-")[2] === "gap") {
                        gapSeat.add(e.seatNumber.split("-")[0] + "-" + e.seatNumber.split("-")[1]);
                    } else {
                        seats.add(e.seatNumber.split("-")[0] + "-" + e.seatNumber.split("-")[1])
                    }
                    if (e.status === "booked" || e.status==="blocked") {
                        bookedSeats.push(e.seatNumber)
                    }
                })
                // console.log(seatTypes);
                Array.from(seatTypes).map((type) => {
                    let price;
                    let rows = new Set();
                    let typeSeat = new Set()
                    data.map((e, k) => {

                        if (e.seatNumber.split("-")[1] === type) {
                            typeSeat.add(e)
                            rows.add(e.seatNumber.split("-")[0].split(`${k}`)[0])
                        }
                        
                        if(e.seatPrice != 0)
                            price=e.seatPrice
                        
                    })
                    // console.log(rows);
                    let columns = typeSeat.size / rows.size
                    let detail = {
                        rows: rows.size,
                        columns,
                        seatType: type,
                        seatPrice:price
                    }
                    seatDetails.push(detail)
                    console.log(seatDetails)
                })


                showSeats()
            }

            


            function showSeats() {


                let string = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"


                let seatDiv = document.getElementById("seats-container")
                seatDiv.textContent = ""


                seatDetails.map((seat) => {
                    let firstDiv = document.createElement("div")
                    firstDiv.classList.add("first-div")
                    let secondDiv = document.createElement("div")
                    secondDiv.classList.add("second-div")
                    let firstSpan = document.createElement("span")
                    firstSpan.textContent = seat.seatType + ": "
                    let secondSpan = document.createElement("span")
                    secondSpan.textContent = seat.seatPrice
                    secondDiv.appendChild(firstSpan)
                    secondDiv.appendChild(secondSpan)
                    firstDiv.appendChild(secondDiv)
                    seatDiv.appendChild(firstDiv)

                    let ul = document.createElement("ul")
                    ul.classList.add("seat-ul")
                    let seatIndex = 1
                    for (let i = 0; i < seat.rows; i++) {
                        let charSpan = document.createElement("span")
                        charSpan.textContent = string.charAt(i)
                        let li = document.createElement("li")
                        li.classList.add("seat-li")
                        charSpan.classList.add("char-span")
                        li.appendChild(charSpan)

                        for (let j = 0; j < seat.columns; j++) {

                            let seatNumber = (string.charAt(i) + (j + 1)) + "-" + seat.seatType
                            if (!Array.from(gapSeat).includes(seatNumber)) {
                                seats.add(seatNumber)
                                let span = document.createElement("span")
                                if (Array.from(selectedSeat).includes(seatNumber)) {
                                    span.classList.remove("active-seat")
                                    span.classList.add("selected-seat")
                                    span.textContent = seatIndex
                                    span.style.color = "white"
                                    seatIndex++
                                    span.addEventListener('click', () => {

                                        addToSelectedSeat(seatNumber)

                                    })
                                }
                                else if (bookedSeats.includes(seatNumber)) {
                                    span.classList.add("booked-seat")
                                } else {
                                    span.classList.remove("selected-seat")
                                    span.classList.add("active-seat")
                                    span.addEventListener('click', () => {
                                        if (selectedSeat.size < 10) {
                                            addToSelectedSeat(seatNumber)
                                        } else {
                                            showMessage("Maximum 10 seats can be selected", "#F54337")
                                        }
                                    })

                                }


                                // span.classList.add("active-seat")


                                li.appendChild(span)
                            } else if (Array.from(gapSeat).includes(seatNumber)) {
                                let span = document.createElement("span")

                                span.classList.add("gap-seat")

                                li.appendChild(span)
                            }


                        }
                        ul.appendChild(li)
                        seatDiv.appendChild(ul)

                    }
                })

            }

            const addToSelectedSeat = (seatNumber) => {
                if (!Array.from(selectedSeat).includes(seatNumber)) {
                    selectedSeat.add(seatNumber)
                } else {
                    selectedSeat.delete(seatNumber)
                }

                console.log(selectedSeat);
                showSeats()
                if (selectedSeat.size > 0) {
                    showBottomTab()
                } else {
                    let bottomTab = document.getElementsByClassName("bottom-tab-maincont")[0]
                    bottomTab.style.display = "none"
                }
            }

            const showBottomTab = () => {
                let bottomTab = document.getElementsByClassName("bottom-tab-maincont")[0]
                bottomTab.style.display = "flex"

                let seatsDisplayDiv = document.getElementsByClassName("seat-number-display-div")[0]
                let countSpan = document.getElementsByClassName("seat-count-display")[0]
                let numberDisplay = document.getElementsByClassName("seat-number-display")[0]
                if (selectedSeat.size === 1) {
                    countSpan.textContent = "1 seat selected : "
                } else {
                    countSpan.textContent = selectedSeat.size + " seats selected : "
                }
                if (seatDetails.length > 1) {
                    numberDisplay.textContent = Array.from(selectedSeat).join(", ")
                } else {
                    let seatMap = Array.from(selectedSeat).map((e) => {
                        return e.split("-")[0]
                    })
                    numberDisplay.textContent = seatMap.join(", ")
                }
            }



        </script>

        </html>