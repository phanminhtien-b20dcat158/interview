<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Job Detail</title>
    <!-- Latest compiled and minified CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" type="text/css" href="/lib/perfect-scrollbar/css/perfect-scrollbar.css">
    <link rel="stylesheet" type="text/css"
          href="/lib/material-design-icons/css/material-design-iconic-font.min.css">
    <link rel="stylesheet" type="text/css" href="/lib/datetimepicker/css/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" type="text/css" href="/lib/select2/css/select2.min.css">
    <link rel="stylesheet" type="text/css" href="/lib/bootstrap-slider/css/bootstrap-slider.min.css">
    <link rel="stylesheet" type="text/css" href="/multiselect/css/multi-select.css">
    <link rel="stylesheet" href="/css/app.css" type="text/css">
    <link rel="stylesheet" href="/css/job/detail.css" type="text/css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="/lib/virtual-select.min.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>

<body>
<jsp:include page="../layout/header.jsp" />
<jsp:include page="../layout/left-sidebar.jsp" />

<div class="container mt-5">
    <div class="col-12 mx-auto">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/job">Job list</a></li>
                <li class="breadcrumb-item active" aria-current="page">Job Detail</li>
            </ol>
        </nav>

        <div class="text-end mb-3">
            <p class="text-muted">Created on ${jobdetail.createdAt} | Last modified on
                ${jobdetail.updatedAt} by ${jobdetail.lastModifiedBy}</p>
        </div>

        <hr />

        <div class="row">
            <div class="col-md-6">
                <div class="card mb-3">
                    <div class="card-body">

                        <p><strong>Title:</strong> ${jobdetail.title}</p>
                    </div>
                </div>
                <div class="card mb-3">
                    <div class="card-body">
                        <p><strong>Skills:</strong> <span
                                id="requiredSkills">${jobdetail.requiredSkills}</span></p>
                    </div>
                </div>
                <div class="card mb-3">
                    <div class="card-body">
                        <p><strong>Benefits:</strong> <span id="benefits">${jobdetail.benefits}</span>
                        </p>
                    </div>
                </div>
                <div class="card mb-3">
                    <div class="card-body">
                        <p><strong>Level:</strong> <span id="level">${jobdetail.level}</span></p>
                    </div>
                </div>
                <div class="card mb-3">
                    <div class="card-body">
                        <p><strong>Status:</strong> <span id="status">${jobdetail.status}</span></p>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card mb-3">
                    <div class="card-body">
                        <p><strong>Start Date:</strong> ${jobdetail.startDate}</p>
                        <p><strong>End Date:</strong> ${jobdetail.endDate}</p>
                    </div>
                </div>
                <div class="card mb-3">
                    <div class="card-body">
                        <p><strong>Salary From:</strong> ${jobdetail.salaryFrom} VNĐ</p>
                        <p><strong>Salary To:</strong> ${jobdetail.salaryTo} VNĐ</p>
                    </div>
                </div>
                <div class="card mb-3">
                    <div class="card-body">
                        <p><strong>Location:</strong> ${jobdetail.location}</p>
                        <p><strong>Description:</strong> ${jobdetail.description}</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="btn-container mt-3 text-end">
            <a href="javascript:history.back()" class="btn btn-success me-2 back">Back</a>
            <c:if test="${isAdminOrManagerOrRecruiter}">
                <a href="/job/update/${jobdetail.jobId}" class="btn btn-warning edit">Edit</a>
            </c:if>
        </div>
    </div>
</div>

<script src="/lib/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/lib/perfect-scrollbar/js/perfect-scrollbar.min.js" type="text/javascript"></script>
<script src="/lib/bootstrap/dist/js/bootstrap.bundle.min.js" type="text/javascript"></script>
<script src="/js/app.js" type="text/javascript"></script>
<script src="/lib/jquery.sparkline/jquery.sparkline.min.js" type="text/javascript"></script>
<script src="/lib/countup/countUp.min.js" type="text/javascript"></script>
<script src="/lib/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
<script src="/lib/jqvmap/jquery.vmap.min.js" type="text/javascript"></script>
<script src="/lib/jqvmap/maps/jquery.vmap.world.js" type="text/javascript"></script>
<script>
    function formatString(input) {
        return input.split(',').map(item => {
            return item.trim().charAt(0).toUpperCase() + item.trim().slice(1).toLowerCase();
        }).join(', ');
    }

    document.getElementById('benefits').innerText = formatString(document.getElementById('benefits').innerText);
    document.getElementById('level').innerText = formatString(document.getElementById('level').innerText);
    document.getElementById('requiredSkills').innerText = formatString(document.getElementById('requiredSkills').innerText);
</script>

</body>

</html>