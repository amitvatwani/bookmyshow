<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="ISO-8859-1">
            <title>Insert title here</title>
            <link rel="stylesheet" href="../ticketSuccess.css">
            <script type="text/javascript" src="../jquery.min.js"></script>
            <script type="text/javascript" src="../qrcode.js"></script>
        </head>

        <body>
            <div class="home-main-cont" style="height: 100vh;display: flex;flex-direction: column;">
                <img src="https://i.gifer.com/origin/41/41340ab1a4529c7dd753f03268087e08.gif" style="position:absolute;left:46%;width:200px">
                <a style="text-decoration: none;" href="index"><img src="../left-arrow.png" width="25" class="delete-img-ticket" alt="back icon"></a>
                <div class="ticket-book-main-container">
                    <div class="ticket-left-container">
                        <div class="ticket-container">
                            <div class="ticket-left-half">
                                <img class="ticket-movie-img"
                                    src="${ticket.shows.movie.moviePoster}" />
                                <span class="circle-dot" style="background-color: #2DC2D5;"></span>
                                <span class="circle-dot" style="top: 55px;background-color: #29BFD4;"></span>

                                <span class="circle-dot" style="top: 95px;"></span>
                                <span class="circle-dot" style="top: 135px;"></span>
                                <span class="circle-dot" style="top: 175px;background-color: #20B9D1;"></span>
                                <span class="circle-dot" style="top: 215px;background-color: #1DB7D0;"></span>
                                <div class="ticket-details-container">
                                    <div class="details-cont"><span class="label-tags">MOVIE</span>
                                        <span class="details">${ticket.shows.movie.movieTitle}</span>
                                    </div>
                                    <div class="details-cont-theatre">
                                        <div class="seat-cont">
                                            <span class="label-tags">THEATRE</span>
                                            <span class="details">${ticket.shows.theatreScreen.theatre.theatreName}</span>
                                        </div>
                                        <div class="time-cont">
                                            <span class="label-tags">SCREEN</span>
                                            <span class="details">${ticket.shows.theatreScreen.screenName}</span>
                                        </div>

                                    </div>
                                    <div class="details-cont-theatre">
                                        <div class="seat-cont">
                                            <span class="label-tags">LOCATION</span>
                                            <span class="details">${ticket.shows.theatreScreen.theatre.theatreCity.cityName}</span>
                                        </div>
                                        <div class="time-cont">
                                            <span class="label-tags">DATE</span>
                                            <span class="details">${ticket.shows.showDate}</span>
                                        </div>

                                    </div>
                                    <div class="time-seat-cont">
                                        <div class="seat-cont" id="seat-cont-append">
                                            <span class="label-tags">SEAT</span>
                                        </div>
                                        <div class="time-cont">
                                            <span class="label-tags">TIME</span>
                                            <span class="details">${ticket.shows.startTime}</span>
                                        </div>

                                    </div>


                                </div>
                            </div>
                            <div class="ticket-right-half">
                                <span class="tid-cont">#${ticket.ticketId}</span>
                                <span class="circle-dot-right" style="background-color: #10AFCD;"></span>
                                <span class="circle-dot-right" style="top: 55px;background-color: #0CACCC;"></span>

                                <span class="circle-dot-right" style="top: 95px;background-color: #0AAACA;"></span>
                                <span class="circle-dot-right" style="top: 135px; background-color: #09A8C9;"></span>
                                <span class="circle-dot-right" style="top: 175px;background-color: #08A6C9;"></span>
                                <span class="circle-dot-right" style="top: 215px;background-color: #07A5C8;"></span>
                                <span class="label-tags" style="font-size: 19px;">SEAT</span>

                                <div id="seat-cont-append2" style="display: flex; flex-direction: column;">

                                </div>
                                <div id="qrcode"></div>
                            </div>
                        </div>
                    </div>
                    
                </div>
            </div>
        </body>
        <script>
            let seatType = new Set()
            let price = new Set()
            let paymentOption = "paypal"
            let ticket = {
                seat: [],
            }
            "<c:forEach var='seat' items='${ticket.showSeats}'>"
            var ticketSeat = {
                seatNumber: "<c:out value='${seat.theatreSeat.seatNumber}'/>",
                price: "<c:out value='${seat.theatreSeat.price}'/>",
                type: "<c:out value='${seat.theatreSeat.seatType}'/>",
            }
            ticket.seat.push(ticketSeat)
            "</c:forEach>"
            console.log(ticket);
            ticket.seat.map((e) => {

                seatType.add(e.type)
                price.add(e.price)
            })

            let seatCont = document.getElementById("seat-cont-append")
            let seatCont2 = document.getElementById("seat-cont-append2")

           


            Array.from(seatType).map((e) => {
                let seatTypeSeats = []
                ticket.seat.map((k) => {
                    if (e === k.type) {
                        seatTypeSeats.push(k.seatNumber.split("-")[0])
                    }
                })
                var deatiCont = document.createElement("span")
                deatiCont.classList.add("details")
                deatiCont.style.fontSize = "19px"
                deatiCont.textContent = "(" + e[0].toUpperCase() + ")"


                var spanSeat = document.createElement("span")

                spanSeat.textContent = seatTypeSeats.join(",")
                deatiCont.appendChild(spanSeat)


                seatCont2.appendChild(deatiCont)
            })
            Array.from(seatType).map((e) => {
                let seatTypeSeats = []
                ticket.seat.map((k) => {
                    if (e === k.type) {
                        seatTypeSeats.push(k.seatNumber.split("-")[0])
                    }
                })
                var deatiCont = document.createElement("span")
                deatiCont.classList.add("details")
                deatiCont.style.fontSize = "19px"
                deatiCont.textContent = "(" + e[0].toUpperCase() + ")"


                var spanSeat = document.createElement("span")

                spanSeat.textContent = seatTypeSeats.join(",")
                deatiCont.appendChild(spanSeat)

                seatCont.appendChild(deatiCont);
            })





            // Array.from(seatAlph).map((e, key) => {
            //     let seat = []

            //     ticket.seat.map((k) => {
            //         let seating = k.seatNumber.split("-")[0]
            //         if (e === seating[0]) {
            //             seat.push(k.seatNumber.split("-")[0] + "-" + k.seatNumber.split("-")[1])
            //         }

            //     })

            //     if (seat.length === 1) {
            //         var deatiCont = document.createElement("span")
            //         deatiCont.classList.add("details")
            //         deatiCont.style.fontSize = "19px"
            //         deatiCont.textContent = seat[0]
            //         seatCont.appendChild(deatiCont);

            //     } else {
            //         var deatiCont = document.createElement("span")
            //         deatiCont.classList.add("details")
            //         deatiCont.style.fontSize = "19px"

            //         deatiCont.textContent = seat[0] + " - " + seat[seat.length - 1]


            //         seatCont.appendChild(deatiCont);

            //     }
            //     if (seat.length === 1) {
            //         var deatiCont = document.createElement("span")
            //         deatiCont.classList.add("details")
            //         deatiCont.style.fontSize = "19px"
            //         deatiCont.textContent = seat[0]
            //         seatCont2.appendChild(deatiCont);

            //     } else {
            //         var deatiCont = document.createElement("span")
            //         deatiCont.classList.add("details")
            //         deatiCont.style.fontSize = "19px"

            //         deatiCont.textContent = seat[0] + " - " + seat[seat.length - 1]
            //         seatCont2.appendChild(deatiCont);

            //     }
            // })
            // console.log(seatAlph);
            let qrcode = new QRCode(document.getElementById("qrcode"), {
                width: 100,
                height: 100
            });

            

            function makeCode() {
                var elText = "<c:out value='${ticket.ticketId}'/>"
                qrcode.makeCode(elText);
            }

            makeCode();
        </script>

        </html>