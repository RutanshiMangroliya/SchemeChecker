<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Scheme Analytics Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body class="bg-light">
    <nav class="navbar navbar-expand-lg navbar-dark custom-navbar">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">🏛️ GovScheme Checker</a>
            <div class="ms-auto">
                <a href="index.jsp" class="btn btn-outline-light btn-sm">Back to Home</a>
            </div>
        </div>
    </nav>

    <div class="container my-5">
        <h2 class="mb-4 fw-bold">Scheme Analytics Dashboard</h2>
        
        <div class="row">
            <div class="col-lg-6 mb-4">
                <div class="card shadow-sm h-100 border-0">
                    <div class="card-header bg-white fw-bold">Most Recommended Schemes</div>
                    <div class="card-body">
                        <table class="table table-striped table-hover mb-0">
                            <thead class="table-dark">
                                <tr>
                                    <th>Scheme Name</th>
                                    <th>Recommendations Count</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${mostRecommended}">
                                    <tr>
                                        <td>${item.name}</td>
                                        <td><span class="badge bg-primary rounded-pill">${item.count}</span></td>
                                    </tr>
                                </c:forEach>
                                <c:if test="${empty mostRecommended}">
                                    <tr><td colspan="2" class="text-center">No data available yet</td></tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="col-lg-6 mb-4">
                <div class="row h-100">
                    <div class="col-12 mb-4">
                        <div class="card shadow-sm border-0">
                            <div class="card-header bg-white fw-bold">Users by Category</div>
                            <div class="card-body">
                                <table class="table table-striped table-hover mb-0">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>Category</th>
                                            <th>User Count</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="item" items="${categoryDistribution}">
                                            <tr>
                                                <td>${item.category}</td>
                                                <td>${item.count}</td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty categoryDistribution}">
                                            <tr><td colspan="2" class="text-center">No data available yet</td></tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <div class="col-12">
                        <div class="card shadow-sm border-0">
                            <div class="card-header bg-white fw-bold">Users by Income Group</div>
                            <div class="card-body">
                                <table class="table table-striped table-hover mb-0">
                                    <thead class="table-dark">
                                        <tr>
                                            <th>Group (Low/Medium/High)</th>
                                            <th>User Count</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="item" items="${incomeStats}">
                                            <tr>
                                                <td>${item.group}</td>
                                                <td>${item.count}</td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty incomeStats}">
                                            <tr><td colspan="2" class="text-center">No data available yet</td></tr>
                                        </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
