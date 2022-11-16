<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="ISO-8859-1">
        <title>Insert title here</title>
        <link rel="stylesheet" href="../styles.css">
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
    </head>

    <body>
        <div class="box" style="display: none;">
            <div class="container">
              <span class="square"></span>
              <span class="square"></span>
              <span class="square"></span>
              <span class="square"></span>
            </div>
          </div>
        <div class="seat-main-div">
            
            <span id="message-show-bar"></span>
        
            <div id="show-options">
                <a style="text-decoration: none;" href="getAllTheatres"><img  src="../left-arrow.png" width="25"
                    class="delete-img" alt="back icon"></a>
                <span>ScreenID : ${screen.screenId}</span>
                <span>Sreen NAme : ${screen.screenName}</span>
                <div onclick="reset()" class="reset-button">Reset</div>
                <div class="gap-checkbox-container">Gap : <input id="gap-input" onchange="changeGapValue()"
                        type="checkbox" /></div>
            </div>
            <div id="myModal" class="modal">


                <div class="modal-content">
                    <span class="close">&times;</span>
                    <div class="add-seat-heading">Add Seat Details</div>
                    <div id="input-div">
                        <input type="text" placeholder="row" id="row-input" />
                        <input type="text" placeholder="column" id="column-input" />
                        <input type="text" placeholder="seat type" id="seat-type" />
                        <input type="text" placeholder="seat price" id="seat-price" />
                        <button onclick="addSeats()" id="add-seats-button">Add Seats</button>
                    </div>
                    <div id="details-display-div">

                    </div>
                    <div id="button-insert-seat-div">
                        <div onclick="showSeats();showMessage('Seat map created successfully', '#4DAE50')"
                            class='seat-insert-submit-button'>Submit</div>
                    </div>
                </div>

            </div>

            <div class="seat-div" id="seats-container">

            </div>
            <div class="image-main-container">
                <img class="img-tag" width={300}
                    src="https://assetscdn1.paytm.com/movies_new/_next/static/media/screen-icon.8dd7f126.svg"
                    alt="scs" />
                <div class='seat-insert-submit-button' onclick="submit()">submit</div>

            </div>
        </div>
    </body>
    <script>
        
        let seatDetails = []
        let gapSeat = new Set()
        let seats = new Set()
        let gap = false;
        var modal = document.getElementById("myModal");
        var span = document.getElementsByClassName("close")[0];

    
        let data=[];
        let seat;
        "<c:forEach var='seats' items='${theatreSeats}'>"
            seat={seatNumber: "<c:out value='${seats.seatNumber}' />",seatType: "<c:out value='${seats.seatType}' />"}
            data.push(seat);
        "</c:forEach>"
        if (data.length>0) {
            
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
            })
            console.log(seatTypes);
            Array.from(seatTypes).map((type) => {
                let rows = new Set();
                let typeSeat = new Set()
                data.map((e, k) => {

                    if (e.seatNumber.split("-")[1] === type) {
                        typeSeat.add(e)
                        rows.add(e.seatNumber.split("-")[0].split(`${k}`)[0])
                    }
                })
                console.log(rows);
                let columns = typeSeat.size / rows.size
                let detail = {
                    rows: rows.size,
                    columns,
                    seatType: type
                }
                seatDetails.push(detail)

            })

            console.log(seatDetails);
            console.log(seats);
            console.log(gapSeat);
            showSeats()
        }
        else{
            modal.style.display = "block";
        }
        span.onclick = function () {
            modal.style.display = "none";
        }
        const changeGapValue = () => {
            gap = !gap;

        }
        // When the user clicks anywhere outside of the modal, close it
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
        function showSeats() {

            modal.style.display = "none";
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

                            span.classList.add("active-seat")
                            span.addEventListener('click', () => {
                                appendToGapSeat(seatNumber)
                            })
                            li.appendChild(span)
                        } else if (Array.from(gapSeat).includes(seatNumber)) {
                            let span = document.createElement("span")

                            span.classList.add("gap-seat")
                            span.addEventListener('click', () => {
                                appendToGapSeat(seatNumber)
                            })
                            li.appendChild(span)
                        }


                    }
                    ul.appendChild(li)
                    seatDiv.appendChild(ul)

                }
            })

        }

        const appendToGapSeat = (seatNumber) => {
            if (gap && !Array.from(gapSeat).includes(seatNumber)) {
                gapSeat.add(seatNumber)
                seats.delete(seatNumber)
                showSeats()
            }
        }

        const addSeats = () => {
            let columns = document.getElementById("column-input").value;
            let rows = document.getElementById("row-input").value;
            let seatType = document.getElementById("seat-type").value;
            let seatPrice = document.getElementById("seat-price").value;
            let displayDiv = document.getElementById("details-display-div")
            displayDiv.textContent = ""
            if (columns.length > 0 && rows.length > 0 && seatType.length > 0 && seatPrice.length > 0) {
                document.getElementById("button-insert-seat-div").style.display = "flex"
                displayDiv.textContent = ""
                let details = {
                    rows,
                    columns,
                    seatType,
                    seatPrice
                }
                seatDetails.push(details)
                seatDetails.map((e) => {

                    let div = document.createElement("div")
                    div.classList.add("seat-details-span-container")
                    let rowSpan = document.createElement("span")
                    rowSpan.textContent = "rows :" + e.rows
                    let columnSpan = document.createElement("span")
                    columnSpan.textContent = "columns :" + e.columns
                    let typeSpan = document.createElement("span")
                    typeSpan.textContent = "seat type :" + e.seatType
                    let priceSpan = document.createElement("span")
                    priceSpan.textContent = "price :" + e.seatPrice
                    div.appendChild(rowSpan)
                    div.appendChild(columnSpan)
                    div.appendChild(typeSpan)
                    div.appendChild(priceSpan)
                    displayDiv.appendChild(div)
                })
            } else {
                showMessage("All fields must be filled", "#F54337")
            }
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
        const submit = () => {

            let seatData = []
            console.log(seats)

            seatDetails.map((detail)=>{
                Array.from(seats).forEach((e, k) => {
                if(detail.seatType === e.split('-')[1]){
                let seat = {
                    seatNumber: e,
                    seatType: e.split('-')[1],
                    price:detail.seatPrice
                }
                seatData.push(seat)
                }
                })
                Array.from(gapSeat).forEach((e, k) => {
                let seat = {
                    seatNumber: e + "-gap",
                    seatType: e.split('-')[1],
                    price:0
                }
                seatData.push(seat)
                })
            })
            
            console.log(seatData);
            if (seatData.length > 0) {

            } else {
                showMessage("No seat map", "#F54337")
            }
            // data.map((e) => {
            //     let formData = new FormData();
            //     formData.append("userName", e.userName)
            //     const request = new XMLHttpRequest();
            //     request.open("POST", "http://localhost:8080/userNameData");
            //     request.send(formData);
            // })
            document.getElementsByClassName("modal-content")[0].style.display = "none"
            document.getElementsByClassName("box")[0].style.display = "flex"
            const options = {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(seatData),
            }
            fetch("http://localhost:8080/theatre/addTheatreSeats", options)
            .then(res=>{
                    document.getElementsByClassName("box")[0].style.display = "none"
                    let contentDiv = document.getElementsByClassName("modal-content-div-show")[0]
                    let form = document.createElement("form")
                    let screenId = document.createElement("input")
                    screenId.setAttribute("name", "id")
                    screenId.value = "${screen.screenId}"
                    screenId.setAttribute("type", "hidden")
                    form.appendChild(screenId)
                    form.setAttribute("action", "createSeatMapPage")
                    contentDiv.appendChild(form)
                    form.submit()
            })


        }

        const reset = () => {
            fetch("http://localhost:8080/theatre/UpdateScreenSeats?id=${screen.screenId}", {method:"GET"}).then(res=>{
                console.log("here in fetch")
            })
            let seatDiv = document.getElementById("seats-container")
            seatDiv.textContent = ""

            seatDetails = []
            gapSeat = new Set()
            seats = new Set()
            document.getElementById("column-input").value = ""
            document.getElementById("row-input").value = ""
            document.getElementById("seat-type").value = ""
            document.getElementById("seat-price").value = ""
            // addSeats();
            document.getElementById("button-insert-seat-div").style.display = "none"
            document.getElementById("details-display-div").textContent = ""
            modal.style.display = "block";

        }
    </script>

    </html>