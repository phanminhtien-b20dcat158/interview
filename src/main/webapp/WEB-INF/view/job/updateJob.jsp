<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="vi">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" type="text/css" href="/lib/perfect-scrollbar/css/perfect-scrollbar.css">
    <link rel="stylesheet" type="text/css"
          href="/lib/material-design-icons/css/material-design-iconic-font.min.css">
    <link rel="stylesheet" type="text/css" href="/lib/datetimepicker/css/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" type="text/css" href="/lib/select2/css/select2.min.css">
    <link rel="stylesheet" type="text/css" href="/lib/bootstrap-slider/css/bootstrap-slider.min.css">
    <link rel="stylesheet" type="text/css" href="/multiselect/css/multi-select.css">
    <link rel="stylesheet" href="/css/app.css" type="text/css">
    <link rel="stylesheet" type="text/css" href="/css/job/update.css">
    <title>Update Job</title>
</head>

<body>
<jsp:include page="../layout/header.jsp" />
<jsp:include page="../layout/left-sidebar.jsp" />
<div class="be-content">
    <div class="main-content container-fluid">
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="/job">Job list</a></li>
                <li class="breadcrumb-item active" aria-current="page">Update job</li>
            </ol>
        </nav>
        <%--@elvariable id="update" type="" --%>
        <form:form action="/job/update" method="post" modelAttribute="update">
            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Id: </label>
                    <form:input type="text" class="form-control" path="jobId" name="jobId"
                                readonly="true" />
                </div>
                <div class="col-md-6">
                    <label class="form-label">Job title <span style="color: red;">*</span></label>
                    <form:input type="text" class="form-control" path="title" name="title"
                                required="true" />
                </div>
            </div>

            <!-- Skills, Benefits, and Levels Dropdowns -->
            <div class="row mb-3">
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="skills">Skills <span style="color: red;">*</span></label>
                        <div class="dropdown">
                            <button class="btn btn-secondary dropdown-toggle" type="button"
                                    id="skillsDropdown">
                                Select Skills
                            </button>
                            <div class="dropdown-menu" aria-labelledby="skillsDropdown"
                                 id="skillsMenu">
                                <input type="text" class="form-control" id="skillsSearch"
                                       placeholder="Search skills...">
                                <a class="dropdown-item" href="#" data-value="java">Java</a>
                                <a class="dropdown-item" href="#" data-value="nodejs">Node.js</a>
                                <a class="dropdown-item" href="#" data-value="net">.NET</a>
                                <a class="dropdown-item" href="#" data-value="cpp">C++</a>
                                <a class="dropdown-item" href="#"
                                   data-value="business-analysis">Business Analysis</a>
                                <a class="dropdown-item" href="#"
                                   data-value="communication">Communication</a>
                            </div>
                        </div>
                        <input type="hidden" id="skills" name="requiredSkills"
                               value="${update.requiredSkills}">
                        <div id="selectedSkills" class="mt-2"></div>
                        <span id="error-message-skills" style="color:red; display:none;">Please
                                                select at least one skill.</span>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="benefits">Benefits <span style="color: red;">*</span></label>
                        <div class="dropdown">
                            <button class="btn btn-secondary dropdown-toggle" type="button"
                                    id="benefitsDropdown">
                                Select Benefits
                            </button>
                            <div class="dropdown-menu" aria-labelledby="benefitsDropdown"
                                 id="benefitsMenu">
                                <input type="text" class="form-control" id="benefitsSearch"
                                       placeholder="Search benefits...">
                                <a class="dropdown-item" href="#" data-value="lunch">Lunch</a>
                                <a class="dropdown-item" href="#" data-value="leave">25-day
                                    leave</a>
                                <a class="dropdown-item" href="#" data-value="healthcare">Healthcare
                                    insurance</a>
                                <a class="dropdown-item" href="#" data-value="hybrid">Hybrid
                                    working</a>
                                <a class="dropdown-item" href="#" data-value="travel">Travel</a>
                            </div>
                        </div>
                        <input type="hidden" id="benefits" name="benefits"
                               value="${update.benefits}">
                        <div id="selectedBenefits" class="mt-2"></div>
                        <span id="error-message-benefits" style="color:red; display:none;">Please
                                                select at least one benefit.</span>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="form-group">
                        <label for="level">Levels <span style="color: red;">*</span></label>
                        <div class="dropdown">
                            <button class="btn btn-secondary dropdown-toggle" type="button"
                                    id="levelsDropdown">
                                Select Levels
                            </button>
                            <div class="dropdown-menu" aria-labelledby="levelsDropdown"
                                 id="levelsMenu">
                                <input type="text" class="form-control" id="levelsSearch"
                                       placeholder="Search levels...">
                                <a class="dropdown-item" href="#" data-value="fresher">Fresher</a>
                                <a class="dropdown-item" href="#" data-value="junior">Junior</a>
                                <a class="dropdown-item" href="#" data-value="senior">Senior</a>
                                <a class="dropdown-item" href="#" data-value="leader">Leader</a>
                                <a class="dropdown-item" href="#" data-value="manager">Manager</a>
                                <a class="dropdown-item" href="#" data-value="vice-head">Vice
                                    Head</a>
                            </div>
                        </div>
                        <input type="hidden" id="level" name="level" value="${update.level}">
                        <div id="selectedLevels" class="mt-2"></div>
                        <span id="error-message-levels" style="color:red; display:none;">Please
                                                select at least one level.</span>
                    </div>
                </div>
            </div>




            <!-- Date -->
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="startDate">Start date <span style="color: red;">*</span></label>
                    <form:input type="datetime-local" class="form-control datepicker"
                                path="startDate" name="startDate" />
                </div>
                <div class="col-md-6">
                    <label for="endDate">End date <span style="color: red;">*</span></label>
                    <form:input type="datetime-local" class="form-control datepicker" path="endDate"
                                name="endDate" />
                </div>
            </div>

            <!-- Salary -->
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="salaryFrom">Salary range from <span
                            style="color: red;">*</span></label>
                    <form:input type="text" class="form-control" path="salaryFrom" name="salaryFrom"
                                oninput="formatSalary(this)" />
                </div>
                <div class="col-md-6">
                    <label for="salaryTo">To <span style="color: red;">*</span></label>
                    <form:input type="text" class="form-control" path="salaryTo" name="salaryTo"
                                oninput="formatSalary(this)" />
                </div>
            </div>

            <!-- Address -->
            <div class="mb-3">
                <label for="location">Working address</label>
                <form:input type="text" class="form-control" path="location" name="location" />
            </div>

            <!-- Description -->
            <div class="mb-3">
                <label for="description">Description</label>
                <form:textarea class="form-control" path="description" name="description"
                               rows="3" />
            </div>

            <button type="submit" class="btn btn-primary"
                    onclick="return validateForm()">Submit</button>
            <a href="javascript:history.back()" class="btn btn-secondary">Cancel</a>

            <hr>
        </form:form>
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
<script src="/lib/jqvmap/maps/jquery.vmap.world.js" type="text/javascript"></script>1
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- Bootstrap JS -->
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
<!-- FontAwesome JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js"></script>
<script src="/js/job/update.js" type="text/javascript"></script>



</body>

</html>