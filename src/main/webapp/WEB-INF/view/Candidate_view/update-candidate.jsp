<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c' %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="org.springframework.expression.spel.support.StandardEvaluationContext" %>
<%@ page import="org.springframework.expression.ExpressionParser" %>

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
    <link rel="stylesheet" type="text/css" href="/lib/multiselect/css/multi-select.css">
    <link rel="stylesheet" href="/css/app.css" type="text/css">
    <link rel="stylesheet" href="/css/virtual-select.min.css" type="text/css">
    <style>
        .vscomp-toggle-button {
            box-shadow: none;
            border: none;
        }
    </style>
</head>

<body>
<div class="be-wrapper">
    <jsp:include page="../layout/header.jsp"/>
    <jsp:include page="../layout/left-sidebar.jsp"/>
    <div class="be-content">
        <div class="container">
            <h1>Update </h1>
            <%--@elvariable id="candidate" type=""--%>
            <form:form action="/candidate/updateCandidate?id=${candidate.id}" method="post" modelAttribute="candidate"
                       id="form" enctype="multipart/form-data">
                <div class="row">

                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Full Name: <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" name="name" value="${candidate.name}"/>
                            <form:errors path="name" cssClass="text-danger"></form:errors>
                        </div>
                        <div class="form-group">
                            <label for="dob">Date of Birth: <span class="text-danger">*</span></label>
                            <form:input type="date" class="form-control" value="${candidate.dob}" path="dob"/>
                            <form:errors path="dob" cssClass="text-danger"></form:errors>
                        </div>
                        <div class="form-group">
                            <label for="phone">Phone Number:</label>
                            <form:input type="tel" class="form-control" path="phone"
                                        placeholder="Enter your phone number"/>
                            <form:errors path="phone" cssClass="text-danger"></form:errors>
                        </div>
                        <div class="form-group">
                            <label>File CV: (${candidate.cvAttachmentLink})</label>
                            <input type="file" class="form-control" id="input" name="cv"/>


                        </div>
                        <div class="form-group">
                            <label>CurrentPosition: <span class="text-danger">*</span></label><br>
                            <form:select class="" path="currentPosition" id="position">
                                <form:option value="">Select </form:option>
                                <form:options items="${position}"/>
                                <form:errors path="currentPosition" cssClass="text-danger"></form:errors>
                            </form:select>
                        </div>
                        <div class="form-group">
                            <label>Skill: <span class="text-danger">*</span></label><br>
                            <select multiple name="skills" placeholder="Skill" data-search="false"
                                    data-silent-initial-value-set="true" id="skill">
                                <option value="Java" ${fn:contains(candidate.skills, 'Java') ? 'selected' : ''}>Java
                                </option>
                                <option value="Nodejs" ${fn:contains(candidate.skills, 'Nodejs') ? 'selected' : ''}>
                                    Nodejs
                                </option>
                                <option value=".net" ${fn:contains(candidate.skills, '.net') ? 'selected' : ''}>.NET
                                </option>
                                <option value="C++" ${fn:contains(candidate.skills, 'C++') ? 'selected' : ''}>C++
                                </option>
                                <option value="Business analysis" ${fn:contains(candidate.skills, 'Business analysis') ? 'selected' : ''}>
                                    Business analysis
                                </option>
                                <option value="Communication" ${fn:contains(candidate.skills, 'Communication') ? 'selected' : ''}>
                                    Communication
                                </option>
                            </select>
                            <form:errors path="skills" cssClass="text-danger"></form:errors>
                        </div>

                        <div class="form-group">
                            <label>Recruiter: <span class="text-danger">*</span></label><br>
                            <form:select path="user" id="recruiter" data-search="true">
                                <%--                            <form:option value="" >Choose Recruiter</form:option>--%>
                                <form:option value="${user1}">Asign Me</form:option>
                                <form:options items="${recruiters}" itemValue="userId" itemLabel="fullName"/>

                            </form:select>
                            <form:errors path="user" cssClass="text-danger"></form:errors>
                        </div>


                    </div>

                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="email">Email: <span class="text-danger">*</span></label>
                            <input type="email" class="form-control" name="email" id="email" value="${candidate.email}"
                                   required/>
                        </div>
                        <div class="form-group">
                            <label for="address">Address:</label>
                            <form:input type="text" class="form-control" path="address"/>
                        </div>
                        <div class="form-group">
                            <label>Gender: <span class="text-danger">*</span></label><br>
                            <form:select class="form-control" path="gender" id="gender">
                                <form:option value="">Select </form:option>
                                <form:options items="${gender}"/>
                            </form:select>
                            <form:errors path="gender" cssClass="text-danger"></form:errors>
                        </div>

                        <div class="form-group">
                            <label for="note">Note:</label>
                            <form:input class="form-control" path="note"/>
                        </div>
                        <div class="form-group">
                            <label>Status: <span class="text-danger">*</span></label><br>
                            <form:select class="" path="status" id="status">
                                <form:option value="">Select </form:option>
                                <form:options items="${status}"/>
                            </form:select>
                            <form:errors path="status" cssClass="text-danger"></form:errors>
                        </div>
                        <div class="form-group">
                            <label for="yearsExperience">Year of Experience:</label>
                            <form:input class="form-control" path="yearsExperience"/>
                        </div>
                        <div class="form-group">
                            <label>Highest Level: <span class="text-danger">*</span></label><br>
                            <form:select class="" path="highestLevel" id="highestlevel">
                                <form:option value="">Select </form:option>
                                <form:options items="${highlevel}"/>
                            </form:select>
                            <form:errors path="highestLevel" cssClass="text-danger"></form:errors>
                        </div>
                    </div>
                </div>


                <div class="row justify-content-center" style="margin-top:20px;margin-bottom:50px;padding: 20px">
                    <div class="col-md-auto">
                        <button type="submit" class="btn btn-primary mx-20">Submit</button>
                        <a href="/candidate" type="button" class="btn btn-secondary">
                            Cancel

                        </a>
                    </div>
                </div>
            </form:form>
        </div>
    </div>

</div>
</div>
<script src="/js/virtual-select.min.js"></script>
<script>
    VirtualSelect.init({
        ele: 'select'
    });

    function handleAssignMeClick(select) {
        if (select.value === "${user1}") {
            // Chuyển giá trị của select box thành "user 1"
            select.value = "${user1}";
        }
    }
</script>

</body>