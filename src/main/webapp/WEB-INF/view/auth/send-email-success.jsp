<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Password Sent</title>
    <link rel="stylesheet" type="text/css" href="\lib\perfect-scrollbar\css\perfect-scrollbar.css">
    <link rel="stylesheet" type="text/css"
          href="\lib\material-design-icons\css\material-design-iconic-font.min.css">
    <link rel="stylesheet" href="\css\app.css" type="text/css">
    <style>
        .notification-container {
            max-width: 400px;
            margin: auto;
            padding: 30px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            text-align: center;
            margin-top: 50px;
        }
    </style>
</head>

<body>
<div class="container">
    <div class="card notification-container">
        <div class="card-body">
            <div class="alert alert-success">
                Chúng tôi đã gửi một mật khẩu mới đến email. Mật khẩu có hiệu lực trong vòng 24 tiếng trước khi kích
                hoạt.
            </div>
            <a class="btn btn-primary" href="/login">Quay trở lại Đăng nhập</a>
        </div>
    </div>
</div>


<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>

</html>