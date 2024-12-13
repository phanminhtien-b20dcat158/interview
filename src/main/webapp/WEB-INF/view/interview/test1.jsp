<div class="be-wrapper">
    <%@include file="../layout/header.jsp"%>
    <%@include file="../layout/left-sidebar.jsp"%>

    <div class="be-content">
        <div class="page-head">
            <h2 class="page-head-title">Interview Schedule Details</h2>
        </div>
        <div class="main-content container-fluid">
            <div class="card">
                <div class="card-header">
                    <c:if test="${roleName == 'admin' || roleName == 'manager' || roleName == 'recruiter'}">
                        <div class="d-flex justify-content-end">
                            <a href="/interview/reminder?interviewId=${interview.interviewId}">
                                <button class="btn btn-space btn-secondary active">Send Reminder</button>
                            </a>
                        </div>
                    </c:if>
                </div>
                <div class="card-body">
                    <div class="row">
                        <!-- Left Column -->
                        <div class="col-md-6">
                            <div class="info-group">
                                <div class="info-row">
                                    <div class="info-label">Schedule Title:</div>
                                    <div class="info-content">${interview.title}</div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Candidate:</div>
                                    <div class="info-content">${interview.candidate.name}</div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Schedule Time:</div>
                                    <div class="info-content">
                                        ${interview.date}<br>
                                        From: ${interview.startTime} To: ${interview.endTime}
                                    </div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Notes:</div>
                                    <div class="info-content">${interview.note}</div>
                                </div>
                            </div>
                        </div>
                        <!-- Right Column -->
                        <div class="col-md-6">
                            <div class="info-group">
                                <div class="info-row">
                                    <div class="info-label">Job:</div>
                                    <div class="info-content">${interview.job.title}</div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Interviewer:</div>
                                    <div class="info-content">
                                        <c:forEach var="scheduleInterview" items="${interview.scheduledInterviews}">
                                            <div class="interviewer-item">
                                                    ${scheduleInterview.interviewer.fullName} | ${scheduleInterview.interviewer.department}
                                            </div>
                                        </c:forEach>
                                    </div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Location:</div>
                                    <div class="info-content">${interview.location}</div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Recruiter Owner:</div>
                                    <div class="info-content">${interview.recruiter.fullName} | ${interview.recruiter.department}</div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Meeting ID:</div>
                                    <div class="info-content">${interview.meetingId}</div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Result:</div>
                                    <div class="info-content">${interview.result.name().toString()}</div>
                                </div>
                                <div class="info-row">
                                    <div class="info-label">Status:</div>
                                    <div class="info-content">${interview.status.name().toString()}</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-12 text-center">
                            <a href="/interview/list">
                                <button class="btn btn-space btn-secondary btn-width active">Close</button>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
