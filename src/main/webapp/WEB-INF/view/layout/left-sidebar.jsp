<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="be-left-sidebar">
    <div class="left-sidebar-wrapper"><a class="left-sidebar-toggle" href="#">Dashboard</a>
        <div class="left-sidebar-spacer">
            <div class="left-sidebar-scroll ps ps--active-y">
                <div class="left-sidebar-content">
                    <ul class="sidebar-elements">
                        <li class="divider">Menu</li>

                        <li class="mb-4"><a href="/candidate">
                            <img src="/img/candidate.svg" style="width: 30px; height: 30px; padding-right: 8px;"/>
                            <span>Candidate</span></a></li>


                        <li class="mb-4"><a href="/job">
                            <img src="/img/job.svg" style="width: 30px; height: 30px; padding-right: 8px;"/>
                            <span>Job</span></a></li>

                        <li class="mb-4"><a href="/interview/list">
                            <img src="/img/interview.svg" style="width: 30px; height: 30px; padding-right: 8px;"/>
                            <span>Inerview</span></a></li>

                        <li class="mb-4"><a href="/offers">
                            <img src="/img/offer.svg" style="width: 30px; height: 30px; padding-right: 8px;"/>
                            <span>Offer</span></a></li>
                        <li class="mb-4"><a href="/user">
                            <img src="/img/account.svg" style="width: 30px; height: 30px; padding-right: 8px;"/>
                            <span>User</span></a></li>
                    </ul>
                </div>

            </div>
        </div>

    </div>
</div>