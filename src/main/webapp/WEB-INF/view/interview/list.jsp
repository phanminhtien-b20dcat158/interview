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
    <link rel="stylesheet" type="text/css" href="/lib/datatables/datatables.net-bs4/css/dataTables.bootstrap4.css">
    <link rel="stylesheet" type="text/css" href="/lib/datatables/datatables.net-responsive-bs4/css/responsive.bootstrap4.min.css">
    <link rel="stylesheet" href="/css/app.css" type="text/css">
    <link rel="stylesheet" href="/css/interview/list.css">
</head>
<body>
<div class="be-wrapper">
    <%@include file="../layout/header.jsp"%>
    <%@include file="../layout/left-sidebar.jsp"%>

    <div class="be-content">
        <div class="page-head">
            <h2 class="page-head-title">Interview Schedule List</h2>
        </div>
        <div class="main-content container-fluid">
            <div class="row">
                <div class="col-sm-12">
                    <div class="card card-table">
                        <div class="card-header">
                            <c:if test = "${roleName == 'admin' || roleName == 'manager' || roleName == 'recruiter'}">
                                <div class="d-flex justify-content-end">
                                    <a href="/interview/add_candidate">
                                        <button class="btn btn-space btn-secondary btn-width active">Add new</button>
                                    </a>
                                </div>
                            </c:if>
                        </div>
                        <div class="card-header" style="margin-top: -20px">
                            <form action="/interview/search" method="get">
                                <div class="d-flex justify-content-end">
                                    <div class="col-12 col-sm-5 col-lg-3 mb-2 mb-sm-0">
                                        <select name="interviewerId" class="form-control" tabindex="-1" aria-hidden="true"
                                                style="width: 100%; height: 100%">
                                            <option value="">Interviewer</option>
                                            <c:forEach var="interviewer" items="${interviewers}">
                                                <c:if test="${interviewer.userId == selectedInterviewerId}">
                                                    <option value="${interviewer.userId}" selected="">${interviewer.fullName}</option>
                                                </c:if>
                                                <c:if test="${interviewer.userId != selectedInterviewerId}">
                                                    <option value="${interviewer.userId}">${interviewer.fullName}</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <div class="col-12 col-sm-5 col-lg-3 mb-2 mb-sm-0">
                                        <select name="status" class="form-control" tabindex="-1" aria-hidden="true"
                                                style="width: 100%; height: 100%">
                                            <option value="">Status</option>
                                            <c:forEach var="status" items="${states}">
                                                <c:if test="${status == selectedStatus}">
                                                    <option value="${status}" selected="">${status}</option>
                                                </c:if>
                                                <c:if test="${status != selectedStatus}">
                                                    <option value="${status}">${status}</option>
                                                </c:if>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    <button class="btn btn-space btn-secondary btn-width active" type="submit">Search</button>
                                </div>
                            </form>
                        </div>

                        <div class="card-body">



                            <table class="table table-striped table-hover table-bordered " id="table1">
                                <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Title</th>
                                    <th>Candidate Name</th>
                                    <th>Interviewer</th>
                                    <th>Schedule</th>
                                    <th>Result</th>
                                    <th>Status</th>
                                    <th>Job</th>
                                    <th>Action</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="interview" items="${interviews}">
                                    <tr>
                                        <td>${interview.interviewId}</td>
                                        <td>${interview.title}</td>
                                        <td>${interview.candidate.name}</td>
                                        <td>
                                            <c:forEach var="scheduledInterview" items="${interview.scheduledInterviews}" varStatus="status">
                                                ${scheduledInterview.interviewer.fullName}<c:if test="${!status.last}">, </c:if>
                                            </c:forEach>
                                        </td>
                                        <td>${interview.date} ${interview.startTime} - ${interview.endTime}</td>
                                        <td>${interview.result}</td>
                                        <td>${interview.status}</td>
                                        <td>${interview.job.title}</td>
                                        <td class="d-flex">
                                            <div class="icon">
                                                <a href="/interview/details?interviewId=${interview.interviewId}">
                                                    <span class="mdi mdi-eye"></span>
                                                </a>
                                            </div>
                                            <c:if test = "${interview.status != 'CANCELLED'}">
                                                <c:if test = "${roleName == 'admin' || roleName == 'manager' || roleName == 'recruiter'}">
                                                    <div class="icon">
                                                        <a href="/interview/edit_candidate?interviewId=${interview.interviewId}">
                                                            <span class="mdi mdi-edit"></span>
                                                        </a>
                                                    </div>
                                                </c:if>
                                                <c:if test = "${roleName == 'interviewer'}">
                                                    <div class="icon">
                                                        <a href="/interview/edit_details?interviewId=${interview.interviewId}&candidateId=${interview.candidate.id}">
                                                            <span class="mdi mdi-edit"></span>
                                                        </a>
                                                    </div>
                                                </c:if>
                                            </c:if>


                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
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
<script src="/lib/datatables/datatables.net/js/jquery.dataTables.js" type="text/javascript"></script>
<script src="/lib/datatables/datatables.net-bs4/js/dataTables.bootstrap4.js" type="text/javascript"></script>
<script src="/lib/datatables/datatables.net-buttons/js/dataTables.buttons.min.js" type="text/javascript"></script>
<script src="/lib/datatables/datatables.net-buttons/js/buttons.flash.min.js" type="text/javascript"></script>
<script src="/lib/datatables/jszip/jszip.min.js" type="text/javascript"></script>
<script src="/lib/datatables/pdfmake/pdfmake.min.js" type="text/javascript"></script>
<script src="/lib/datatables/pdfmake/vfs_fonts.js" type="text/javascript"></script>
<script src="/lib/datatables/datatables.net-buttons/js/buttons.colVis.min.js" type="text/javascript"></script>
<script src="/lib/datatables/datatables.net-buttons/js/buttons.print.min.js" type="text/javascript"></script>
<script src="/lib/datatables/datatables.net-buttons/js/buttons.html5.min.js" type="text/javascript"></script>
<script src="/lib/datatables/datatables.net-buttons-bs4/js/buttons.bootstrap4.min.js" type="text/javascript"></script>
<script src="/lib/datatables/datatables.net-responsive/js/dataTables.responsive.min.js" type="text/javascript"></script>
<script src="/lib/datatables/datatables.net-responsive-bs4/js/responsive.bootstrap4.min.js" type="text/javascript"></script>
<script src="/js/interview/list.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        //-initialize the javascript
        App.init();
        App.dataTables();
    });
</script>
</body>
</html>