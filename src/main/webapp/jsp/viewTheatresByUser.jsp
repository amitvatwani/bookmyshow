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

                        <div class="theatre-name-heading">
                            <a style="text-decoration: none;" href="../index"><img src="../left-arrow.png" width="25"
                                class="delete-img" alt="back icon"></a><span>Theatre
                                User Name :
                                </span></div>
                        <div class="seat-insert-submit-button" onclick="openModal('','','','add')">Add Theatre</div>
                    </div>
                    <div class="view-screen-display-container">


                        <c:forEach var="theatre" items="${theatres}">
                            <div class="view-screen-single-div">
                                <div class="screen-name-div">Theatre Name : ${theatre.theatreName}</div>
                                <div class="screen-name-div">City : ${theatre.theatreCity.cityName}</div>
                                <c:choose>
                                    <c:when test="${theatre.theatreApproval!=true}">
                                        <div class="screen-name-div">Not Approved</div>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="theatreScreens?id=${theatre.theatreId}" class="edit-seats-button-div">Manage Screens</a>
                                    </c:otherwise>
                                </c:choose>
                                
                                <div class="screen-options-div">
                                    <img onclick="openModal('${theatre.theatreId}','${theatre.theatreName}','${theatre.theatreCity.cityName}','delete')"
                                        id="delete-img" src="../delete.png" class="delete-img" width="25"
                                        alt="delete icon">
                                    <img onclick="openModal('${theatre.theatreId}','${theatre.theatreName}','${theatre.theatreCity.cityName}','edit')"
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
                    function openModal(theatreId, theatreName, theatreCity, type) {
                        let headerDiv = document.getElementsByClassName('add-seat-heading')[0]
                        headerDiv.textContent = type === "delete" ? "Delete Theatre" : type === "edit" ? "Edit Theatre" : "Add Theatre"
                        let contentDiv = document.getElementsByClassName("modal-content-div")[0]
                        let buttonComp = document.getElementsByClassName("modal-submit-button")[0]
                        buttonComp.textContent = ""
                        contentDiv.textContent = ""
                        if (type === "delete") {
                            let form = document.createElement("form")
							form.setAttribute("action", "deleteTheatre")
							form.setAttribute("method", "post")
                            let input = document.createElement("input")
                            input.setAttribute("name", "theatreId")
                            //input.setAttribute("value", theatreId)
                            input.value = theatreId
                            input.setAttribute("type", "hidden")
                            form.appendChild(input)
                            contentDiv.textContent = `Are you sure want to delete theatre ` + theatreName
                            // let submitButton = document.createElement("input")
                            // submitButton.setAttribute("type", "submit")
							// submitButton.setAttribute("value", "Delete Theatre")
                            // submitButton.textContent = "Delete Theatre"
                            // form.appendChild(submitButton)
                            contentDiv.appendChild(form)
                            buttonComp.textContent = "Delete Theatre"
                            buttonComp.style.backgroundColor = "#F54337"
                            buttonComp.addEventListener("click", () => { form.submit() })

                        } else if (type === "edit") {
                            let form = document.createElement("form")
							form.setAttribute("action", "updateTheatre")
							form.setAttribute("method", "post")
                            let input = document.createElement("input")
                            input.setAttribute("name", "theatreId")
                            input.value = theatreId
                            input.setAttribute("type", "hidden")
                            form.appendChild(input)
                            let label1 = document.createElement("span")
                            label1.textContent = "Theatre Name : "
                            let input1 = document.createElement("input")
                            input1.setAttribute("name", "theatreName")
                            input1.value = theatreName
                            let label2 = document.createElement("span")
                            label2.textContent = "Theatre City : "
                            let input2 = document.createElement("select")
							input2.setAttribute("name", "theatreCity")
							
							"<c:forEach var='theatreCity' items='${theatreCity}'>"
							var optionInput=document.createElement("option")
							optionInput.setAttribute("value", "<c:out value='${theatreCity.cityName}'/>")
							optionInput.textContent = "<c:out value='${theatreCity.cityName}'/>"
							input2.appendChild(optionInput)
							"</c:forEach>"
                            input1.classList.add("modal-general-input")
                            input2.classList.add("modal-general-input")
                            form.appendChild(label1)
                            form.appendChild(input1)
                            form.appendChild(label2)
                            form.appendChild(input2)
                            contentDiv.appendChild(form)
                            buttonComp.textContent = "Edit Theatre"
                            buttonComp.addEventListener("click", () => {form.submit()})
                        } else if (type === "add") {
							let form = document.createElement("form")
							form.setAttribute("action", "addTheatre")
							form.setAttribute("method", "post")
                            let label1 = document.createElement("span")
                            label1.textContent = "Theatre Name : "
                            let input1 = document.createElement("input")
							input1.setAttribute("name", "theatreName")
                            let label2 = document.createElement("span")
                            label2.textContent = "Theatre City : "
                            let input2 = document.createElement("select")
							input2.setAttribute("name", "theatreCity")
							
							"<c:forEach var='theatreCity' items='${theatreCity}'>"
							console.log("here");
							var optionInput=document.createElement("option")
							optionInput.setAttribute("value", "<c:out value='${theatreCity.cityName}'/>")
							optionInput.textContent = "<c:out value='${theatreCity.cityName}'/>"
							input2.appendChild(optionInput)
							"</c:forEach>"
                            input1.classList.add("modal-general-input")
                            input2.classList.add("modal-general-input")
                            form.appendChild(label1)
                            form.appendChild(input1)
                            form.appendChild(label2)
                            form.appendChild(input2)
							let submitButton = document.createElement("input")
							submitButton.setAttribute("type", "submit")
							submitButton.setAttribute("value", "Add Theatre")
							contentDiv.appendChild(form)
                            buttonComp.textContent = "Add Theatre"
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
                    

                    const addTheatre = () => {
                        let input1Value = document.getElementsByClassName("modal-general-input")[0].value
                        let input2Value = document.getElementsByClassName("modal-general-input")[1].value

                        if (input1Value.length > 0 && input2Value.length > 0) {
                            // let addTheatreform = new FormData()
                            // addTheatreform.append("theatreName", input1Value)
                            // addTheatreform.append("theatreCity", input2Value)
                            // const request = new XMLHttpRequest();
                            // request.open("POST", "http://localhost:8080/addTheatre");
                            // request.send(addTheatreform);
                        } else {
                            showMessage("input must be filled", "#F54337")
                        }
                    }
                    const deleteTheatre = (theatreId) => {
                        let form = document.createElement("form")
                        form.append("theatreId", theatreId)
                        const request = new XMLHttpRequest();
                        request.open("POST", "http://localhost:8080/deleteTheatre");
                        request.send(form);
                    }
                    const edit = (theatreId) => {
						console.log(theatreId);
                        let input1Value = document.getElementsByClassName("modal-general-input")[0].value
                        let input2Value = document.getElementsByClassName("modal-general-input")[1].value

                        if (input1Value.length > 0 && input2Value.length > 0) {
                            let form = document.createElement("form")
							form.append("theatreId",theatreId)
                            form.append("theatreName", input1Value)
                            form.append("theatreCity", input2Value)
							console.log(theatreId);
							console.log(input1Value);
							console.log(input2Value);
                            const request = new XMLHttpRequest();
                            request.open("POST", "http://localhost:8080/updateTheatre");
                            request.send(form);
                        } else {
                            showMessage("input must be filled", "#F54337")
                        }
                    }

                    const showMessage = (message, color) => {
                        console.log(message)
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
                    "<c:if test = '${fn:length(theatreDeleteSuccess) > 0}'>"
                        showMessage("${theatreDeleteSuccess}", "#F54337")
                    "</c:if>"
                    "<c:if test = '${fn:length(theatreUpdateSuccess) > 0}'>"
                        showMessage("${theatreUpdateSuccess}", "#4DAE50")
                    "</c:if>"
                    "<c:if test = '${fn:length(theatreRequestSuccess) > 0}'>"
                        showMessage("${theatreRequestSuccess}", "#4DAE50")
                    "</c:if>"
                </script>


            </body>

            </html>