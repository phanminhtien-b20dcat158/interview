
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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


    <link rel="stylesheet" href="/css/virtual-select.min.css" type="text/css">
</head>
<body>
<div class="be-wrapper">
    <jsp:include page="../layout/header.jsp"/>
    <jsp:include page="../layout/left-sidebar.jsp"/>
<div class="be-content" style="padding: 30px">
    <h2 class="mb-4">Candidate Detail</h2>
    <div class="d-flex justify-content-end mb-3">
        <a href="/candidate/ban?id=${candidate.id}" class="btn btn-warning" id="state">
            <i class="bi bi-person-x-fill"></i> Ban Candidate
        </a>
    </div>
    <div class="text-end mb-3">
        <p class="text-muted">Created on ${candidate.createdAt} | Last modified on ${candidate.updatedAt}</p>
    </div>
    <div class="row">
        <div class="col-md-6 mb-4">
            <div class="mb-3 row">
                <label class="col-sm-4 col-form-label fw-bold">Full Name:</label>
                <div class="col-sm-8">
                    <p class="form-control-plaintext">${candidate.name}</p>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-4 col-form-label fw-bold">Date of Birth:</label>
                <div class="col-sm-8">
                    <p class="form-control-plaintext">${candidate.dob}</p>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-4 col-form-label fw-bold">Phone Number:</label>
                <div class="col-sm-8">
                    <p class="form-control-plaintext">${candidate.phone}</p>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-4 col-form-label fw-bold">File CV:</label>
                <div class="col-sm-8">
                    <p class="form-control-plaintext">
                        <a href="${candidate.cvAttachmentLink}" target="_blank" class="text-decoration-none">View CV</a>
                    </p>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-4 col-form-label fw-bold">Current Position:</label>
                <div class="col-sm-8">
                    <p class="form-control-plaintext">${candidate.currentPosition}</p>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-4 col-form-label fw-bold">Skills:</label>
                <div class="col-sm-8">
                    <p class="form-control-plaintext">${candidate.skills}</p>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-4 col-form-label fw-bold">Recruiter:</label>
                <div class="col-sm-8">
                    <p class="form-control-plaintext">${candidate.user.fullName}</p>
                </div>
            </div>
        </div>
        <div class="col-md-6 mb-4">
            <div class="mb-3 row">
                <label class="col-sm-4 col-form-label fw-bold">Email:</label>
                <div class="col-sm-8">
                    <p class="form-control-plaintext">${candidate.email}</p>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-4 col-form-label fw-bold">Address:</label>
                <div class="col-sm-8">
                    <p class="form-control-plaintext">${candidate.address}</p>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-4 col-form-label fw-bold">Gender:</label>
                <div class="col-sm-8">
                    <p class="form-control-plaintext">${candidate.gender}</p>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-4 col-form-label fw-bold">Note:</label>
                <div class="col-sm-8">
                    <p class="form-control-plaintext">${candidate.note}</p>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-4 col-form-label fw-bold">Status:</label>
                <div class="col-sm-8">
                    <p class="form-control-plaintext">${candidate.status}</p>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-4 col-form-label fw-bold">Years of Experience:</label>
                <div class="col-sm-8">
                    <p class="form-control-plaintext">${candidate.yearsExperience}</p>
                </div>
            </div>
            <div class="mb-3 row">
                <label class="col-sm-4 col-form-label fw-bold">Highest Level:</label>
                <div class="col-sm-8">
                    <p class="form-control-plaintext">${candidate.highestLevel}</p>
                </div>
            </div>
        </div>
    </div>

</div>
</body>