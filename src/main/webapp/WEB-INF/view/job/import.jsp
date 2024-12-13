<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Excel File</title>

    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">

    <!-- Custom CSS -->
    <link rel="stylesheet" type="text/css" href="/lib/perfect-scrollbar/css/perfect-scrollbar.css">
    <link rel="stylesheet" type="text/css" href="/lib/material-design-icons/css/material-design-iconic-font.min.css">
    <link rel="stylesheet" type="text/css" href="/lib/datetimepicker/css/bootstrap-datetimepicker.min.css">
    <link rel="stylesheet" type="text/css" href="/lib/select2/css/select2.min.css">
    <link rel="stylesheet" type="text/css" href="/lib/bootstrap-slider/css/bootstrap-slider.min.css">
    <link rel="stylesheet" type="text/css" href="/multiselect/css/multi-select.css">
    <link rel="stylesheet" href="/css/app.css" type="text/css">
    <link rel="stylesheet" type="text/css" href="/css/job/import.css">


    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</head>

<body>

    <jsp:include page="../layout/header.jsp" />
    <jsp:include page="../layout/left-sidebar.jsp" />
    <div class="be-content" style="padding-top: 60px">
        <div class="main-content container">
            <h2 class="mb-4 text-center">Upload Excel File</h2>

            <!-- Hiển thị thông báo lỗi nếu có -->
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger" role="alert">
                    ${errorMessage}
                </div>
            </c:if>

            <form id="uploadForm" action="/job/import" method="POST" enctype="multipart/form-data">
                <div class="form-group">
                    <div class="custom-file">
                        <input type="file" class="custom-file-input" id="file" name="file" required>
                        <label class="custom-file-label" for="file">Choose Excel file</label>
                    </div>
                    <div id="fileError" class="text-danger mt-2" style="display: none;">Please upload a valid Excel file
                        (.xls or .xlsx).</div>
                </div>
                <button type="submit" class="btn btn-primary btn-block">Upload</button>
            </form>
            <div class="text-center mt-3">
                <a href="javascript:history.back()" class="btn btn-secondary">Back</a>
            </div>
        </div>
    </div>





    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.4.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script src="/js/job/import.js" type="text/javascript"></script>
    <script src="/lib/jquery/jquery.min.js" type="text/javascript"></script>
    <script src="/lib/perfect-scrollbar/js/perfect-scrollbar.min.js" type="text/javascript"></script>
    <script src="/lib/bootstrap/dist/js/bootstrap.bundle.min.js" type="text/javascript"></script>
    <script src="/js/app.js" type="text/javascript"></script>
    <script src="/lib/jquery.sparkline/jquery.sparkline.min.js" type="text/javascript"></script>
    <script src="/lib/countup/countUp.min.js" type="text/javascript"></script>
    <script src="/lib/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
    <script src="/lib/jqvmap/jquery.vmap.min.js" type="text/javascript"></script>
    <script src="/lib/jqvmap/maps/jquery.vmap.world.js" type="text/javascript"></script>


</body>

</html>