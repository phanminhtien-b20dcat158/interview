<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" type="text/css" href="\lib\perfect-scrollbar\css\perfect-scrollbar.css">
    <link rel="stylesheet" type="text/css"
          href="\lib\material-design-icons\css\material-design-iconic-font.min.css">
    <link rel="stylesheet" href="\css\app.css" type="text/css">

</head>

<body class="be-splash-screen">
<div class="be-wrapper be-login">
    <div class="be-content">
        <div class="main-content container-fluid">
            <div class="splash-container">
                <div class="card card-border-color card-border-color-primary">
                    <div class="card-header">
                        <img class="logo-img" src="\img\login_img.png" alt="logo" width="120" height="40">
                        <span class="splash-description">Please enter your user information.</span>
                        <c:if test="${param.error == 'disabled'}">
                            <div class="my-2" style="color: red;">Your account has been disabled.</div>
                        </c:if>
                        <c:if test="${param.error == 'invalid'}">
                            <div class="my-2" style="color: red;">Invalid username or password.</div>
                        </c:if>
                        <c:if test="${message != null}">
                            <div class="my-2" style="color: green;">${message}</div>
                        </c:if>
                    </div>
                    <div class="card-body">
                        <form action="/login" method="post">
                            <div class="form-group">
                                <input class="form-control" name="username" type="text" placeholder="Username" autocomplete="off">
                            </div>
                            <div class="form-group">
                                <input class="form-control" name="password" type="password" placeholder="Password">
                            </div>
                            <div class="form-group">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            </div>
                            <div class="form-group row login-tools">
                                <div class="col-6 login-remember">
                                    <div class="custom-control custom-checkbox">
                                        <input class="custom-control-input" type="checkbox" id="checkbox1">
                                        <label class="custom-control-label" for="checkbox1">Remember Me</label>
                                    </div>
                                </div>
                                <div class="col-6 login-forgot-password">
                                    <a href="/forgot-password" type="button">Forgot Password?</a>
                                </div>
                            </div>
                            <div class="form-group login-submit">
                                <button class="btn btn-primary btn-xl" type="submit">Sign me in</button>
                            </div>
                        </form>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
</body>


</html>