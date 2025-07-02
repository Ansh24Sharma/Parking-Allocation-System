<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detailed Reports - Parking Allocation System</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="icon" href="static/images/logo.jpg" type="image/jpg">
    <style>
        :root {
            --primary-color: #2563eb;
            --secondary-color: #1d4ed8;
            --background-light: rgba(249, 250, 251, 0.8);
            --surface-light: rgba(255, 255, 255, 0.9);
            --text-primary: #1f2937;
            --text-secondary: #6b7280;
            --accent-color: #10b981;
            --warning-color: #f59e0b;
            --danger-color: #ef4444;
            --border-color: #e5e7eb;
            --border-radius: 12px;
            --box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', 'Segoe UI', system-ui, sans-serif;
        }

        body {
            background-color: var(--background-light);
            color: var(--text-primary);
            line-height: 1.6;
        }

        .dashboard-container {
            display: grid;
            grid-template-columns: 280px 1fr;
            min-height: 100vh;
        }

        .sidebar {
            background-color: var(--surface-light);
            border-right: 1px solid var(--border-color);
            padding: 2rem 1.5rem;
            display: flex;
            flex-direction: column;
        }

        .sidebar-header {
            display: flex;
            align-items: center;
            margin-bottom: 2.5rem;
            gap: 1rem;
        }

        .sidebar-header img {
            width: 60px;
            height: 60px;
            border-radius: 50%;
        }

        .admin-info {
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid var(--border-color);
        }

        .admin-info h3 {
            color: var(--text-primary);
            font-weight: 600;
        }

        .admin-info p {
            color: var(--text-secondary);
            font-size: 0.9rem;
        }

        .sidebar-menu {
            list-style: none;
        }

        .sidebar-menu li {
            margin-bottom: 0.75rem;
        }

        .sidebar-menu a {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem;
            text-decoration: none;
            color: var(--text-secondary);
            border-radius: var(--border-radius);
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .sidebar-menu a:hover, .sidebar-menu a.active {
            background-color: var(--primary-color);
            color: white;
        }

        .main-content {
            padding: 2rem;
            background-image: url('${pageContext.request.contextPath}/static/images/bg.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            position: relative;
        }

        .main-content::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(255, 255, 255, 0.9);
            z-index: 1;
        }

        .content-wrapper {
            position: relative;
            z-index: 2;
        }

        .section-card {
            background-color: var(--surface-light);
            border-radius: var(--border-radius);
            padding: 1.5rem;
            box-shadow: var(--box-shadow);
            margin-top: 2rem;
        }

        .reports-table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1.5rem;
        }

        .reports-table th,
        .reports-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
        }

        .reports-table th {
            background-color: rgba(37, 99, 235, 0.1);
            color: var(--primary-color);
            font-weight: 600;
        }

        .reports-table tr:hover {
            background-color: rgba(37, 99, 235, 0.05);
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.75rem 1.5rem;
            background-color: var(--primary-color);
            color: white;
            text-decoration: none;
            border-radius: var(--border-radius);
            transition: background-color 0.3s ease;
            font-weight: 500;
            margin-top: 1.5rem;
        }

        .btn:hover {
            background-color: var(--secondary-color);
        }

        .btn i {
            font-size: 1.1rem;
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            color: var(--text-secondary);
        }

        .footer {
            background: var(--surface-light);
            padding: 1rem;
            text-align: center;
            border-top: 1px solid var(--border-color);
            color: var(--text-secondary);
            margin-top: 2rem;
        }

        .footer a {
            color: var(--primary-color);
            text-decoration: none;
        }

        .footer a:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .dashboard-container {
                grid-template-columns: 1fr;
            }

            .sidebar {
                display: none;
            }

            .reports-table {
                display: block;
                overflow-x: auto;
            }
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="sidebar-header">
                <img src="${pageContext.request.contextPath}/static/images/logo.jpg" alt="Admin Logo">
                <div class="admin-info">
                    <h3>Admin Panel</h3>
                    <p>${user.email}</p>
                </div>
            </div>
            <ul class="sidebar-menu">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-home"></i> Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/users"><i class="fas fa-users"></i> User Management</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/bookings" class="active"><i class="fas fa-calendar-check"></i> Booking Overview</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/viewReports"><i class="fas fa-chart-bar"></i> Reports & Analytics</a></li>
                <li><a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <div class="content-wrapper">
                <h1>Detailed Reports</h1>
                <p>View and analyze parking allocation reports</p>

                <section class="section-card">
                    <c:if test="${not empty reports}">
                        <table class="reports-table">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th>Vehicle Type</th>
                                    <th>Slot Type</th>
                                    <th>Slot Number</th>
                                    <th>Amount</th>
                                    <th>Created At</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="report" items="${reports}">
                                    <tr>
                                        <td>${report.name}</td>
                                        <td>${report.vehicleTypeString}</td>
                                        <td>${report.allocationTypeString}</td>
                                        <td>${report.slotNumber}</td>
                                        <td>₹ ${report.amount}</td>
                                        <td>${report.createdAt}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                    <c:if test="${empty reports}">
                        <div class="empty-state">
                            <i class="fas fa-file-alt fa-3x"></i>
                            <p>No reports found.</p>
                        </div>
                    </c:if>
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn">
                        <i class="fas fa-arrow-left"></i> Back to Dashboard
                    </a>
                </section>
            </div>
        </main>
    </div>

    <footer class="footer">
        <p>&copy; 2024-2025 <a href="http://yash.com" target="_blank">YASH TECHNOLOGIES PVT LTD</a> | All Rights Reserved</p>
    </footer>
</body>
</html>