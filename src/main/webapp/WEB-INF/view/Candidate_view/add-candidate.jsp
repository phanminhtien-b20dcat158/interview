
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
    <link rel="stylesheet" type="text/css" href="/lib/multiselect/css/multi-select.css">
    <link rel="stylesheet" href="/css/app.css" type="text/css">
    <link rel="stylesheet" href="/css/virtual-select.min.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">
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
            <h1>Add New Candidate</h1>
            <c:if test="${not empty message}">
                <div class="text-danger" >${message}</div>
            </c:if>


            <%--@elvariable id="candidate" type=""--%>
            <form:form action="/candidate/addCandidate" method="post" modelAttribute="candidate" id="form" enctype="multipart/form-data">
                <div class="row">

                    <div class="col-md-6">
                        <div class="form-group">
                            <label >Full Name:
                                <span class="text-danger">*</span>
                            </label>
                            <form:input type="text" class="form-control " path="name" placeholder="Enter your full name" value="${candidate.name}" />
                            <form:errors path="name" cssClass="text-danger"></form:errors>
                        </div>
                        <div class="form-group">
                            <label for="dob">Date of Birth: <span class="text-danger">*</span></label>
                            <form:input type="date" class="form-control" path="dob" value="${candidate.dob}"/>
                            <form:errors cssClass="text-danger" path="dob"></form:errors>
                        </div>
                        <div class="form-group">
                            <label for="phone">Phone Number:</label>
                            <form:input type="tel" class="form-control" path="phone" placeholder="Enter your phone number" value="${candidate.phone}"/>
                            <form:errors path="phone" cssClass="text-danger"></form:errors>
                        </div>
                        <div class="form-group">
                            <label >File CV: "${candidate.cvAttachmentLink}")</label>
                            <input type="file" class="form-control"  id="input" name="cv" />

                        </div>
                        <div class="form-group">
                            <label>CurrentPosition: <span class="text-danger">*</span></label><br>
                            <form:select class="" path="currentPosition" id="position" value="${candidate.currentPosition}">
                                <form:option value="">Select </form:option>
                                <form:options items="${position}"/>
                            </form:select>
                            <form:errors path="currentPosition" cssClass="text-danger"></form:errors>
                        </div>
                        <div class="form-group">
                            <label>Skill: <span class="text-danger">*</span></label><br>
                            <select multiple name="skills" placeholder="Skill" data-search="true"
                                    data-silent-initial-value-set="true" id="skill" th:field="*{candidate.skills}">
                                <option value="Java">Java</option>
                                <option value="Nodejs">Nodejs</option>
                                <option value=".net">.NET</option>
                                <option value="C++">C++</option>
                                <option value="Business analysis">Business analysis</option>
                                <option value="Communication">Communication</option>
                                ...
                            </select>
                            <form:errors cssClass="text-danger" path="skills"></form:errors>
                        </div>

                        <div class="form-group">
                            <label>Recruiter: <span class="text-danger">*</span></label><br>
                            <form:select path="user" id="recruiter" data-search="true" value="${candidate.user}">
                                <form:option value="" selected="true">Choose Recruiter</form:option>
                                <form:option value="${user}">Asign Me</form:option>
                                <form:options items="${recruiters}" itemValue="userId" itemLabel="fullName"  />

                            </form:select>
                            <form:errors path="user" cssClass="text-danger"></form:errors>
                        </div>


                    </div>

                    <div class="col-md-6">
                        <div class="form-group">
                            <label for="email">Email: <span class="text-danger">*</span></label>
                            <input type="email" class="form-control" name="email" id="email" value="${candidate.email}" />
                            <form:errors cssClass="text-danger" path="email"></form:errors>
                        </div>
                        <div class="form-group">
                            <label for="address">Address:</label>
                            <form:input type="text" class="form-control" path="address" value="${candidate.address}"/>
                            <form:errors cssClass="text-danger" path="address"></form:errors>
                        </div>
                        <div class="form-group">
                            <label>Gender: <span class="text-danger">*</span></label><br>
                            <form:select class="form-control" path="gender" id="gender" value="${candidate.gender}">
                                <form:option value="">Select </form:option>
                                <form:options items="${gender}"/>
                            </form:select>
                            <form:errors cssClass="text-danger" path="gender"></form:errors>
                        </div>

                        <div class="form-group">
                            <label for="note">Note:</label>
                            <form:input class="form-control" path="note" value="${candidate.note}"/>
                            <form:errors cssClass="text-danger" path="note"></form:errors>
                        </div>
                        <div class="form-group">
                            <label>Status: <span class="text-danger">*</span></label><br>
                            <form:select class="" path="status" id="status" value="${candidate.status}">
                                <form:option value="">Select </form:option>
                                <form:options items="${status}"/>
                            </form:select>
                            <form:errors path="status" cssClass="text-danger"
                            ></form:errors>
                        </div>
                        <div class="form-group">
                            <label for="yearsExperience">Year of Experience: </label>
                            <form:input class="form-control" path="yearsExperience" value="${candidate.yearsExperience}"/>
                            <form:errors cssClass="text-danger" path="yearsExperience"></form:errors>
                        </div>
                        <div class="form-group">
                            <label>Highest Level: <span class="text-danger">*</span></label><br>
                            <form:select class="" path="highestLevel" id="highestlevel" value="${candidate.highestLevel}">
                                <form:option value="">Select </form:option>
                                <form:options items="${highlevel}"/>
                            </form:select>
                            <form:errors cssClass="text-danger" path="highestLevel"></form:errors>
                        </div>
                        <div class="form-group">
                            <form:select  id="recruiter" path="">
                                <form:option value="" selected="true">Job</form:option>
                                <form:options items="${jobList}"  itemLabel="title"    />

                            </form:select>
                        </div>
                    </div>
                </div>


                <div class="row justify-content-center" style="margin-top:20px;margin-bottom:50px;padding: 20px">
                    <div class="col-md-auto">
                        <button type="submit" class="btn btn-primary mx-20">Submit</button>
                        <a href="/candidate" type="button" class="btn btn-secondary">Cancel</a>
                    </div>
                </div>
            </form:form>
        </div>
    </div>

</div>
<div class="be-right-sidebar">
    <!-- Right sidebar -->
</div>
</div>
<script src="/js/virtual-select.min.js"></script>
<script>
    VirtualSelect.init({
        ele: 'select'
    });

</script>
<script>
    var input=document.getElementById('input')
    function getFullPath(input) {
        if (input.files && input.files[0]) {
            var file = input.files[0];
            console.log(file.path)
            document.getElementById('fullPathInput').value=file
            const downloadLink = document.createElement("a");
            downloadLink.href = URL.createObjectURL(pdfFile);
            downloadLink.download = pdfFile.name;
            document.body.appendChild(downloadLink);
            downloadLink.click();
            document.body.removeChild(downloadLink);
            console.log("Đã tải về tệp PDF:", pdfFile.name);
        }
    }

</script>
</body>