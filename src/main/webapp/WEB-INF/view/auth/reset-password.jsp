<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password</title>
    <link rel="stylesheet" type="text/css" href="/lib/perfect-scrollbar/css/perfect-scrollbar.css">
    <link rel="stylesheet" type="text/css" href="/lib/material-design-icons/css/material-design-iconic-font.min.css">
    <link rel="stylesheet" href="/css/app.css" type="text/css">
</head>

<body class="be-splash-screen">
<div class="be-wrapper be-login">
    <div class="be-content">
        <div class="main-content container-fluid">
            <div class="splash-container reset-password">
                <div class="card card-border-color card-border-color-primary">
                    <div class="card-header">
                        <img class="logo-img" src="/img/login_img.png" alt="logo" width="130" height="40">
                        <span class="splash-description">Reset your password</span>
                    </div>
                    <div class="card-body">
                        <form method="post" action="/forgot-password/reset-password" onsubmit="return validatePasswords()">
                            <p>Enter your new password and confirm it.</p>

                            <!-- Hidden field for token -->
                            <input type="hidden" name="token" value="${token}"/>

                            <div class="form-group pt-4">
                                <input class="form-control" type="password" name="password" required="" placeholder="New Password" autocomplete="off" id="password">
                            </div>
                            <div class="form-group pt-3">
                                <input class="form-control" type="password" name="confirmPassword" required="" placeholder="Confirm Password" autocomplete="off" id="confirmPassword">
                            </div>
                            <div class="form-group pt-3 d-flex justify-content-around">
                                <button class="btn btn-primary btn-md me-3" type="submit">Reset</button>
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
<script>
    function validatePasswords() {
        var password = document.getElementById("password").value;
        var confirmPassword = document.getElementById("confirmPassword").value;

        if (password !== confirmPassword) {
            alert("Passwords do not match. Please try again.");
            return false;
        }

        return true;
    }
</script>
</html>
