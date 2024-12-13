<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
            <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8">
                    <meta name="viewport"
                        content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
                    <meta http-equiv="X-UA-Compatible" content="IE=edge">
                    <meta name="description" content="">
                    <meta name="author" content="">
                    <link rel="shortcut icon" href="/img/logo-fav.png">
                    <title>Beagle</title>
                    <link rel="stylesheet" type="text/css" href="/lib/perfect-scrollbar/css/perfect-scrollbar.css">
                    <link rel="stylesheet" type="text/css"
                        href="/lib/material-design-icons/css/material-design-iconic-font.min.css">
                    <link rel="stylesheet" type="text/css"
                        href="/lib/datatables/datatables.net-bs4/css/dataTables.bootstrap4.css">
                    <link rel="stylesheet" type="text/css"
                        href="/lib/datatables/datatables.net-responsive-bs4/css/responsive.bootstrap4.min.css">
                    <link rel="stylesheet" href="/css/app.css" type="text/css">

                </head>

                <body>
                    <jsp:include page="../layout/header.jsp" />

                    <jsp:include page="../layout/left-sidebar.jsp" />

                    <div class="be-content" style="margin-top: 60px;">
                        <div class="main-content container-fluid">
                            <div class="page-head">
                                <h2 class="page-head-title">User Managerment</h2>
                                <nav aria-label="breadcrumb" role="navigation">
                                    <ol class="breadcrumb page-head-nav">
                                        <li class="breadcrumb-item active">User List</li>
                                    </ol>
                                </nav>
                            </div>

                            <div class="form-group row p-4">
                                <div class="col-12 col-sm-5 col-lg-4">
                                    <form action="/user" method="get" class="input-group input-search">
                                        <input class="form-control" type="text" name="keyword" placeholder="Search"
                                            value="${keyword}">
                                        <span class="input-group-btn">
                                            <button class="btn btn-secondary" type="submit"><i
                                                    class="icon mdi mdi-search"></i></button>
                                        </span>
                                    </form>
                                </div>
                                <div class="col-12 col-sm-5 col-lg-3 mb-2 mb-sm-0">
                                    <form action="/user" method="get" style="height: 100%;">
                                        <input type="hidden" name="keyword" value="${keyword}">
                                        <select name="roleId" class="select2 select2-hidden-accessible"
                                            id="icon-category" tabindex="-1" aria-hidden="true"
                                            style="width: 100%; height: 100%; padding-left: 12px;"
                                            onchange="this.form.submit()">
                                            <option value="">All roles</option>
                                            <c:forEach items="${listRole}" var="role">
                                                <option value="${role.roleId}" ${role.roleId==roleId ? 'selected' : ''
                                                    }>${role.roleName}</option>
                                            </c:forEach>
                                        </select>
                                    </form>
                                </div>
                                <div class="col-12 col-sm-2 col-lg-5 d-flex justify-content-end">
                                    <a href="/user/create" class="btn d-flex justify-content-center align-items-center"
                                        style="border-radius: 50%; border: 1px #000 solid;width: 40px; height: 40px">
                                        <img src="/img/add-user.png" style="width: 20px; height: 20px" />
                                    </a>
                                </div>
                            </div>

                            <div class="col-sm-12">
                                <div class="card card-table">
                                    <div class="card-body">
                                        <div id="table2_wrapper" class="dataTables_wrapper dt-bootstrap4 no-footer">
                                            <div class="row be-datatable-body">
                                                <div class="col-sm-12">
                                                    <table
                                                        class="table table-striped table-hover table-fw-widget dataTable no-footer"
                                                        id="table2" role="grid" aria-describedby="table2_info">
                                                        <thead>
                                                            <tr role="row">
                                                                <th class="text-center" tabindex="0"
                                                                    aria-controls="table2" rowspan="1" colspan="1"
                                                                    aria-sort="ascending"
                                                                    aria-label="Rendering engine: activate to sort column descending"
                                                                    style="width: 100px;">Username</th>
                                                                <th class="text-center" tabindex="0"
                                                                    aria-controls="table2" rowspan="1" colspan="1"
                                                                    aria-label="Browser: activate to sort column ascending"
                                                                    style="width: 220px;">Email</th>
                                                                <th class="text-center" tabindex="0"
                                                                    aria-controls="table2" rowspan="1" colspan="1"
                                                                    aria-label="Platform(s): activate to sort column ascending"
                                                                    style="width: 200px;">Phone No.</th>
                                                                <th class="text-center" tabindex="0"
                                                                    aria-controls="table2" rowspan="1" colspan="1"
                                                                    aria-label="Engine version: activate to sort column ascending"
                                                                    style="width: 120px;">Role</th>
                                                                <th class="text-center" tabindex="0"
                                                                    aria-controls="table2" rowspan="1" colspan="1"
                                                                    aria-label="CSS grade: activate to sort column ascending"
                                                                    style="width: 120px;">Status</th>
                                                                <th class="text-center" tabindex="0"
                                                                    aria-controls="table2" rowspan="1" colspan="1"
                                                                    aria-label="CSS grade: activate to sort column ascending"
                                                                    style="width: 120px;">Action</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <c:forEach items="${userPage.content}" var="user">
                                                                <tr class="gradeA odd" role="row">
                                                                    <td class="text-center">${user.username}</td>
                                                                    <td class="text-center">${user.email}</td>
                                                                    <td class="text-center">${user.phoneNumber}</td>
                                                                    <td class="text-center">${user.role}</td>
                                                                    <td class="text-center">${user.status}</td>
                                                                    <td class="text-center">
                                                                        <a href="/user/detail/${user.userId}"
                                                                            class="btn btn-info">Detail</a>
                                                                        <a href="/user/update/${user.userId}"
                                                                            class="btn btn-danger">Update</a>
                                                                    </td>
                                                                </tr>
                                                            </c:forEach>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                            <div class="row be-datatable-footer">
                                                <div class="col-sm-7">
                                                    <div class="dataTables_paginate paging_simple_numbers"
                                                        id="table2_paginate">
                                                        <nav aria-label="Page navigation example">
                                                            <ul class="pagination">
                                                                <c:if test="${userPage.hasPrevious()}">
                                                                    <li class="page-item">
                                                                        <a class="page-link"
                                                                            href="?page=${userPage.number - 1}&keyword=${keyword}&roleId=${roleId}"
                                                                            aria-label="Previous">
                                                                            <span aria-hidden="true">&laquo;</span>
                                                                        </a>
                                                                    </li>
                                                                </c:if>
                                                                <c:if test="${!userPage.hasPrevious()}">
                                                                    <li class="page-item disabled">
                                                                        <a class="page-link" href="#"
                                                                            aria-label="Previous">
                                                                            <span aria-hidden="true">&laquo;</span>
                                                                        </a>
                                                                    </li>
                                                                </c:if>

                                                                <c:forEach begin="1" end="${userPage.totalPages}"
                                                                    var="page">
                                                                    <li
                                                                        class="page-item ${userPage.number + 1 == page ? 'active' : ''}">
                                                                        <a class="page-link"
                                                                            href="?page=${page - 1}&keyword=${keyword}&roleId=${roleId}">${page}</a>
                                                                    </li>
                                                                </c:forEach>

                                                                <c:if test="${userPage.hasNext()}">
                                                                    <li class="page-item">
                                                                        <a class="page-link"
                                                                            href="?page=${userPage.number + 1}&keyword=${keyword}&roleId=${roleId}"
                                                                            aria-label="Next">
                                                                            <span aria-hidden="true">&raquo;</span>
                                                                        </a>
                                                                    </li>
                                                                </c:if>
                                                                <c:if test="${!userPage.hasNext()}">
                                                                    <li class="page-item disabled">
                                                                        <a class="page-link" href="#" aria-label="Next">
                                                                            <span aria-hidden="true">&raquo;</span>
                                                                        </a>
                                                                    </li>
                                                                </c:if>
                                                            </ul>
                                                        </nav>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                </body>
                <script src="\lib\jquery\jquery.min.js" type="text/javascript"></script>
                <script src="\lib\perfect-scrollbar\js\perfect-scrollbar.min.js" type="text/javascript"></script>
                <script src="\lib\bootstrap\dist\js\bootstrap.bundle.min.js" type="text/javascript"></script>
                <script src="\js\app.js" type="text/javascript"></script>
                <script src="\lib\jquery.sparkline\jquery.sparkline.min.js" type="text/javascript"></script>
                <script src="\lib\countup\countUp.min.js" type="text/javascript"></script>
                <script src="\lib\jquery-ui\jquery-ui.min.js" type="text/javascript"></script>
                <script src="\lib\jqvmap\jquery.vmap.min.js" type="text/javascript"></script>
                <script src="\lib\jqvmap\maps\jquery.vmap.world.js" type="text/javascript"></script>
                <script type="text/javascript">
                    $(document).ready(function () {
                        //-initialize the javascript
                        App.init();
                        App.dashboard();

                    });
                </script>

                </html>