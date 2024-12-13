<%@ page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Job List</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

                <link rel="stylesheet"
                    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
                <link rel="stylesheet" type="text/css" href="/lib/perfect-scrollbar/css/perfect-scrollbar.css">
                <link rel="stylesheet" type="text/css"
                    href="/lib/material-design-icons/css/material-design-iconic-font.min.css">
                <link rel="stylesheet" type="text/css" href="/lib/datetimepicker/css/bootstrap-datetimepicker.min.css">
                <link rel="stylesheet" type="text/css" href="/lib/select2/css/select2.min.css">
                <link rel="stylesheet" type="text/css" href="/lib/bootstrap-slider/css/bootstrap-slider.min.css">
                <link rel="stylesheet" type="text/css" href="/multiselect/css/multi-select.css">
                <link rel="stylesheet" href="/css/app.css" type="text/css">
                <link rel="stylesheet" type="text/css" href="css/job/list.css">


                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

            </head>

            <body>
                <jsp:include page="../layout/header.jsp" />

                <jsp:include page="../layout/left-sidebar.jsp" />
                <% if (request.getAttribute("errorMessage") !=null) { %>
                    <div class="alert alert-danger">
                        <%= request.getAttribute("errorMessage") %>
                    </div>
                    <% } %>

                        <div class="be-content " style="margin-top: 60px;">
                            <div class="main-content container-fluid">
                                <div class="col-12 mx-auto">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <h1 class="job-list-title">Job List</h1>
                                        <c:if test="${not empty successMessage}">
                                            <div id="successMessage" class="alert alert-success">
                                                ${successMessage}
                                            </div>
                                        </c:if>
                                        <div>
                                            <c:if test="${isAdminOrManagerOrRecruiter}">
                                                <a href="/job/import" class="icon-link">
                                                    <i class="fas fa-file-import"></i> Import
                                                </a>
                                                <a href="/job/create" class="icon-link">
                                                    <i class="fas fa-briefcase"></i> Create a job
                                                </a>
                                            </c:if>
                                        </div>


                                    </div>
                                    <div class="container mt-2">
                                        <form action="/job" method="GET" style="display: flex; align-items: center;">
                                            <div class="search-box" style="flex: 0 0 50%; margin-right: 10px;">
                                                <input style="width: 100%;color: #134B70;" class="form-control"
                                                    type="search" name="keyword" placeholder="Search"
                                                    aria-label="Search" value="${keyword != null ? keyword : ''}">
                                            </div>
                                            <div class="col-auto"
                                                style="display: flex; align-items: center; margin-right: 10px;">
                                                <label for="statusSelect"
                                                    style="margin-right: 1rem; font-size: 18px; color: #134B70;">Status</label>
                                                <div class="custom-select-arrow">
                                                    <select class="form-control" name="status" id="statusSelect"
                                                        style="height: 3rem; font-size: 12px; color: #134B70">
                                                        <option value="" ${status=='' ? 'selected' : '' }>ALL</option>
                                                        <option value="open" ${status=='open' ? 'selected' : '' }>OPEN
                                                        </option>
                                                        <option value="draft" ${status=='draft' ? 'selected' : '' }>
                                                            DRAFT
                                                        </option>
                                                        <option value="close" ${status=='close' ? 'selected' : '' }>
                                                            CLOSE
                                                        </option>
                                                    </select>
                                                </div>
                                            </div>
                                            <button type="submit" class="btn btn-info">
                                                <i class="fas fa-search"></i> <!-- Biểu tượng tìm kiếm -->
                                            </button>
                                        </form>

                                        <% String alertMessage=(String) request.getAttribute("message"); %>
                                            <% if (alertMessage !=null) { %>
                                                <div class="alert alert-info text-center" role="alert">
                                                    <%= alertMessage %>
                                                </div>
                                                <% } %>
                                    </div>

                                    <hr />
                                    <table class="table table-bordered table-hover">
                                        <thead>
                                            <tr>
                                                <th style="border-radius: 12px 0 0 0;">STT</th>
                                                <th>Job Title</th>
                                                <th>Required Skills</th>
                                                <th>Start date</th>
                                                <th>End date</th>
                                                <th>Level</th>
                                                <th>Status</th>
                                                <th style="border-radius: 0 12px 0 0;">Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:choose>
                                                <c:when test="${not empty listjobs.content}">
                                                    <!-- Hiển thị danh sách công việc nếu có dữ liệu -->
                                                    <c:forEach var="index" begin="0"
                                                        end="${listjobs.content.size() - 1}" varStatus="loop">
                                                        <tr>
                                                            <td>${loop.index + 1}</td> <!-- Số thứ tự bắt đầu từ 1 -->
                                                            <td class="title">${listjobs.content[index].title}</td>
                                                            <td class="requiredSkills">
                                                                ${listjobs.content[index].requiredSkills}</td>
                                                            <td>${listjobs.content[index].startDate}</td>
                                                            <td>${listjobs.content[index].endDate}</td>
                                                            <td class="level">${listjobs.content[index].level}</td>
                                                            <td>${listjobs.content[index].status}</td>
                                                            <td>
                                                                <a href="/job/detail/${listjobs.content[index].jobId}"
                                                                    class="text-success">
                                                                    <i class="fas fa-eye"></i> <!-- Icon for View -->
                                                                </a>
                                                                <c:if test="${isAdminOrManagerOrRecruiter}">
                                                                    <a href="/job/update/${listjobs.content[index].jobId}"
                                                                        class="text-warning mx-2">
                                                                        <i class="fas fa-edit"></i>
                                                                        <!-- Icon for Update -->
                                                                    </a>
                                                                    <a href="javascript:void(0);" class="text-danger"
                                                                        onclick="confirmDelete(${listjobs.content[index].jobId})">
                                                                        <i class="fas fa-trash"></i>
                                                                        <!-- Icon for Delete -->
                                                                    </a>
                                                                </c:if>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>

                                                </c:when>
                                            </c:choose>
                                        </tbody>
                                    </table>
                                    <nav class="pagination-container" aria-label="Page navigation example">
                                        <ul class="pagination">
                                            <c:choose>
                                                <c:when test="${listjobs.number > 0}">
                                                    <li class="page-item"><a class="page-link" href="/job?p=0">First</a>
                                                    </li>
                                                </c:when>
                                            </c:choose>
                                            <!-- <c:choose>
                                                <c:when test="${listjobs.number > 0}">
                                                    <li class="page-item">
                                                        <a class="page-link"
                                                            href="/job?p=${listjobs.number - 1}">Previous</a>
                                                    </li>
                                                </c:when>
                                            </c:choose> -->

                                            <!-- Hiển thị số trang -->
                                            <c:choose>
                                                <c:when test="${listjobs.totalPages > 0}">
                                                    <c:forEach var="page" begin="0" end="${listjobs.totalPages - 1}">
                                                        <c:choose>
                                                            <c:when test="${page == listjobs.number}">
                                                                <li class="page-item active">
                                                                    <span class="page-link">${page + 1}</span>
                                                                </li>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <li class="page-item">
                                                                    <a class="page-link" href="/job?p=${page}">${page +
                                                                        1}</a>
                                                                </li>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                </c:when>
                                                <c:otherwise>
                                                    <li class="page-item disabled">
                                                        <span class="page-link">No pages available</span>
                                                    </li>
                                                </c:otherwise>
                                            </c:choose>


                                            <!-- <c:choose>
                                                <c:when test="${listjobs.number < listjobs.totalPages - 1}">
                                                    <li class="page-item">
                                                        <a class="page-link"
                                                            href="/job?p=${listjobs.number + 1}">Next</a>
                                                    </li>
                                                </c:when>
                                            </c:choose> -->
                                            <c:choose>
                                                <c:when test="${listjobs.number < listjobs.totalPages - 1}">
                                                    <li class="page-item"><a class="page-link"
                                                            href="/job?p=${listjobs.totalPages - 1}">Last</a></li>
                                                </c:when>
                                            </c:choose>
                                        </ul>
                                    </nav>


                                </div>
                            </div>
                        </div>
                        <script>
                            function confirmDelete(jobId) {
                                Swal.fire({
                                    title: 'Bạn có chắc muốn xóa công việc này không?',
                                    icon: 'warning',
                                    showCancelButton: true,
                                    confirmButtonColor: '#3085d6',
                                    cancelButtonColor: '#d33',
                                    confirmButtonText: 'Xóa',
                                    cancelButtonText: 'Hủy'
                                }).then((result) => {
                                    if (result.isConfirmed) {
                                        window.location.href = "/job/delete/" + jobId;
                                    }
                                });
                            }

                            window.onload = function () {
                                var successMessage = document.getElementById('successMessage');
                                if (successMessage) {
                                    setTimeout(function () {
                                        successMessage.style.display = 'none';
                                    }, 3000); // 3000 milliseconds = 3 seconds
                                }
                            };


                            function formatString(input) {
                                return input.split(',').map(item => {
                                    return item.trim().charAt(0).toUpperCase() + item.trim().slice(1).toLowerCase();
                                }).join(', ');
                            }

                            document.addEventListener("DOMContentLoaded", function () {
                                var requiredSkillsElements = document.querySelectorAll('.requiredSkills');
                                var levelElements = document.querySelectorAll('.level');
                                var titleElements = document.querySelectorAll('.title');

                                requiredSkillsElements.forEach(function (element) {
                                    element.innerText = formatString(element.innerText);
                                });

                                levelElements.forEach(function (element) {
                                    element.innerText = formatString(element.innerText);
                                });
                                titleElements.forEach(function (element) {
                                    element.innerText = formatString(element.innerText);
                                });
                            });


                        </script>
                        <!-- Thêm SweetAlert CSS -->
                        <link rel="stylesheet"
                            href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">

                        <!-- Thêm SweetAlert JavaScript -->
                        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>

                        <script src="/lib/jquery/jquery.min.js" type="text/javascript"></script>
                        <script src="/lib/perfect-scrollbar/js/perfect-scrollbar.min.js"
                            type="text/javascript"></script>
                        <script src="/lib/bootstrap/dist/js/bootstrap.bundle.min.js" type="text/javascript"></script>
                        <script src="/js/app.js" type="text/javascript"></script>
                        <script src="/lib/jquery.sparkline/jquery.sparkline.min.js" type="text/javascript"></script>
                        <script src="/lib/countup/countUp.min.js" type="text/javascript"></script>
                        <script src="/lib/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
                        <script src="/lib/jqvmap/jquery.vmap.min.js" type="text/javascript"></script>
                        <script src="/lib/jqvmap/maps/jquery.vmap.world.js" type="text/javascript"></script>

            </body>


            </html>