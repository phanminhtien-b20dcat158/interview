<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
    <link rel="stylesheet" href="/css/interview/details.css">
</head>
<body>
<div class="be-wrapper">
    <%@include file="../layout/header.jsp"%>
    <%@include file="../layout/left-sidebar.jsp"%>


    <div class="be-content">
        <div class="page-head">
            <h2 class="page-head-title">Interview Schedule Details</h2>
        </div>
        <div class="main-content container-fluid">
            <div class="card">
                <div class="card-header">
                    <c:if test = "${interview.status != 'CANCELLED' && interview.status != 'INTERVIEWED'}">
                        <c:if test="${roleName == 'admin' || roleName == 'manager' || roleName == 'recruiter'}">
                            <div class="d-flex justify-content-end">
                                <a href="javascript:void(0);" onclick="confirmInterviewReminder(${interview.interviewId})">
                                    <button class="btn btn-space btn-secondary active">Send Reminder</button>
                                </a>
                            </div>
                        </c:if>
                        <c:if test="${not empty emailError}">
                            <div class="d-flex justify-content-end" style="color: red; font-weight: 400">
                                Error: ${emailError}
                            </div>
                        </c:if>
                    </c:if>
                </div>
                <div class="card-body">
                    <div class="row">
                        <!-- Left Column -->
                        <div class="col-md-6">
                            <div class="info-group">
                                <div class="info-row">
                                    <div class="info-label">Schedule Title:</div>
                                    <div class="info-content">${interview.title}</div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Candidate:</div>
                                    <div class="info-content">${interview.candidate.name}</div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Schedule Time:</div>
                                    <div class="info-content">
                                        ${interview.date}<br>
                                        From: ${interview.startTime} To: ${interview.endTime}
                                    </div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Notes:</div>
                                    <div class="info-content">${interview.note}</div>
                                </div>
                            </div>
                        </div>
                        <!-- Right Column -->
                        <div class="col-md-6">
                            <div class="info-group">
                                <div class="info-row">
                                    <div class="info-label">Job:</div>
                                    <div class="info-content">${interview.job.title}</div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Interviewer:</div>
                                    <div class="info-content">
                                        <c:forEach var="scheduleInterview" items="${interview.scheduledInterviews}">
                                            <div class="interviewer-item">
                                                    ${scheduleInterview.interviewer.fullName} | ${scheduleInterview.interviewer.department}
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Location:</div>
                                    <div class="info-content">${interview.location}</div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Recruiter Owner:</div>
                                    <div class="info-content">${interview.recruiter.fullName} | ${interview.recruiter.department}</div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Meeting ID:</div>
                                    <div class="info-content">${interview.meetingId}</div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Result:</div>
                                    <div class="info-content">${interview.result.name().toString()}</div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Status:</div>
                                    <div class="info-content">${interview.status.name().toString()}</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12 text-center">
                            <a href="/interview/list">
                                <button class="btn btn-space btn-secondary btn-width active">Close</button>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<script src="/lib/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/lib/perfect-scrollbar/js/perfect-scrollbar.min.js" type="text/javascript"></script>
<script src="/lib/bootstrap/dist/js/bootstrap.bundle.min.js" type="text/javascript"></script>
<script src="/js/app.js" type="text/javascript"></script>
<script src="/lib/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
<script src="/lib/jquery.nestable/jquery.nestable.js" type="text/javascript"></script>
<script src="/lib/moment.js/min/moment.min.js" type="text/javascript"></script>
<script src="/lib/datetimepicker/js/bootstrap-datetimepicker.min.js" type="text/javascript"></script>
<script src="/lib/select2/js/select2.min.js" type="text/javascript"></script>
<script src="/lib/select2/js/select2.full.min.js" type="text/javascript"></script>
<script src="/lib/bootstrap-slider/bootstrap-slider.min.js" type="text/javascript"></script>
<script src="/lib/bs-custom-file-input/bs-custom-file-input.js" type="text/javascript"></script>

<script src="/js/interview/details.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        //-initialize the javascript
        App.init();
        App.formElements();
    });
</script>
</body>
</html>