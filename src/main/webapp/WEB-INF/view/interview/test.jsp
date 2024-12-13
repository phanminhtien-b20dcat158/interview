<c:if test = "${roleName == 'admin' || roleName == 'manager' || roleName == 'recruiter'}">

</c:if>

<c:if test = "${roleName == 'interviewer'}">

</c:if>

<c:if test="${!empty jobneed}">

</c:if>

<c:if test="${empty jobneed}">

</c:if>