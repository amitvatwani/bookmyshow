<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="../style.css">

</head>

<body>
<div class="seat-main-div">

<span id="message-show-bar"></span>
<div id="show-options">
<span>SCreenID : 541515515</span>
<span>SCreen NAme : Screen1</span>
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
<img class="img-tag" width={300} src="" alt="scs" />
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
console.log(seats);
console.log(gapSeat);
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
Array.from(seats).forEach((e, k) => {
let seat = {
seatNumber: e,
seatType: e.split('-')[1]
}
seatData.push(seat)
})
Array.from(gapSeat).forEach((e, k) => {
let seat = {
seatNumber: e + "-gap",
seatType: e.split('-')[1]
}
seatData.push(seat)
})
if (seatData.length > 0) {

} else {
showMessage("No seat map", "#F54337")
}
// data.map((e) => {
// let formData = new FormData();
// formData.append("userName", e.userName)
// const request = new XMLHttpRequest();
// request.open("POST", "http://localhost:8080/userNameData");
// request.send(formData);
// })
const options = {
method: 'POST',
headers: {
'Content-Type': 'application/json',
},
body: JSON.stringify(data),
}
fetch("http://localhost:8080/createSeatMap", options)


}

const reset = () => {
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