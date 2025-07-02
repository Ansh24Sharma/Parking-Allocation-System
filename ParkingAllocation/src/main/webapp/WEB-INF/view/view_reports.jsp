<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Reports - Parking Allocation System</title>
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

        .table-container {
            background: var(--surface-light);
            padding: 2.5rem;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            margin-top: 2rem;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
        }

        th {
            background: var(--primary-color);
            color: white;
            font-weight: 600;
        }

        tr:nth-child(even) {
            background-color: rgba(37, 99, 235, 0.1);
        }

        tr:hover {
            background-color: rgba(37, 99, 235, 0.2);
        }

          .footer {
                       background: var(--surface-light);
                       padding: 1rem;
                       text-align: center;
                       border-top: 1px solid var(--border-color);
                       color: var(--text-secondary);
                   }

                   .footer a {
                       color: var(--primary-color);
                       text-decoration: none;
                   }

                   .footer a:hover {
                       text-decoration: underline;
                   }

        .dataTables_wrapper {
            margin-top: 1.5rem;
        }

        .dataTables_filter input {
            padding: 0.5rem;
            border: 1px solid var(--border-color);
            border-radius: var(--border-radius);
            margin-left: 0.5rem;
        }

        .dataTables_length select {
            padding: 0.5rem;
            border: 1px solid var(--border-color);
            border-radius: var(--border-radius);
            margin: 0 0.5rem;
        }

        .dataTables_paginate {
            margin-top: 1rem;
            display: flex;
            justify-content: flex-end;
            gap: 0.5rem;
        }

        .dataTables_paginate .paginate_button {
            padding: 0.5rem 1rem;
            border: none;
            background: var(--primary-color);
            color: white;
            border-radius: var(--border-radius);
            cursor: pointer;
        }

        .dataTables_paginate .paginate_button:hover {
            background: var(--secondary-color);
        }

        @media (max-width: 1024px) {
            .dashboard-container {
                grid-template-columns: 1fr;
            }

            .sidebar {
                display: none;
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
                <li><a href="<s:url value='/admin/dashboard'/>"><i class="fas fa-home"></i> Dashboard</a></li>
                <li><a href="<s:url value='/admin/users'/>"><i class="fas fa-users"></i> User Management</a></li>
                <li><a href="<s:url value='/admin/bookings'/>"><i class="fas fa-calendar-check"></i> Booking Overview</a></li>
                <li><a href="#" class="active"><i class="fas fa-chart-bar"></i> Reports & Analytics</a></li>
                <li><a href="<s:url value='/logout'/>"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <div class="content-wrapper">
                <h1>View Reports</h1>
                <p class="mb-4">Complete overview of vehicle and slot allocation reports.</p>

                <div class="table-container">
                    <h3><i class="fas fa-file-alt"></i> Vehicle and Slot Reports</h3>
                    <table>
                        <thead>
                            <tr>
                                <th>User Name</th>
                                <th>Email</th>
                                <th>Vehicle Number</th>
                                <th>Chassis Number</th>
                                <th>Vehicle Type</th>
                                <th>Slot Number</th>
                                <th>Allocation Type</th>
                                <th>Start Time</th>
                                <th>End Time</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" items="${users}">
                                <c:forEach var="vehicle" items="${user.vehicles}">
                                    <c:forEach var="parking" items="${vehicle.parkings}">
                                        <tr>
                                            <td>${user.name}</td>
                                            <td>${user.email}</td>
                                            <td>${vehicle.vehicleNumber}</td>
                                            <td>${vehicle.chassisNumber}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${vehicle.vehicleType == 1}">Two Wheeler</c:when>
                                                    <c:when test="${vehicle.vehicleType == 2}">Four Wheeler</c:when>
                                                </c:choose>
                                            </td>
                                            <td>${parking.slotNumber}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${parking.allocationType == 1}">Hourly</c:when>
                                                    <c:when test="${parking.allocationType == 2}">Daily</c:when>
                                                </c:choose>
                                            </td>
                                            <td>${parking.formattedStartTime}</td>
                                            <td>${parking.formattedEndTime}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${parking.slotStatus == 1}">Available</c:when>
                                                    <c:when test="${parking.slotStatus == 2}">Reserved</c:when>
                                                    <c:when test="${parking.slotStatus == 3}">Not Available</c:when>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:forEach>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>

    <footer class="footer">
        <p>&copy; 2024-2025 <a href="http://yash.com" target="_blank">YASH TECHNOLOGIES PVT LTD</a> | All Rights Reserved</p>
    </footer>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.js"></script>
    <script>
        $(document).ready(function() {
            $('table').DataTable({
                "paging": true,
                "ordering": true,
                "info": true
            });
        });
    </script>
</body>
</html>