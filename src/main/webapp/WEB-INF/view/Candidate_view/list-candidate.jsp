<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="/img/logo-fav.png">
    <title>Beagle</title>
    <link rel="stylesheet" type="text/css" href="/lib/perfect-scrollbar/css/perfect-scrollbar.css">
    <link rel="stylesheet" type="text/css" href="/lib/material-design-icons/css/material-design-iconic-font.min.css">
    <link rel="stylesheet" type="text/css" href="/lib/datetimepicker/css/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" type="text/css" href="/lib/select2/css/select2.min.css">
    <link rel="stylesheet" type="text/css" href="/lib/bootstrap-slider/css/bootstrap-slider.min.css">

    <link rel="stylesheet" href="/css/app.css" type="text/css">
    <link rel="stylesheet" href="/css/popup.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <style>
        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #f9f9f9;
            min-width: 160px;
            box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
            z-index: 1;
            padding: 12px 16px;
            margin-right: 10px;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }

        td {
            white-space: nowrap;

        }
    </style>
</head>

<body>
<div class="be-wrapper">
    <jsp:include page="../layout/header.jsp"/>
    <jsp:include page="../layout/left-sidebar.jsp"/>
    <div class="be-content">


        <div class="container">
            <h2>Candidate List</h2>
            <% String alertMessage = (String) request.getAttribute("message"); %>
            <% if (alertMessage != null) { %>
            <div class="alert alert-info text-center" role="alert"><%= alertMessage %>
            </div>
            <% } %>

            <c:if test="${message2!=null}">
                <div class="alert alert-info text-center" role="alert">${message2}</div>
            </c:if>

            <form action="/candidate/searchCandidate">
                <div class="row">
                    <div class="col-md-2">
                        <div class="form-group">
                            <select class="form-control" id="statusSelect" name="status">
                                <option value="" selected>All Role</option>
                                <option value="OPEN">Open</option>
                                <option value="Waiting_for_interview">Waiting for interview</option>
                                <option value="Cancelled_interview">Cancelled interview</option>
                                <option value="Passed_Interview">Passed Interview</option>
                                <option value="Failed_interview">Failed interview</option>
                                <option value="Waiting_for_approval">Waiting for approval</option>
                                <option value="Approved_offer">Approved offer</option>
                                <option value="Rejected_offer">Rejected offer</option>
                                <option value="Waiting_for_response">Waiting for response</option>
                                <option value="Accepted_offer">Accepted offer</option>
                                <option value="Declined_offer">Declined offer</option>
                                <option value="Cancelled_offer">Cancelled offer</option>
                                <option value="BANNED">Banned</option>
                            </select>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="input-group">
                            <input type="text" class="form-control" id="searchInput" placeholder="Search" name="search">

                        </div>
                    </div>
                    <div class="col-md-2">
                        <button type="submit" class="form-control btn btn btn-primary">Search</button>
                    </div>
                </div>


            </form>
            <div class="text-right">
                <a type="submit" href="/candidate/addCandidateForward" class="btn btn-primary action-button btn-sm"
                   id="addButton">Add Candidate</a>
            </div>

            <table class="table table-striped">
                <thead>
                <tr>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone No(s)</th>
                    <th>Current Position</th>
                    <th>Owner Hr</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${candidates}" var="candidate">
                    <tr>
                        <td>
                            <div class="dropdown">
                                <span>${candidate.name}</span>
                                <div class="dropdown-content">
                                    <table class="table table-striped table-sm table-responsive">
                                        <thead>
                                        <tr>
                                            <th>Job Title</th>
                                            <th>Location</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                        </thead>
                                        <tbody>
                                        <c:forEach items="${candidate.candidateJobs}" var="candidateJob">
                                            <tr>
                                                <td>${candidateJob.job.title}</td>
                                                <td>${candidateJob.job.location}</td>
                                                <td>${candidateJob.job.status}</td>
                                                <td class="action-buttons">
                                                    <c:if test="${candidateJob.job.status.toString() == 'OPEN'}">
                                                        <a type="submit"
                                                           href="/interview/add_details?candidateId=${candidate.id}&jobId=${candidateJob.job.jobId}"
                                                           class="btn btn-sm btn-info action-button">Create new
                                                            Schedule</a>
                                                    </c:if>
                                                    <c:if test="${candidateJob.job.status.toString() == 'CLOSE'}">

                                                        <a type="submit"
                                                           href="#"
                                                           class="btn btn-sm btn-grey action-button" onclick="return false;">Create new
                                                            Schedule</a>

                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>

                        </td>

                        <td>${candidate.email}</td>
                        <td>${candidate.phone}</td>
                        <td>${candidate.currentPosition}</td>
                        <td>${candidate.user.fullName}</td>
                        <td>${candidate.status}</td>
                        <td class="action-buttons">
                            <a type="submit" href="/candidate/candidateDetail?id=${candidate.id}"
                               class="btn btn-sm btn-info action-button">View</a>
                            <a type="submit" href="/candidate/updateForward?id=${candidate.id}"
                               class="btn btn-sm btn-warning action-button">Edit</a>
                            <c:if test="${candidate.status.toString() == 'OPEN'}">
                                <button class="btn btn-sm btn-danger action-button" onclick="remove(${candidate.id})">
                                    Delete
                                </button>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <nav aria-label="Page navigation example">
                <ul class="pagination justify-content-center">
                    <c:if test="${p.number>0}">
                        <li class="page-item">
                            <a class="page-link" href="/candidate/searchCandidate?page=${p.number-1}&${requestParams}"
                               aria-label="Previous">
                                <span class="fa fa-angle-left"></span>
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${p.totalPages!=0}">
                        <c:forEach begin="0" end="${p.totalPages - 1}" var="i">
                            <li class="page-item ${i == p.number ? 'active' : ''}">
                                <a class="page-link"
                                   href="/candidate/searchCandidate?page=${i}&${requestParams}">${i + 1}</a>
                            </li>
                        </c:forEach>
                    </c:if>

                    <c:if test="${p.number<p.totalPages-1}">
                        <li class="page-item">
                            <a class="page-link" href="/candidate/searchCandidate?page=${p.number+1}&${requestParams}"
                               aria-label="Next">
                                <span class="fa fa-angle-right"></span>
                            </a>
                        </li>
                    </c:if>

                </ul>
            </nav>
            <div class="popup-container" id="popup-container">
                <div class="popup-content">
                    <p>Are you sure to delete</p>
                    <button class="btn btn-primary action-button btn-sm" id="yes">Yes</button>
                    <button class="btn btn-danger action-button btn-sm" id="no">No</button>
                </div>

            </div>
        </div>
    </div>
</div>
</body>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script>
    const closePopupBtn = document.getElementById('no')
    const yesBtn = document.getElementById('yes')

    function remove(id) {
        const popupContainer = document.getElementById('popup-container');
        popupContainer.classList.add('show');
        closePopupBtn.addEventListener('click', () => {
            popupContainer.classList.remove('show');
        });
        yesBtn.addEventListener('click', () => {
            window.location.href = "/candidate/delete?id=" + id
        });
    }

</script>
</html>