<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Edit Offer</title>
    <link rel="stylesheet" type="text/css" href="/lib/perfect-scrollbar/css/perfect-scrollbar.css">
    <link rel="stylesheet" type="text/css" href="/lib/material-design-icons/css/material-design-iconic-font.min.css">
    <link rel="stylesheet" type="text/css" href="/lib/datatables/datatables.net-bs4/css/dataTables.bootstrap4.css">
    <link rel="stylesheet" type="text/css"
          href="/lib/datatables/datatables.net-responsive-bs4/css/responsive.bootstrap4.min.css">
    <link rel="stylesheet" href="/css/app.css" type="text/css">
    <link rel="stylesheet" href="/css/app.css" type="text/css">
    <link rel="stylesheet" href="/css/offer/index.css" type="text/css">
    <style>
        .required {
            color: red;
            font-size: 18px;
            font-weight: bold;
        }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp"/>
<jsp:include page="../layout/left-sidebar.jsp"/>

<div class="be-content" style="margin-top: 60px;">
    <div class="main-content container-fluid">
        <div class="page-head mt-0 px-0" style="margin-top: 60px;">
            <h2 class="page-head-title">Edit Offer</h2>
            <nav aria-label="breadcrumb mt-2" role="navigation">
                <ol class="breadcrumb page-head-nav">
                    <li class="breadcrumb-item"><a href="/offers">Offer List</a></li>
                    <li class="breadcrumb-item active">Edit Offer</li>
                </ol>
            </nav>
        </div>

        <div class="">
            <form:form action="${pageContext.request.contextPath}/offers/${offer.offerId}" method="post"
                       modelAttribute="offer">
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="candidate">Candidate: <span class="required">*</span></label>
                            <form:select path="candidate.id" class="form-control" id="candidate" required="true">
                                <option value="" selected>Select a candidate</option>
                                <form:options items="${candidates}" itemValue="id" itemLabel="name"/>
                            </form:select>
                        </div>
                        <div class="form-group">
                            <label for="position">Position: <span class="required">*</span></label>
                            <form:select path="position" class="form-control" id="position" required="true">
                                <form:options items="${positions}"/>
                            </form:select>
                        </div>
                        <div class="form-group">
                            <label for="manager">Approved by: <span class="required">*</span></label>
                            <form:select path="approver" class="form-control" id="manager" required="true">
                                <form:option value="" label="Select Manager"/>
                                <form:options items="${managers}" itemValue="userId" itemLabel="fullName"/>
                            </form:select>
                        </div>
                        <div class="form-group">
                            <label for="interview">Interview Schedule:</label>
                            <form:select path="interview.interviewId" class="form-control" id="interview">
                                <form:option value="" label="Select Interview"/>
                                <form:options items="${interviews}" itemValue="interviewId" itemLabel="title"/>
                            </form:select>
                        </div>
                        <div class="form-group">
                            <label>Start Contract: <span class="required">*</span></label>
                            <div class="row">
                                <div class="col-md-6">
                                    From
                                    <form:input path="startContract" class="form-control" id="startContract"
                                                type="date" required="true" onchange="updateEndDate()"/>
                                </div>
                                <div class="col-md-6">
                                    To
                                    <form:input path="endContract" class="form-control" id="endContract" type="date"
                                                required="true"  onchange="updateStartDate()"/>
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="dueDate">Due Date: <span class="required">*</span></label>
                            <form:input path="dueDate" class="form-control" id="dueDate" type="date" required="true"/>
                        </div>

                        <div class="form-group">
                            <label>Status:</label>
                            <p>${offer.status}</p>
                            <form:hidden path="status" value="${offer.status}"/>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="contractType">Contract Type: <span class="required">*</span></label>
                            <form:select path="contractType" class="form-control" id="contractType" required="true">
                                <form:options items="${contractTypes}"/>
                            </form:select>
                        </div>
                        <div class="form-group">
                            <label for="level">Level: <span class="required">*</span></label>
                            <form:select path="level" class="form-control" id="level" required="true">
                                <form:options items="${levels}"/>
                            </form:select>
                        </div>
                        <div class="form-group">
                            <label for="department">Department:<span class="required">*</span></label>
                            <form:select path="department" class="form-control" id="department" required="true">
                                <form:options items="${departments}"/>
                            </form:select>
                        </div>
                        <div class="form-group">
                            <label for="recruiter">Recruiter:<span class="required">*</span></label>
                            <form:select path="recruiter" class="form-control" id="recruiter" required="true">
                                <form:option value="" label="Select Recruiter"/>
                                <form:options items="${recruiters}" itemValue="userId"
                                              itemLabel="fullNameWithAccountName"/>
                            </form:select>
                        </div>
                        <div class="form-group">
                            <label for="basicSalary">Basic Salary:<span class="required">*</span></label>
                            <form:input path="basicSalary" class="form-control" id="basicSalary" required="true"
                                        />
                        </div>
                        <div class="form-group">
                            <label for="note">Note:</label>
                            <form:textarea class="form-control" path="note" id="note" maxlength="500" rows="4"
                                           cols="50"/>
                        </div>
                    </div>
                </div>

                <div class="row d-f justify-content-center">
                    <button class="btn btn-info p-2 px-6 text-center" type="submit">Submit</button>
                    <span class="m-2"></span>
                    <button type="button" class="btn btn-secondary p-2 px-6 text-center"
                            onclick="window.history.back();">Cancel
                    </button>
                </div>
            </form:form>
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
    function formatNumber(input) {
        // Xóa tất cả các dấu chấm và ký tự không phải số
        let value = input.value.replace(/[^0-9]/g, '');
        // Chuyển đổi lại thành số và định dạng với dấu chấm
        value = Number(value).toLocaleString('en');
        // Đặt lại giá trị đã định dạng vào input
        input.value = value;
    }
    function updateEndDate() {
        var startDate = document.getElementById('startContract').value;
        document.getElementById('endContract').setAttribute('min', startDate);

        var endDate = document.getElementById('endContract').value;
        if (endDate < startDate) {
            document.getElementById('endContract').value = startDate;
        }
    }

    function updateStartDate() {
        var endDate = document.getElementById('endContract').value;
        document.getElementById('startContract').setAttribute('max', endDate);

        var startDate = document.getElementById('startContract').value;
        if (startDate > endDate) {
            document.getElementById('startContract').value = endDate;
        }
    }
</script>
</body>
</html>
