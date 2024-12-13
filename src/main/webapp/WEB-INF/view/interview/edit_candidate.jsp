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
    <link rel="stylesheet" type="text/css" href="/multiselect/css/multi-select.css">
    <link rel="stylesheet" href="/css/app.css" type="text/css">
    <link rel="stylesheet" href="/css/interview/edit_candidate.css">
</head>
<body>
<div class="be-wrapper">
    <%@include file="../layout/header.jsp"%>
    <%@include file="../layout/left-sidebar.jsp"%>


    <div class="be-content">
        <div class="page-head">
            <h2 class="page-head-title">Edit Interview Schedule</h2>
        </div>
        <div class="main-content container-fluid">
            <div class="card text-center">
                <div class="card-body">
                    <form:form action="/interview/edit_candidate" method="post" modelAttribute="newInterview">
                        <form:input type="text" class="d-none" id="title" path="interviewId" value="${newInterview.interviewId}" />
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="bs-grid-block">
                                    <div class="card text-center">
                                        <div class="card-body">
                                            <div class="form-group row d-flex justify-content-center">
                                                <label class="col-12 col-sm-2 col-form-label text-sm-left mr-4 star">Candidate name</label>
                                                <div class="col-12 col-sm-8 col-lg-8 text-sm-left">
                                                    <form:select class="select2" id="candidate" path="candidate.id">
                                                        <option value="" disabled selected>Select a candidate</option>
                                                        <c:forEach var="candidate" items="${candidates}">
                                                            <form:option value="${candidate.id}">
                                                                ${candidate.name}
                                                            </form:option>
                                                        </c:forEach>
                                                    </form:select>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="bs-grid-block">
                                    <div class="card text-center">
                                        <div class="d-flex justify-content-center align-items-center card-body">
                                            <div class="">
                                                <a href="/interview/list">
                                                    <button type="button" class="ml-6 btn btn-space btn-secondary btn-width active">Cancel</button>
                                                </a>
                                                <button type="submit" class="mr-6 btn btn-space btn-secondary btn-width active">Next</button>

                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form:form>
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
<script src="/lib/bootstrap/dist/js/bootstrap.bundle.min.js" type="text/javascript"></script>
<script src="/lib/multiselect/js/jquery.multi-select.js" type="text/javascript"></script>
<script src="/lib/quicksearch/jquery.quicksearch.min.js" type="text/javascript"></script>
<script src="/lib/select2/js/select2.min.js" type="text/javascript"></script>
<script src="/lib/select2/js/select2.full.min.js" type="text/javascript"></script>
<script src="/lib/bootstrap-slider/bootstrap-slider.min.js" type="text/javascript"></script>
<script src="/lib/bs-custom-file-input/bs-custom-file-input.js" type="text/javascript"></script>
<script src="/js/interview/edit_candidate.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        //-initialize the javascript
        App.init();
        App.formElements();
        App.formMultiselect();
        App.IconsFilter();
    });
</script>

</body>
</html>



