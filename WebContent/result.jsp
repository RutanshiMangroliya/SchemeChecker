<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eligibility Results - GovScheme Checker</title>
    <meta name="description" content="View government schemes you are eligible for based on your profile.">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <style>
        /* ── Result page enhancements ── */
        body { background: #f0f4f8; }

        .scheme-card {
            border-radius: 16px;
            border: none;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            transition: transform 0.22s ease, box-shadow 0.22s ease;
            position: relative;
            overflow: hidden;
            background: #ffffff;
        }
        .scheme-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 32px rgba(0,0,0,0.14);
        }
        .scheme-card::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0;
            height: 4px;
            background: linear-gradient(90deg, #28a745, #20c997);
            border-radius: 16px 16px 0 0;
        }

        /* ── Eligible badge (top-right) ── */
        .badge-eligible {
            position: absolute;
            top: 14px;
            right: 14px;
            background: linear-gradient(135deg, #28a745, #20c997);
            color: #fff;
            font-size: 0.72rem;
            font-weight: 600;
            padding: 4px 10px;
            border-radius: 20px;
            letter-spacing: 0.3px;
            box-shadow: 0 2px 8px rgba(40,167,69,0.35);
        }

        /* ── Eligibility tags ── */
        .elig-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 6px;
            margin: 10px 0 14px;
        }
        .elig-tag {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            background: #f1f5f9;
            border: 1px solid #e2e8f0;
            border-radius: 20px;
            padding: 3px 10px;
            font-size: 0.76rem;
            color: #475569;
            font-weight: 500;
            white-space: nowrap;
        }

        /* ── Apply Now button ── */
        .btn-apply {
            display: block;
            width: 100%;
            margin-top: 12px;
            padding: 10px;
            font-size: 0.9rem;
            font-weight: 600;
            border-radius: 10px;
            background: linear-gradient(135deg, #28a745, #20c997);
            border: none;
            color: #fff;
            text-decoration: none;
            text-align: center;
            letter-spacing: 0.3px;
            transition: opacity 0.2s, transform 0.2s;
        }
        .btn-apply:hover {
            opacity: 0.88;
            color: #fff;
            transform: translateY(-1px);
        }
        .btn-apply.disabled-link {
            background: #ced4da;
            cursor: not-allowed;
            pointer-events: none;
            color: #6c757d;
        }

        /* ── Success alert ── */
        .alert-result {
            background: linear-gradient(135deg, #d4edda, #c3e6cb);
            border: none;
            border-left: 5px solid #28a745;
            border-radius: 12px;
            box-shadow: 0 2px 12px rgba(40,167,69,0.12);
            padding: 18px 22px;
        }
        .alert-result .alert-title {
            font-size: 1.15rem;
            font-weight: 700;
            color: #155724;
        }
        .alert-result .alert-sub {
            font-size: 0.87rem;
            color: #276239;
            margin-top: 4px;
        }

        .scheme-name {
            font-size: 1.05rem;
            font-weight: 700;
            color: #1e293b;
            padding-right: 90px; /* space for badge */
            line-height: 1.3;
        }
        .scheme-desc {
            font-size: 0.84rem;
            color: #64748b;
            margin-bottom: 4px;
            line-height: 1.5;
        }

        /* ── Profile card ── */
        .profile-card {
            background: #fff;
            border-radius: 14px;
            border: none;
            box-shadow: 0 2px 12px rgba(0,0,0,0.07);
        }
    </style>
</head>
<body>
    <!-- ── Navbar ── -->
    <nav class="navbar navbar-expand-lg navbar-dark custom-navbar">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">🏛️ GovScheme Checker</a>
        </div>
    </nav>

    <div class="container my-5">

        <!-- ── Profile Summary ── -->
        <div class="row mb-4">
            <div class="col-12">
                <div class="profile-card card">
                    <div class="card-body d-flex justify-content-between align-items-center flex-wrap gap-3">
                        <div>
                            <h5 class="mb-1 fw-bold">👤 Profile Summary: ${user.name}</h5>
                            <span class="text-muted" style="font-size:0.88rem;">
                                Age: <strong>${user.age}</strong> &nbsp;|&nbsp;
                                Category: <strong>${user.category}</strong> &nbsp;|&nbsp;
                                Gender: <strong>${user.gender}</strong> &nbsp;|&nbsp;
                                Income: <strong>₹<fmt:formatNumber value="${user.income}" type="number" groupingUsed="true" xmlns:fmt="http://java.sun.com/jsp/jstl/fmt"/></strong>
                            </span>
                        </div>
                        <div class="d-flex gap-2 flex-wrap">
                            <a href="form.jsp" class="btn btn-outline-secondary btn-sm">🔄 Check Again</a>
                            <a href="report" class="btn btn-outline-primary btn-sm">📊 View Report</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- ── Results ── -->
        <c:choose>
            <c:when test="${not empty eligibleSchemes}">

                <!-- Success Alert -->
                <div class="alert-result mb-4">
                    <div class="alert-title">
                        🎉 Great news, ${user.name}!
                        You qualify for <c:out value="${fn:length(eligibleSchemes)}"/> government scheme<c:if test="${fn:length(eligibleSchemes) != 1}">s</c:if>.
                    </div>
                    <div class="alert-sub">
                        Click <strong>'Apply Now'</strong> on any scheme card below to visit the official government portal and begin your application.
                    </div>
                </div>

                <!-- Scheme Cards Grid -->
                <div class="row g-4">
                    <c:forEach var="scheme" items="${eligibleSchemes}">
                        <div class="col-md-6 col-lg-4">
                            <div class="scheme-card card h-100">
                                <div class="card-body d-flex flex-column" style="padding: 20px;">

                                    <!-- Eligible badge (top-right) -->
                                    <span class="badge-eligible">✓ Eligible</span>

                                    <!-- Scheme Name -->
                                    <div class="scheme-name mb-1">${scheme.name}</div>

                                    <!-- Description -->
                                    <p class="scheme-desc">${scheme.description}</p>

                                    <!-- Eligibility Tags -->
                                    <div class="elig-tags">
                                        <span class="elig-tag">🟢 Age: ${scheme.minAge}–${scheme.maxAge} yrs</span>
                                        <span class="elig-tag">💰 Income: up to ₹${scheme.maxIncome}</span>
                                        <span class="elig-tag">👤 Category: ${scheme.categoryRequired}</span>
                                        <span class="elig-tag">⚧ Gender: ${scheme.genderRequired}</span>
                                    </div>

                                    <!-- Spacer pushes button to bottom -->
                                    <div class="mt-auto"></div>

                                    <!-- Apply Now Button -->
                                    <c:choose>
                                        <c:when test="${not empty scheme.applyLink}">
                                            <a href="${scheme.applyLink}"
                                               target="_blank"
                                               rel="noopener noreferrer"
                                               class="btn-apply"
                                               id="apply-btn-${scheme.schemeId}">
                                                🔗 Apply Now →
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="btn-apply disabled-link"
                                                  id="apply-btn-${scheme.schemeId}">
                                                🚫 Link Not Available
                                            </span>
                                        </c:otherwise>
                                    </c:choose>

                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

            </c:when>
            <c:otherwise>
                <div class="alert alert-warning shadow-sm" role="alert">
                    <strong>😔 No Matches Found:</strong> No schemes match your profile at this time.
                    <br>Try adjusting your details or check back later for new government updates.
                    <div class="mt-3">
                        <a href="form.jsp" class="btn btn-warning btn-sm">🔄 Try Again</a>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>

    </div><!-- /container -->

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
