<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- header -->
<nav class="navbar navbar-expand fixed-top be-top-header">
    <div class="container-fluid">

        <div class="page-title"><a href="/user">Interview Managerment</a></div>
        <div class="be-right-navbar">
            <ul class="nav navbar-nav float-right be-user-nav">
                <c:if test="${not empty pageContext.request.userPrincipal}">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" data-toggle="dropdown" role="button"
                       aria-expanded="false">
                        <img src="\img\avatar.png" alt="Avatar">
                        <span class="user-name">Túpac Amaru</span>
                    </a>
                    <div class="dropdown-menu" role="menu">
                        <div class="user-info">
                            <div class="user-name d-flex justify-content-center">
                                <c:out value="${pageContext.request.userPrincipal.name}"/>
                            </div>
                        </div>
                        <form class="dropdown-item " method="post" action="/logout">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <button class="btn btn-secondary" href="/logout">
                                <span class="icon mdi mdi-power"></span>
                                Logout</button>
                        </form>
                    </div>

                </li>
                </c:if>

                <c:if test="${empty pageContext.request.userPrincipal}">
                    <!-- If the user is not logged in -->
                    <a class="nav-link btn btn-success" href="/login">
                        <span class="icon mdi mdi-login"></span>
                        Login
                    </a>
                </c:if>

            </ul>
        </div>
    </div>
</nav>