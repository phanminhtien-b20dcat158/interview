<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Offer Details</title>
    <link rel="stylesheet" type="text/css" href="/lib/perfect-scrollbar/css/perfect-scrollbar.css">
    <link rel="stylesheet" type="text/css" href="/lib/material-design-icons/css/material-design-iconic-font.min.css">
    <link rel="stylesheet" type="text/css" href="/lib/datatables/datatables.net-bs4/css/dataTables.bootstrap4.css">
    <link rel="stylesheet" type="text/css"
          href="/lib/datatables/datatables.net-responsive-bs4/css/responsive.bootstrap4.min.css">
    <link rel="stylesheet" href="/css/app.css" type="text/css">
    <link rel="stylesheet" href="/css/offer/index.css" type="text/css">
    <style>
        p {
            font-size: 18px;
            font-weight: bold;
        }
    </style>
</head>
<body>
<jsp:include page="../layout/header.jsp"/>
<jsp:include page="../layout/left-sidebar.jsp"/>

<div class="be-content" style="margin-top: 60px;">
    <div class="main-content container-fluid">
        <div class="page-head mt-0 px-0" style="margin-top: 60px;">
            <h2 class="page-head-title">Offer Details</h2>
            <nav aria-label="breadcrumb mt-2" role="navigation">
                <ol class="breadcrumb page-head-nav">
                    <li class="breadcrumb-item"><a href="/offers">Offer List</a></li>
                    <li class="breadcrumb-item active">Offer Details</li>
                </ol>
            </nav>
        </div>

        <div class="">
            <div class="row">
                <div class="col-lg-12">
                    <c:choose>
                        <c:when test="${offer.status == 'WAITING_FOR_APPROVAL'}">
                            <sec:authorize access="hasAnyRole('HR_MANAGER', 'ADMIN')">
                                <a href="#"
                                   onclick="showNoteModal('${offer.offerId}', '${pageContext.request.contextPath}/offers/approve/${offer.offerId}')"
                                   class="btn btn-success">Approve</a>
                                <a href="#"
                                   onclick="showNoteModal('${offer.offerId}', '${pageContext.request.contextPath}/offers/reject/${offer.offerId}')"
                                   class="btn btn-danger">Reject</a>
                            </sec:authorize>
                            <sec:authorize access="hasAnyRole('RECRUITER', 'HR_MANAGER', 'ADMIN')">

                                <a onclick="showCancelModal('${offer.offerId}')"
                                   class="btn btn-warning text-white">Cancel Offer</a>
                            </sec:authorize>
                        </c:when>

                        <c:when test="${offer.status == 'APPROVED'}">
                            <sec:authorize access="hasAnyRole('RECRUITER', 'HR_MANAGER', 'ADMIN')">
                                <a href="${pageContext.request.contextPath}/offers/send/${offer.offerId}"
                                   class="btn btn-info">Mark as Sent to Candidate</a>
                                <a
                                        onclick="showCancelModal('${offer.offerId}')"
                                        class="btn btn-warning text-white">Cancel Offer</a>
                            </sec:authorize>
                        </c:when>


                        <c:when test="${offer.status == 'WAITING_FOR_RESPONSE'}">
                            <sec:authorize access="hasAnyRole('RECRUITER', 'HR_MANAGER', 'ADMIN')">
                                <a href="#"
                                   onclick="showNoteModal('${offer.offerId}', '${pageContext.request.contextPath}/offers/accept/${offer.offerId}')"
                                   class="btn btn-success">ACCEPTED</a>
                                <a href="#"
                                   onclick="showNoteModal('${offer.offerId}', '${pageContext.request.contextPath}/offers/decline/${offer.offerId}')"
                                   class="btn btn-info">DECLINED</a>
                                <a
                                        onclick="showCancelModal('${offer.offerId}')"
                                        class="btn btn-warning text-white">Cancel Offer</a>
                            </sec:authorize>
                        </c:when>

                        <c:when test="${offer.status == 'ACCEPTED'}">
                            <sec:authorize access="hasAnyRole('RECRUITER', 'HR_MANAGER', 'ADMIN')">
                                <a
                                        onclick="showCancelModal('${offer.offerId}')"
                                        class="btn btn-warning">Cancel Offer</a>
                            </sec:authorize>
                        </c:when>
                    </c:choose>

                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Candidate:</label>
                        <p>${offer.candidate.name}</p>
                    </div>
                    <div class="form-group">
                        <label>Position:</label>
                        <p>${offer.position}</p>
                    </div>
                    <div class="form-group">
                        <label>Approved by:</label>
                        <p>${offer.approver.fullName}</p>
                    </div>
                    <div class="form-group">
                        <label>Interview Schedule:</label>
                        <p>${offer.interview.title}</p>
                    </div>
                    <div class="form-group">
                        <label>Contract:</label>
                        <span style="display: block">

                        From
                        <p style="display: inline">${startDate}</p>
                        To
                        <p style="display: inline">${endDate}</p>
                        </span>
                    </div>
                    <div class="form-group">
                        <label>Due Date:</label>
                        <p>${dueDate}</p>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label>Contract Type:</label>
                        <p>${offer.contractType}</p>
                    </div>
                    <div class="form-group">
                        <label>Level:</label>
                        <p>${offer.level}</p>
                    </div>
                    <div class="form-group">
                        <label>Department:</label>
                        <p>${offer.department}</p>
                    </div>
                    <div class="form-group">
                        <label>Recruiter:</label>
                        <p>${offer.recruiter.fullNameWithAccountName}</p>
                    </div>
                    <div class="form-group">
                        <label>Basic Salary:</label>
                        <p>${offer.basicSalary}</p>
                    </div>
                    <div class="form-group">
                        <label>Status:</label>
                        <p>${offer.status}</p>
                    </div>
                    <div class="form-group">
                        <label>Note:</label>
                        <p>${offer.note}</p>
                    </div>
                </div>
            </div>

            <div class="row d-f justify-content-center">

                <c:choose>
                    <c:when test="${offer.status != 'WAITING_FOR_APPROVAL' && offer.status != 'WAITING_FOR_RESPONSE' && offer.status != 'REJECTED' }">
                        <button type="button" class="btn btn-info p-2 px-6 text-center" disabled="disabled">
                            Edit
                            </a>
                        </button>
                    </c:when>
                    <c:otherwise>
                        <a class="btn btn-info p-2 px-6 text-center"
                           href="${pageContext.request.contextPath}/offers/edit/${offer.offerId}"
                        >Edit
                        </a>
                    </c:otherwise>
                </c:choose>
                <span class="m-2"></span>
                <button type="button" class="btn btn-secondary p-2 px-6 text-center"
                        onclick="window.history.back();">Back
                </button>
            </div>
        </div>
    </div>


    <!-- Add Note Confirmation Modal -->
    <div class="modal fade" id="addNoteModal" tabindex="-1" role="dialog" aria-labelledby="addNoteModalLabel"
         aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="addNoteModalLabel">Add Notes</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="noteForm" action="" method="post">
                        <input type="hidden" name="offerId" id="offerId">
                        <div class="form-group">
                            <label for="note">Note:</label>
                            <textarea id="note" name="note" class="form-control" required></textarea>
                        </div>
                        <div class="form-group text-right">
                            <button type="submit" class="btn btn-success">Submit</button>
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Cancel</button>
                        </div>
                    </form>
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
                    <h5 class="modal-title" id="deleteModalLabel">Cancel Confirmation</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    Are you sure you want to cancel this offer?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">No
                    </button>
                    <button type="button" class="btn btn-danger" id="confirmCancelButton">Yes</button>
                </div>
            </div>
        </div>
    </div>

</div>

<script src="/lib/jquery/jquery.min.js" type="text/javascript"></script>
<script src="/lib/perfect-scrollbar/js/perfect-scrollbar.min.js" type="text/javascript"></script>
<script src="/lib/bootstrap/dist/js/bootstrap.bundle.min.js" type="text/javascript"></script>
<script src="/js/app.js" type="text/javascript"></script>
<script src="/lib/jquery.sparkline/jquery.sparkline.min.js" type="text/javascript"></script>
<script src="/lib/countup/countUp.min.js" type="text/javascript"></script>
<script src="/lib/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
<script src="/lib/jqvmap/jquery.vmap.min.js" type="text/javascript"></script>
<script src="/lib/jqvmap/maps/jquery.vmap.world.js" type="text/javascript"></script>
<script>

    function showNoteModal(offerId, actionUrl) {
        $('#offerId').val(offerId);
        $('#noteForm').attr('action', actionUrl);
        $('#addNoteModal').modal('show');
    }

    function showCancelModal(offerId) {

        $('#confirmCancelButton').attr('onclick', 'confirmDelete(' + offerId + ')');
        $('#deleteModal').modal('show');
    }

    function confirmDelete(offerId) {
        $('#deleteModal').modal('hide');
        let actionUrl = '/offers/cancel/' + offerId;

        showNoteModal(offerId, actionUrl)
    }
</script>
</body>
</html>
