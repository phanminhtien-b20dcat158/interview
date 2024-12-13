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
    <link rel="stylesheet" type="text/css"
          href="/lib/material-design-icons/css/material-design-iconic-font.min.css">
    <link rel="stylesheet" type="text/css"
          href="/lib/datatables/datatables.net-bs4/css/dataTables.bootstrap4.css">
    <link rel="stylesheet" type="text/css"
          href="/lib/datatables/datatables.net-responsive-bs4/css/responsive.bootstrap4.min.css">
    <link rel="stylesheet" href="/css/app.css" type="text/css">
</head>
<style>

    .alert {
        width: 300px;
        position: fixed;
        top: 80px;
        right: 20px;
        z-index: 1050;
        opacity: 0;
        transform: translateX(100%);
        transition: opacity 0.5s ease, transform 0.5s ease;
    }

    .alert.show {
        opacity: 1;
        transform: translateX(0);
    }
</style>
<body>
<jsp:include page="../layout/header.jsp"/>

<jsp:include page="../layout/left-sidebar.jsp"/>

<div class="be-content" style="margin-top: 60px;">
    <div class="main-content container-fluid">
        <div class="page-head">
            <h2 class="page-head-title">User Managerment</h2>
            <nav aria-label="breadcrumb" role="navigation">
                <ol class="breadcrumb page-head-nav">
                    <li class="breadcrumb-item"><a href="/user">User List</a></li>
                    <li class="breadcrumb-item active">User Detail</li>
                </ol>
            </nav>
        </div>
        <div class="card text-center">
            <div class="card-header">
                <div class="d-flex justify-content-end">
                    <c:choose>
                        <c:when test="${userDetail.status == 'ACTIVE'}">
                            <button class="btn btn-space btn-danger"
                                    onclick="updateStatus('${userDetail.userId}', '${sessionScope.userId}')">
                                De-activate user
                            </button>
                        </c:when>
                        <c:otherwise>
                            <button class="btn btn-space btn-success" onclick="updateStatus('${userDetail.userId}')">
                                Activate user
                            </button>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-6">
                        <div class="form-group d-flex align-items-center">
                            <label for="userName" class="font-weight-bold mr-2"
                                   style="width: 100px; text-align: left;">Full
                                Name:</label>
                            <p id="userName" class="flex-grow-1 border"
                               style="text-align: left; padding-left: 10px;">${userDetail.fullName}</p>
                        </div>
                        <div class="form-group d-flex align-items-center">
                            <label for="dob" class="font-weight-bold mr-2"
                                   style="width: 100px; text-align: left;">D.O.B:</label>
                            <p id="dob" class="flex-grow-1 border" style="text-align: left; padding-left: 10px;">
                                <fmt:parseDate value="${userDetail.dob}" pattern="yyyy-MM-dd" var="parsedDob"
                                               type="date"/>
                                <fmt:formatDate value="${parsedDob}" pattern="dd-MM-yyyy"/>
                            </p>
                        </div>
                        <div class="form-group d-flex align-items-center">
                            <label for="phoneNumber" class="font-weight-bold mr-2" style="width: 100px;">Phone
                                Number:</label>
                            <p id="phoneNumber" class="flex-grow-1 border"
                               style="text-align: left; padding-left: 10px;">${userDetail.phoneNumber}
                            </p>
                        </div>
                        <div class="form-group d-flex align-items-center">
                            <label for="role" class="font-weight-bold mr-2"
                                   style="width: 100px;text-align: left;">Role:</label>
                            <p id="role" class="flex-grow-1 border" style="text-align: left; padding-left: 10px;">
                                ${userDetail.role}</p>
                        </div>
                        <div class="form-group d-flex align-items-center">
                            <label for="status" class="font-weight-bold mr-2"
                                   style="width: 100px; text-align: left;">Status:</label>
                            <p id="status" class="flex-grow-1 border" style="text-align: left; padding-left: 10px;">
                                ${userDetail.status}</p>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="form-group d-flex align-items-center">
                            <label for="email" class="font-weight-bold mr-2"
                                   style="width: 100px; text-align: left;">Email:</label>
                            <p id="email" class="flex-grow-1 border" style="text-align: left; padding-left: 10px;">
                                ${userDetail.email}
                            </p>
                        </div>
                        <div class="form-group d-flex align-items-center">
                            <label for="address" class="font-weight-bold mr-2"
                                   style="width: 100px; text-align: left;">Address:</label>
                            <p id="address" class="flex-grow-1 border"
                               style="text-align: left; padding-left: 10px;">
                                ${userDetail.address}
                            </p>
                        </div>
                        <div class="form-group d-flex align-items-center">
                            <label for="gender" class="font-weight-bold mr-2"
                                   style="width: 100px; text-align: left;">Gender:</label>
                            <p id="gender" class="flex-grow-1 border" style="text-align: left; padding-left: 10px;">
                                ${userDetail.gender}</p>
                        </div>
                        <div class="form-group d-flex align-items-center">
                            <label for="department" class="font-weight-bold mr-2"
                                   style="width: 100px; text-align: left;">Department:</label>
                            <p id="department" class="flex-grow-1 border"
                               style="text-align: left; padding-left: 10px;">${userDetail.department}</p>
                        </div>
                        <div class="form-group d-flex align-items-center">
                            <label for="note" class="font-weight-bold mr-2"
                                   style="width: 100px; text-align: left;">Note:</label>
                            <p id="note" class="flex-grow-1 border" style="text-align: left; padding-left: 10px;">
                                ${userDetail.note}
                            </p>
                        </div>
                    </div>
                </div>
                <div class="row justify-content-center">
                    <button class="mr-6 btn btn-space btn-primary btn-width active"
                            style="width: 100px;">Edit
                    </button>
                    <button class="ml-6 btn btn-space btn-secondary btn-width active"
                            style="width: 100px;" onclick="window.history.back();">Cancel
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="alert alert-contrast alert-danger alert-dismissible"
     role="alert" id="alert">
    <div class="icon"><span class="mdi mdi-close-circle-o"></span></div>
    <div class="message">

        <strong>Danger!</strong> Cannot deactivate itself.
    </div>
</div>


</body>
<script src="\lib\jquery\jquery.min.js" type="text/javascript"></script>
<script src="\lib\perfect-scrollbar\js\perfect-scrollbar.min.js" type="text/javascript"></script>
<script src="\lib\bootstrap\dist\js\bootstrap.bundle.min.js" type="text/javascript"></script>
<script src="\js\app.js" type="text/javascript"></script>
<script src="\lib\jquery.sparkline\jquery.sparkline.min.js" type="text/javascript"></script>
<script src="\lib\countup\countUp.min.js" type="text/javascript"></script>
<script src="\lib\jquery-ui\jquery-ui.min.js" type="text/javascript"></script>
<script src="\lib\jqvmap\jquery.vmap.min.js" type="text/javascript"></script>
<script src="\lib\jqvmap\maps\jquery.vmap.world.js" type="text/javascript"></script>
<script type="text/javascript">
    $(document).ready(function () {
        //-initialize the javascript
        App.init();
        App.dashboard();

    });

    function updateStatus(userId, sessionId) {

        if (userId === sessionId) {
            var errorAlert = document.getElementById('alert');
            errorAlert.classList.add('show');

            setTimeout(function() {
                errorAlert.classList.remove('show');
            }, 2000);
            return
        }

        var xhr = new XMLHttpRequest();

        xhr.open('POST', '/user/update-status', true);
        xhr.setRequestHeader('Content-Type', 'application/json');

        var data = {
            userId: userId
        };

        xhr.send(JSON.stringify(data));
        xhr.onreadystatechange = function () {
            if (xhr.readyState === XMLHttpRequest.DONE && xhr.status === 200) {
                location.reload();
            }
        };
    }
</script>


</html>