<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Reports - Parking Allocation System</title>
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
                    width: 60px;
                    height: 60px;
                    border-radius: 50%;
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

        .table-container {
            background-color: var(--surface-light);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 1.5rem;
            margin-bottom: 1.5rem;
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
            background-color: var(--primary-color);
            color: white;
            font-weight: 600;
        }

        tr:hover {
            background-color: rgba(59, 130, 246, 0.05);
        }

        .btn {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            background-color: var(--primary-color);
            color: white;
            text-decoration: none;
            border-radius: var(--border-radius);
            transition: background-color 0.3s ease;
            text-align: center;
            margin-top: 1rem;
        }

        .btn:hover {
            background-color: var(--secondary-color);
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
                    <p>${admin.email}</p>
                </div>
            </div>
            <ul class="sidebar-menu">
                <li><a href="<s:url value='/user/dashboard'/>"><i class="fas fa-home"></i> Dashboard</a></li>
                <li><a href="<s:url value='/user/vehicle/register'/>"><i class="fas fa-car"></i> Register Vehicle</a></li>
                <li><a href="<s:url value='/user/vehicle/details'/>"><i class="fas fa-info-circle"></i> Vehicle Details</a></li>
                <li><a href="<s:url value='/user/parking/bookings'/>" class="active"><i class="fas fa-parking"></i> My Bookings</a></li>
                <li><a href="<s:url value='/logout'/>"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <h1>Booking Reports</h1>
            <p>Review your parking bookings and vehicle details.</p>

            <c:if test="${not empty vehicles}">
                <c:forEach var="vehicle" items="${vehicles}">
                    <div class="table-container">
                        <h2>Vehicle: ${vehicle.vehicleNumber}</h2>

                        <c:if test="${not empty vehicle.parkings}">
                            <table>
                                <tr>
                                    <th>Vehicle Type</th>
                                    <th>Slot Type</th>
                                    <th>Price</th>
                                    <th>Duration</th>
                                    <th>Start Time</th>
                                    <th>End Time</th>
                                    <th>Payment Amount</th>
                                </tr>
                                <c:forEach var="parking" items="${vehicle.parkings}">
                                    <tr>
                                        <td>${vehicle.vehicleTypeString}</td>
                                        <td>${parking.allocationTypeString}</td>
                                        <td>${parking.totalPrice}</td>
                                        <td>${parking.durationString}</td>
                                        <td>${parking.formattedStartTime}</td>
                                        <td>${parking.formattedEndTime}</td>
                                        <td>${parking.payment.amount}</td>
                                    </tr>
                                </c:forEach>
                            </table>
                        </c:if>
                        <c:if test="${empty vehicle.parkings}">
                            <p>No parking records found for this vehicle.</p>
                        </c:if>
                    </div>
                </c:forEach>
            </c:if>
            <c:if test="${empty vehicles}">
                <p>No vehicles found.</p>
            </c:if>

            <a href="<s:url value='/user/dashboard'/>" class="btn">Back to Dashboard</a>
        </main>
    </div>

    <footer class="footer">
        <p>&copy; 2024-2025 <a href="http://yash.com" target="_blank">YASH TECHNOLOGIES PVT LTD</a> | All Rights Reserved</p>
    </footer>
</body>
</html>