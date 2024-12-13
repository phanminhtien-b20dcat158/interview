<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Offers</title>
    <link rel="stylesheet" type="text/css" href="/lib/perfect-scrollbar/css/perfect-scrollbar.css">
    <link rel="stylesheet" type="text/css" href="/lib/material-design-icons/css/material-design-iconic-font.min.css">
    <link rel="stylesheet" type="text/css" href="/lib/datatables/datatables.net-bs4/css/dataTables.bootstrap4.css">
    <link rel="stylesheet" type="text/css"
          href="/lib/datatables/datatables.net-responsive-bs4/css/responsive.bootstrap4.min.css">
    <link rel="stylesheet" href="/css/app.css" type="text/css">
    <link rel="stylesheet" href="/css/offer/index.css" type="text/css">
    <style>
        .dropdown-menu.custom-dropdown {
            transform: translate3d(-123px, 45px, 0);
        }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp"/>
<jsp:include page="../layout/left-sidebar.jsp"/>

<div class="be-content" style="margin-top: 60px;">
    <div class="main-content container-fluid">
        <div class="" style="margin-top: 0px">
            <h2 class="">Offer Management</h2>
            <nav aria-label="breadcrumb" role="navigation">
                <ol class="breadcrumb page-head-nav">
                    <li class="breadcrumb-item active">Offer List</li>
                </ol>
            </nav>
        </div>

        <div class="form-group row p-4">
            <form action="/offers" method="get" class="col-12 d-flex justify-content-between">
                <div class="col-12 col-sm-5 col-lg-4">
                    <div class="input-group input-search">
                        <input class="form-control" type="text" name="keyword" placeholder="Search" value="${keyword}">
                        <span class="input-group-btn"><button type="submit"><i class="icon mdi mdi-search text-grey"></i></button>
                        </span>
                    </div>
                </div>

                <div class="col-12 col-sm-5 col-lg-3 mb-2 mb-sm-0">
                    <select name="department" class="form-control" tabindex="-1" aria-hidden="true"
                            style="width: 100%; height: 100%">
                        <option value="">Select Department</option>
                        <c:forEach items="${departments}" var="dept">
                            <option value="${dept}" <c:if test="${department == dept}">selected</c:if>>${dept}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-12 col-sm-2 col-lg-3 mb-2 mb-sm-0">
                    <select name="status" class="form-control" tabindex="-1" aria-hidden="true"
                            style="width: 100%; height: 100%">
                        <option value="">Select Status</option>
                        <c:forEach items="${statuses}" var="stat">
                            <option value="${stat}" <c:if test="${status == stat}">selected</c:if>>${stat}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-12 col-sm-2 col-lg-2 d-flex justify-content-between align-items-center">
                    <a href="/offers" class="btn btn-secondary p-2 px-6 text-center" style="border-radius: 4px"
                       title="Clear search">
                        Clear
                    </a>

                    <!-- Example single danger button -->
                    <div class="btn-group">
                        <button data-toggle="dropdown"
                                style="border: none"
                                aria-haspopup="true" aria-expanded="false">
                            <a
                                    class="btn d-flex justify-content-center align-items-center bg-success text-white border-success"
                                    style="border-radius: 50%; border: 1px #000 solid;width: 40px; height: 40px"
                                    title="Add Offer">
                        <span class="mdi mdi-plus text-white font-weight-bold font-weight-bold"
                              style="font-size: 20px"></span>
                            </a>
                        </button>
                        <div class="dropdown-menu custom-dropdown">
                            <a class="dropdown-item" href="/offers/new">Add Offer</a>
                            <a class="dropdown-item" href="/offers/export">Export Offer</a>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <div class="col-sm-12">
            <div class="card card-table">
                <div class="card-body">
                    <div id="table2_wrapper" class="dataTables_wrapper dt-bootstrap4 no-footer">
                        <div class="row be-datatable-body">
                            <div class="col-sm-12">
                                <table class="table table-striped table-hover table-fw-widget dataTable no-footer"
                                       id="table2" role="grid" aria-describedby="table2_info">
                                    <thead>
                                    <tr role="row">
                                        <th class="text-center">Candidate Name</th>
                                        <th class="text-center">Email</th>
                                        <th class="text-center">Contract Type</th>
                                        <th class="text-center">Department</th>
                                        <th class="text-center">Level</th>
                                        <th class="text-center">Position</th>
                                        <th class="text-center">Status</th>
                                        <th class="text-center">Actions</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <c:forEach items="${offerPage.content}" var="offer">
                                        <tr class="gradeA odd" role="row">
                                            <td class="text-center">${offer.candidate.name}</td>
                                            <td class="text-center">${offer.candidate.email}</td>
                                            <td class="text-center">${offer.contractType}</td>
                                            <td class="text-center">${offer.department}</td>
                                            <td class="text-center">${offer.level}</td>
                                            <td class="text-center">${offer.position}</td>
                                            <td class="text-center">${offer.status}</td>
                                            <td class="text-center">
                                                <a href="/offers/detail/${offer.offerId}"
                                                   class="text-success" title="View Offer">

                                                    <span style="font-size: 22px" class="mr-1 mdi mdi-eye"
                                                          style="border-radius: 4px">
                                                    </span>
                                                </a>
                                                <a href="/offers/edit/${offer.offerId}" class="text-warning"
                                                   title="Edit Offer"
                                                   style="border-radius: 4px">
                                                    <span
                                                            style="font-size: 22px" class="mr-1 mdi mdi-edit">
                                                    </span>
                                                </a>
                                                <a class="text-danger" style="border-radius: 4px"
                                                   title="Delete Offer"
                                                   onclick="showDeleteModal('${offer.offerId}')">
                                                    <span
                                                            style="font-size: 22px" class="mr-1 mdi mdi-delete text-danger">
                                                    </span>
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="row be-datatable-footer">
                            <div class="col-sm-7">
                                <div class="dataTables_paginate paging_simple_numbers" id="table2_paginate">
                                    <nav aria-label="Page navigation example">
                                        <ul class="pagination">
                                            <li class="page-item ${currentPage <= 0 ? 'disabled' : ''}">
                                                <a class="page-link"
                                                   href="/offers?page=${currentPage - 1}&keyword=${keyword}&department=${department}&status=${status}"
                                                   aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                </a>
                                            </li>
                                            <c:forEach begin="0" end="${totalPages ==0 ? 0 :totalPages - 1}" var="i">
                                                <li class="page-item ${currentPage == i ? 'active' : ''}">
                                                    <a class="page-link"
                                                       href="/offers?page=${i}&keyword=${keyword}&department=${department}&status=${status}">${i + 1}</a>
                                                </li>
                                            </c:forEach>
                                            <li class="page-item ${currentPage >= totalPages - 1 ? 'disabled' : ''}">
                                                <a class="page-link"
                                                   href="/offers?page=${currentPage + 1}&keyword=${keyword}&department=${department}&status=${status}"
                                                   aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>
                        <div class="row be-datatable-footer">
                            <div class="col-sm-5">
                                <div class="dataTables_info" id="table2_info" role="status" aria-live="polite">
                                    Showing ${offerPage.number * offerPage.size + 1}
                                    to ${(offerPage.number + 1) * offerPage.size} of ${offerPage.totalElements} entries
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- Delete Confirmation Modal -->
<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="deleteModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="deleteModalLabel">Delete Confirmation</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                Are you sure you want to delete this offer?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-danger" id="confirmDeleteButton">Delete</button>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
<script>
    function showDeleteModal(offerId) {
        $('#confirmDeleteButton').attr('onclick', 'confirmDelete(' + offerId + ')');
        $('#deleteModal').modal('show');
    }

    function confirmDelete(offerId) {
        window.location.href = '/offers/delete/' + offerId;
    }
</script>
</body>
</html>
