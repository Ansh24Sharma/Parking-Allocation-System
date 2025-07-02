<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Slot Details - Parking Allocation System</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="icon" href="static/images/logo.jpg" type="image/jpg">
    <style>
        :root {
            --primary-color: #3b82f6;
            --secondary-color: #1d4ed8;
            --background-light: rgba(249, 250, 251, 0.8);
            --surface-light: rgba(255, 255, 255, 0.9);
            --text-primary: #1f2937;
            --text-secondary: #6b7280;
            --accent-color: #10b981;
            --warning-color: #f59e0b;
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
            grid-template-columns: 250px 1fr;
            min-height: 100vh;
        }

        .sidebar {
            background-color: var(--surface-light);
            border-right: 1px solid var(--border-color);
            padding: 2rem 1rem;
            display: flex;
            flex-direction: column;
        }

        .sidebar-header {
            display: flex;
            align-items: center;
            margin-bottom: 2rem;
            gap: 1rem;
        }

        .sidebar-header img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
        }

        .sidebar-menu {
            list-style: none;
        }

        .sidebar-menu li {
            margin-bottom: 0.5rem;
        }

        .sidebar-menu a {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 0.75rem 1rem;
            text-decoration: none;
            color: var(--text-secondary);
            border-radius: var(--border-radius);
            transition: all 0.3s ease;
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
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            color: var(--text-primary);
            position: relative;
        }

        .main-content::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(255, 255, 255, 0.8);
            border-radius: var(--border-radius);
            z-index: 1;
        }

        .main-content > * {
            position: relative;
            z-index: 2;
        }

        .slot-details-container {
            background-color: var(--surface-light);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 2rem;
            max-width: 600px;
            margin: 0 auto;
            animation: fadeIn 0.5s ease-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: scale(0.95);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 0.75rem;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
        }

        th {
            background: var(--surface-light);
            color: var(--text-primary);
            font-weight: 500;
        }

        .action-buttons {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 1.5rem;
        }

        .return-home-btn, .release-button, .pay-slot-btn {
            display: inline-flex;
            align-items: center;
            background-color: var(--primary-color);
            color: white;
            padding: 0.875rem;
            border-radius: var(--border-radius);
            text-decoration: none;
            transition: background-color 0.3s ease, transform 0.3s ease;
            font-weight: 600;
        }

        .return-home-btn:hover, .release-button:hover, .pay-slot-btn:hover {
            background-color: var(--secondary-color);
            transform: translateY(-2px);
        }

        .return-home-btn i, .release-button i, .pay-slot-btn i {
            margin-right: 0.5rem;
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

        @media (max-width: 768px) {
            .dashboard-container {
                grid-template-columns: 1fr;
            }

            .sidebar {
                display: none;
            }

            .action-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <!-- Sidebar -->
        <aside class="sidebar">
            <div class="sidebar-header">
                <img src="${pageContext.request.contextPath}/static/images/logo.jpg" alt="User Avatar">
                <div>
                    <h3>${user.name}</h3>
                </div>
            </div>
            <ul class="sidebar-menu">
                <li><a href="<s:url value='/user/dashboard'/>"><i class="fas fa-home"></i> Dashboard</a></li>
                <li><a href="<s:url value='/user/vehicle/register'/>"><i class="fas fa-car"></i> Register Vehicle</a></li>
                <li><a href="<s:url value='/user/vehicle/details'/>"><i class="fas fa-info-circle"></i> Vehicle Details</a></li>
                <li><a href="<s:url value='/user/parking/bookings'/>"><i class="fas fa-parking"></i> My Bookings</a></li>
                <li><a href="<s:url value='/logout'/>"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <h1>Slot Details</h1>
            <p>Detailed information about your parking slot allocation.</p>

            <div class="slot-details-container">
                <h2 class="text-center mb-4"><i class="fas fa-info-circle"></i> Slot Information</h2>
                <table>
                    <tr>
                        <th><i class="fas fa-hashtag"></i> Slot Number</th>
                        <td>${slot.slotNumber}</td>
                    </tr>
                    <tr>
                        <th><i class="fas fa-car"></i> Vehicle Type</th>
                        <td>
                            <c:choose>
                                <c:when test="${slot.vehicleType == 1}">Two Wheeler</c:when>
                                <c:when test="${slot.vehicleType == 2}">Four Wheeler</c:when>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th><i class="fas fa-clock"></i> Duration</th>
                        <td>${slot.duration}</td>
                    </tr>
                    <tr>
                        <th><i class="fas fa-calendar-alt"></i> Allocation Type</th>
                        <td>
                            <c:choose>
                                <c:when test="${slot.allocationType == 1}">Hourly</c:when>
                                <c:when test="${slot.allocationType == 2}">Daily</c:when>
                            </c:choose>
                        </td>
                    </tr>
                    <tr>
                        <th><i class="fas fa-dollar-sign"></i> Total Price</th>
                        <td>₹${slot.totalPrice}</td>
                    </tr>
                    <tr>
                        <th><i class="fas fa-calendar-check"></i> Start Time</th>
                        <td>${formattedStartTime}</td>
                    </tr>
                    <tr>
                        <th><i class="fas fa-calendar-times"></i> End Time</th>
                        <td>${formattedEndTime}</td>
                    </tr>
                    <tr>
                        <th><i class="fas fa-map-marker-alt"></i> Location</th>
                        <td>${slot.location}</td>
                    </tr>
                    <tr>
                        <th><i class="fas fa-flag"></i> Slot Status</th>
                        <td>
                            <c:choose>
                                <c:when test="${slot.slotStatus == 1}">Available</c:when>
                                <c:when test="${slot.slotStatus == 2}">Reserved</c:when>
                                <c:when test="${slot.slotStatus == 3}">Pending Payment</c:when>
                            </c:choose>
                        </td>
                    </tr>
                </table>

                <div class="action-buttons">
                    <c:choose>
                        <c:when test="${slot.slotStatus == 3}">
                            <form action="<s:url value='/create-order' />" method="get">
                                <input type="hidden" name="slotId" value="${slot.slotId}" />
                                <input type="hidden" name="amount" value="${slot.totalPrice}" />
                                <button type="submit" class="pay-slot-btn">
                                    <i class="fas fa-credit-card"></i> Pay for Slot
                                </button>
                            </form>
                        </c:when>
                        <c:otherwise>
                            <a href="<s:url value='/user/vehicle/deleteSlot?slotId=${slot.slotId}' />" class="release-button">
                                <i class="fas fa-trash"></i> Release Slot
                            </a>
                            <a href="<s:url value='/user/dashboard' />" class="return-home-btn">
                                <i class="fas fa-home"></i> Return to Dashboard
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </main>
    </div>

    <footer class="footer">
        <p>&copy; 2024-2025 <a href="http://yash.com" target="_blank">YASH TECHNOLOGIES PVT LTD</a> | All Rights Reserved</p>
    </footer>
</body>
</html>