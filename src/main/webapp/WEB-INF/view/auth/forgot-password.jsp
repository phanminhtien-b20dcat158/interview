<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        Forgot Password
    </title>
    <link rel="stylesheet" type="text/css" href="\lib\perfect-scrollbar\css\perfect-scrollbar.css">
    <link rel="stylesheet" type="text/css"
          href="\lib\material-design-icons\css\material-design-iconic-font.min.css">
    <link rel="stylesheet" href="\css\app.css" type="text/css">

</head>

<body class="be-splash-screen">
<div class="be-wrapper be-login">
    <div class="be-content">
        <div class="main-content container-fluid">
            <div class="splash-container forgot-password">
                <div class="card card-border-color card-border-color-primary">
                    <div class="card-header"><img class="logo-img" src="\img\login_img.png" alt="logo"
                                                  width="130" height="40"><span class="splash-description">Forgot your
                                password?</span></div>
                    <c:if test="${not empty error}">
                        <h4 class="text-danger text-center font-weight-bold">${error}</h4>
                    </c:if>
                    <div class="card-body">
                        <form method="get" action="/forgot-password/send-email">
                            <p>Don't worry, we'll send you an email to reset your password.</p>

                            <div class="form-group pt-4">
                                <input class="form-control" type="email" name="email" required=""
                                       placeholder="Your Email" autocomplete="off">
                            </div>
                            <div class="form-group pt-3 d-flex justify-content-around">
                                <button class="btn btn-primary btn-md me-3">Send</button>
                                <a href="/login" class="btn btn-outline-primary btn-md">Cancel</a>
                            </div>
                        </form>
                    </div>
                </div>
                <div class="splash-footer">© 2018 Your Company</div>
            </div>
        </div>
    </div>
</div>
</body>

</html>