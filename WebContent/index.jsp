<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>GovScheme Checker</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark custom-navbar">
        <div class="container">
            <a class="navbar-brand font-weight-bold" href="index.jsp">🏛️ GovScheme Checker</a>
            <div class="ms-auto">
                <a href="report" class="btn btn-outline-light btn-sm">View Reports</a>
            </div>
        </div>
    </nav>

    <div class="hero-section">
        <div class="container">
            <h1 class="display-4 fw-bold">Find Government Schemes You Qualify For</h1>
            <p class="lead mb-4">A comprehensive, fast, and accurate portal to discover Indian government welfare schemes matching your profile.</p>
            <a href="form.jsp" class="btn btn-primary btn-lg px-4 me-2">Check Eligibility</a>
            <a href="report" class="btn btn-outline-light btn-lg px-4">View Analytics</a>
        </div>
    </div>

    <div class="container my-5">
        <div class="row text-center">
            <div class="col-md-4 mb-4">
                <div class="card feature-card h-100 p-4">
                    <h3>⚡ Fast</h3>
                    <p class="text-muted">Get results instantly by answering a few simple questions.</p>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card feature-card h-100 p-4">
                    <h3>🎯 Accurate</h3>
                    <p class="text-muted">Robust filtering based on official age, gender, category, and income criteria.</p>
                </div>
            </div>
            <div class="col-md-4 mb-4">
                <div class="card feature-card h-100 p-4">
                    <h3>📚 Comprehensive</h3>
                    <p class="text-muted">A unified database covering housing, agriculture, health, and scholarships.</p>
                </div>
            </div>
        </div>
    </div>

    <footer class="bg-dark text-white text-center py-3 mt-auto">
        <div class="container">
            <p class="mb-0">&copy; 2024 GovScheme Checker. All Rights Reserved.</p>
        </div>
    </footer>
</body>
</html>
