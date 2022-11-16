<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="ISO-8859-1">
            <title>Insert title here</title>
            <link rel="stylesheet" href="../styles.css">
            <link rel="stylesheet" href="../bookTicket.css">
        </head>

        <body>
            <div class="home-main-cont" style="height: 100vh;display: flex;flex-direction: column;">
                <span id="message-show-bar"></span>
                <img onclick="history.back()" src="../left-arrow.png" width="25" class="delete-img-ticket" alt="back icon">
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
                                
                            </div>
                        </div>
                    </div>
                    <div class="ticket-right-container">
                        <div class="payment-form">
                            <div class="select-payment-option-div">
                                <div class="payment-option" onclick="changePaymentMode('paypal')" id="paypal">
                                    <img width="80px"
                                        src="https://cdn.pixabay.com/photo/2018/05/08/21/29/paypal-3384015_1280.png" />

                                </div>
                                <div class="payment-option" onclick="changePaymentMode('credit-card')" id="credit-card">
                                    <img width="80px"
                                        src="https://www.freeiconspng.com/thumbs/credit-card-icon-png/credit-card-black-png-0.png" />

                                </div>
                                <div onclick="changePaymentMode('upi')" class="payment-option" id="upi"> <img
                                        width="80px"
                                        src="https://media.news9live.com/h-upload/2022/03/21/259414-upi.jpg" /></div>
                                <div onclick="changePaymentMode('net-banking')" class="payment-option" id="net-banking">
                                    <img width="80px"
                                        src="https://cdn.iconscout.com/icon/free/png-256/netbanking-credit-debit-card-bank-transaction-32302.png" />

                                </div>

                            </div>
                            <div class="payment-details-div">
                                <div class="payment-details-cont-div">
                                    <div class="details" style="font-size: 19px;">
                                        Payment Summary
                                    </div>
                                    <div class="details" style="margin-top: 10px;">
                                        Tickets Subtotal
                                    </div>
                                    <div class="payment-price">

                                    </div>
                                    <div class="payment-subtotal-div">
                                        <div class="payment-price-column">
                                            <div class="calculation-part">
                                                Total
                                            </div>
                                            <div class="subtotal-part">
                                                ${ticket.totalAmount}
                                            </div>
                                        </div>
                                    </div>
                                    <div class="ticket-seat-display" style="display: flex; justify-content: center;">
                                        <div class="modal-submit-button" style="position: absolute;" onclick="openPaymentPage()">
                                            Pay ${ticket.totalAmount}
                                        </div>
                                    </div>
                                </div>
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
            const changePaymentMode = (type) => {
                paymentOption = type
                highlightPaymentMode()
            }
            const highlightPaymentMode = () => {
                for (let i = 0; i < 4; i++) {
                    let paymentType = document.getElementsByClassName("payment-option")[i]
                    paymentType.classList.remove("selected-payment-option")
                    if (paymentType.id === paymentOption) {
                        paymentType.classList.add("selected-payment-option")
                    }
                }
            }
            highlightPaymentMode()
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

            Array.from(price).map((k) => {
                let div = document.getElementsByClassName("payment-price")[0]
                var pricDiv = document.createElement("div")
                pricDiv.classList.add("payment-price-column")
                var calcDiv = document.createElement("div")
                calcDiv.classList.add("calculation-part")
                var subTotalDiv = document.createElement("div")
                subTotalDiv.classList.add("subtotal-part")
                let priceCount = 0;
                ticket.seat.map((e) => {
                    if (e.price === k) {
                        priceCount++;
                    }
                })
                calcDiv.textContent = k + " * " + priceCount
                subTotalDiv.textContent = k * priceCount
                pricDiv.appendChild(calcDiv)
                pricDiv.appendChild(subTotalDiv)
                div.appendChild(pricDiv)
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
            

            function openPaymentPage(){
                let form = document.createElement("form")
                form.setAttribute("method", "post")
                form.setAttribute("action", "pay")
                let ticketId = document.createElement("input")
                ticketId.setAttribute("name", "ticketId")
                ticketId.value = "${ticket.ticketId}"
                let numberOfSeats = document.createElement("input")
                numberOfSeats.setAttribute("name", "numberOfSeats")
                numberOfSeats.value = "${ticket.numberOfSeats}"
                let totalAmount = document.createElement("input")
                totalAmount.setAttribute("name", "totalAmount")
                totalAmount.value = "${ticket.totalAmount}"
                form.append(ticketId)
                form.append(numberOfSeats)
                form.append(totalAmount)
                let contentDiv = document.getElementsByClassName("home-main-cont")[0]
                contentDiv.appendChild(form)
                form.submit()
            }
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

            
        </script>

        </html>