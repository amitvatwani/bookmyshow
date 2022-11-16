<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
    <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <!DOCTYPE html>
            <html>

            <head>
                <meta charset="ISO-8859-1">
                <title>Insert title here</title>
                <link rel="stylesheet" href="../styles.css">

            </head>

            <body>

                <div class="view-screen-main-container">
                    <span id="message-show-bar"></span>
                    <div id="myModal" class="modal-general">

                        <!-- Modal content -->
                        <div class="modal-content">
                            <span class="close">&times;</span>
                            <div class="add-seat-heading"></div>
                            <div class="modal-content-div"></div>
                            <div id="modal-button-div">
                                <div onclick="" class='modal-submit-button'></div>
                            </div>
                        </div>

                    </div>
                    <div class="view-screen-navbar">

                        <div class="theatre-name-heading"><a style="text-decoration: none;" href="getAllTheatres"><img src="../left-arrow.png" width="25"
                                class="delete-img" alt="back icon"></a><span>Theatre
                                Theatre Name :
                                ${theatre.theatreName}</span></div>
                        <div class="seat-insert-submit-button" onclick="openModal('','','','add')">Add Screen</div>
                    </div>
                    <div class="view-screen-display-container">


                        <c:forEach var="screen" items="${theatreScreens}">
                            <div class="view-screen-single-div">
                                <div class="screen-name-div">Screen Name : ${screen.screenName}</div>
                                <c:choose>
                                    
                                    <c:when test="${fn:length(screen.theatreSeats) > 0}">
                                        <a href="createShowPage?id=${screen.screenId}" class="edit-seats-button-div">Manage Shows
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="edit-seats-button-div" style="background-color: lightgray;cursor: no-drop;display: flex;flex-direction: column;">Manage Shows
                                            <span style="font-size: 16px;">Please add seats</span></a>
                                    </c:otherwise>
                                </c:choose>
                                <a href="createSeatMapPage?id=${screen.screenId}" class="edit-seats-button-div">Manage Seats
                                </a>
                                <div class="screen-options-div">
                                    <img onclick="openModal('${screen.screenId}','${screen.screenName}','${screen.totalSeats}','delete')"
                                        id="delete-img" src="../delete.png" class="delete-img" width="25"
                                        alt="delete icon">
                                    <img onclick="openModal('${screen.screenId}','${screen.screenName}','${screen.totalSeats}','edit')"
                                        src="../edit.png" class="delete-img" width="25" alt="edit icon">
                                </div>
                            </div>



                        </c:forEach>

                    </div>
                </div>
                <script>
                    var modal = document.getElementById("myModal");

                    // Get the button that opens the modal


                    // Get the <span> element that closes the modal
                    var span = document.getElementsByClassName("close")[0];

                    // When the user clicks on the button, open the modal
                    function openModal(screenId, screenName, totalSeats, type) {
                        let headerDiv = document.getElementsByClassName('add-seat-heading')[0]
                        headerDiv.textContent = type === "delete" ? "Delete Screen" : type === "edit" ? "Edit Screen" : "Add Screen"
                        let contentDiv = document.getElementsByClassName("modal-content-div")[0]
                        let buttonComp = document.getElementsByClassName("modal-submit-button")[0]
                        buttonComp.textContent = ""
                        contentDiv.textContent = ""
                        if (type === "delete") {
                            let form = document.createElement("form")
                            form.setAttribute("action", "deleteTheatreScreen")
							form.setAttribute("method", "post")
                            let input = document.createElement("input")
                            input.setAttribute("name", "screenId")
                            input.value = screenId
                            input.setAttribute("type", "hidden")
                            form.appendChild(input)
                            contentDiv.textContent = `Are you sure want to delete screen ` + screenName
                            buttonComp.textContent = "Delete Screen"
                            contentDiv.appendChild(form)
                            buttonComp.style.backgroundColor = "#F54337"
                            buttonComp.addEventListener("click", () => { form.submit() })

                        } else if (type === "edit") {
                            let form = document.createElement("form")
                            form.setAttribute("action", "updateTheatreScreen")
							form.setAttribute("method", "post")
                            let input = document.createElement("input")
                            input.setAttribute("name", "screenId")
                            input.value = screenId
                            input.setAttribute("type", "hidden")
                            form.appendChild(input)
                            let label1 = document.createElement("span")
                            label1.textContent = "Screen Name : "
                            let input1 = document.createElement("input")
                            input1.setAttribute("name", "screenName")
                            input1.value = screenName
                            // let label2 = document.createElement("span")
                            // label2.textContent = "Total No.of Seats : "
                            // let input2 = document.createElement("input")
                            // input2.value = totalSeats

                            input1.classList.add("modal-general-input")
                            form.appendChild(label1)
                            form.appendChild(input1)
                            //input2.classList.add("modal-general-input")

                            contentDiv.appendChild(form)
                            // contentDiv.appendChild(label2)
                            // contentDiv.appendChild(input2)
                            buttonComp.textContent = "Edit Screen"
                            buttonComp.addEventListener("click", () => {form.submit()})
                        } else if (type === "add") {
                            let form = document.createElement("form")
                            form.setAttribute("action", "addTheatreScreen")
							form.setAttribute("method", "post")
                            let label1 = document.createElement("span")
                            label1.textContent = "Screen Name : "
                            let input1 = document.createElement("input")
                            input1.setAttribute("name", "screenName")
                            // let label2 = document.createElement("span")
                            // label2.textContent = "Total No.of Seats : "
                            // let input2 = document.createElement("input")
                            // input2.setAttribute("name", "totalSeats")
                            input1.classList.add("modal-general-input")
                            //input2.classList.add("modal-general-input")
                            form.appendChild(label1)
                            form.appendChild(input1)
                            //form.appendChild(label2)
                            //form.appendChild(input2)
                            let submitButton = document.createElement("input")
							submitButton.setAttribute("type", "submit")
							submitButton.setAttribute("value", "Add Screen")
							contentDiv.appendChild(form)
                            buttonComp.textContent = "Add Screen"
                            buttonComp.addEventListener("click", ()=>{
                                form.submit()
                            })
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
                    const deleteScreen = (screenID) => {
                        let form = document.createElement("form")
                        form.append("screenId", screenID)
                        const request = new XMLHttpRequest();
                        request.open("POST", "http://localhost:8080/deleteScreen");
                        request.send(formData);
                    }
                    const edit = (screenId) => {
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
                    "<c:if test = '${fn:length(deleteScreenSuccess) > 0}'>"
                        showMessage("${deleteScreenSuccess}", "#F54337")
                    "</c:if>"
                    "<c:if test = '${fn:length(updateScreenSuccess) > 0}'>"
                        showMessage("${updateScreenSuccess}", "#4DAE50")
                    "</c:if>"
                    "<c:if test = '${fn:length(addScreenSuccess) > 0}'>"
                        showMessage("${addScreenSuccess}", "#4DAE50")
                    "</c:if>"
                </script>


            </body>

            </html>