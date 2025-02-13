<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicle Details - Parking Allocation System</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="icon" href="static/images/logo.jpg" type="image/jpg">
    <style>
        :root {
            --primary-color: #3b82f6;
            --secondary-color: #1d4ed8;
            --background-light: rgba(249, 250, 251, 0.8); /* Light background with transparency */
            --surface-light: rgba(255, 255, 255, 0.9); /* Surface with transparency */
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
            background-color: rgba(255, 255, 255, 0.8); /* Semi-transparent overlay */
            border-radius: var(--border-radius);
            z-index: 1;
        }

        .main-content > * {
            position: relative; /* Ensure content is above the overlay */
            z-index: 2;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px , 1fr));
            gap: 1.5rem;
        }

        .card {
            background-color: var(--surface-light);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 1.5rem;
            margin:5px;
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
            transition: transform 0.3s ease;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card-icon {
            font-size: 2.5rem;
            color: var(--primary-color);
            margin-bottom: 1rem;
        }

        .card-title {
            font-weight: 600;
            color: var(--text-primary);
        }

        .card-description {
            color: var(--text-secondary);
            font-size: 0.9rem;
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

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        th, td {
            padding: 0.75rem;
            text-align: center;
            border-bottom: 1px solid var(--border-color);
        }

        th {
            background: linear-gradient(to bottom, #f9fafb, #f3f4f6);
            color: var(--text-primary);
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 2px solid var(--primary-color);
        }

        tr:nth-child(even) {
            background-color: #f7f7f7;
        }

        .success-message, .error-message {
            padding: 1rem;
            margin-bottom: 1rem;
            border-radius: var(--border-radius);
        }

        .success-message {
            background-color: #dff0d8;
            color: #3c763d;
            border: 1px solid #d6e9c6;
        }

        .error-message {
            background-color: #f2dede;
            color: #a94442;
            border: 1px solid #ebccd1;
        }

        .vehicle-action-button {
            display: inline-block;
            padding: 0.5rem 1rem;
            margin: 0.25rem;
            border-radius: var(--border-radius);
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .book-slot-button {
            background-color: var(--accent-color);
            color: white;
        }

        .update-vehicle-button {
            background-color: var(--primary-color);
            color: white;
        }

        .delete-vehicle-button {
            background-color: #ef4444;
            color: white;
        }

        .view-slot-button {
            background-color: #8b5cf6;
            color: white;
        }

        .receipt-button {
            background-color: var(--warning-color);
            color: white;
        }

        .no-slot-message {
            padding: 0.5rem;
            border-radius: var(--border-radius);
            background-color: #fca5a5;
            color: var(--text-primary);
            font-weight: 600;
            border: 1px solid #f87171;
            font-size: 0.9rem;
            text-align: center;
        }

        .check-availability-section {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }

        .check-avail-button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            padding: 0.75rem 1.25rem;
            background-color: var(--primary-color);
            color: white;
            border: none;
            border-radius: var(--border-radius);
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
        }

        .check-avail-button:hover {
            background-color: var(--secondary-color);
        }

        #slot-availability-message {
            text-align: center;
            margin-top: 1rem;
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
    <s:url var="url_jqlib" value="/static/js/jquery-3.2.1.min.js" />
    <script src="${url_jqlib}"></script>
    <script>
        function checkSlotAvailability(vehicleType) {
            var messageDiv = $('#slot-availability-message');
            messageDiv.hide().removeClass('success-message error-message');

            $.ajax({
                url: '${pageContext.request.contextPath}/checkSlotAvailability',
                type: 'GET',
                data: { vehicleType: vehicleType },
                success: function(response) {
                    messageDiv.text(response)
                              .addClass('success-message')
                              .show();
                },
                error: function(xhr, status, error) {
                    messageDiv.text('Error checking slot availability. Please try again.')
                              .addClass('error-message')
                              .show();
                    console.error('Error fetching slot availability:', error);
                }
            });
        }
    </script>
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
                <li><a href="<s:url value='/user/vehicle/details'/>" class="active"><i class="fas fa-info-circle"></i> Vehicle Details</a></li>
                <li><a href="<s:url value='/user/parking/bookings'/>"><i class="fas fa-parking"></i> My Bookings</a></li>
                <li><a href="<s:url value='/logout'/>"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <h1>Vehicle Details</h1>
            <p>Manage your vehicles and book your slot efficiently.</p>

            <div class="dashboard-grid">
                <div class="card">
                    <div class="card-icon"><i class="fas fa-parking"></i></div>
                    <h2 class="card-title">Check Slot Availability</h2>
                    <p class="card-description">Check parking slot availability for your vehicle type.</p>
                    <div class="check-availability-section">
                        <button class="check-avail-button" onclick="checkSlotAvailability(1)">
                            <i class="fas fa-motorcycle"></i> Two Wheeler
                        </button>
                        <button class="check-avail-button" onclick="checkSlotAvailability(2)">
                            <i class="fas fa-car"></i> Four Wheeler
                        </button>
                    </div>
                    <div id="slot-availability-message"></div>
                </div>
            </div>

            <!-- Vehicle Details Table -->
            <div class="card mt-4">
                <h2 class="card-title">Your Vehicles</h2>

                <c:if test="${param.act eq 'abs'}">
                    <div class="error-message">
                        <p><i class="fas fa-info-circle"></i> This vehicle already has a booked slot.</p>
                    </div>
                </c:if>

                <c:if test="${param.act eq 'vrs'}">
                    <div class="success-message">
                        <p><i class="fas fa-info-circle"></i> Your vehicle has been registered successfully!</p>
                    </div>
                </c:if>

                <c:if test="${param.act eq 'del'}">
                    <div class="success-message">
                        <p><i class="fas fa-info-circle"></i> Vehicle Details Deleted Successfully.</p>
                    </div>
                </c:if>

                <c:if test="${param.act eq 'sld'}">
                    <div class="success-message">
                        <p><i class="fas fa-info-circle"></i> Your Parking Slot Released Successfully.</p>
                    </div>
                </c:if>

                <c:if test="${param.act eq 'upd'}">
                    <div class="success-message">
                        <p><i class="fas fa-info-circle"></i> Vehicle Details Updated Successfully!!</p>
                    </div>
                </c:if>

                <table>
                    <tr>
                        <th>Vehicle Number</th>
                        <th>Vehicle Type</th>
                        <th>Chassis Number</th>
                        <th>Owner Name</th>
                        <th>Owner Email</th>
                                                <th>Actions</th>
                                                <th>Details</th>
                                            </tr>
                                            <c:forEach var="vehicle" items="${vehicles}">
                                                <tr>
                                                    <td>${vehicle.vehicleNumber}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${vehicle.vehicleType == 1}">Two Wheeler</c:when>
                                                            <c:when test="${vehicle.vehicleType == 2}">Four Wheeler</c:when>
                                                        </c:choose>
                                                    </td>
                                                    <td>${vehicle.chassisNumber}</td>
                                                    <td>${vehicle.user.name}</td>
                                                    <td>${vehicle.user.email}</td>
                                                    <td>
                                                        <div class="action-button-container">
                                                            <a class="vehicle-action-button book-slot-button" href="<s:url value='/user/vehicle/bookSlot/${vehicle.vehicleId}' />">
                                                                <i class="fas fa-calendar-check"></i> Book Slot
                                                            </a>
                                                            <a class="vehicle-action-button update-vehicle-button" href="<s:url value='/user/vehicle/update?vehicleId=${vehicle.vehicleId}' />">
                                                                <i class="fas fa-edit"></i> Edit Vehicle Details
                                                            </a>
                                                            <a class="vehicle-action-button delete-vehicle-button" href="<s:url value='/user/vehicle/delete?vehicleId=${vehicle.vehicleId}' />">
                                                                <i class="fas fa-trash-alt"></i> Delete Vehicle
                                                            </a>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="action-button-container">
                                                            <c:if test="${vehicle.parking != null}">
                                                                <a class="vehicle-action-button view-slot-button" href="<s:url value='/user/vehicle/slotDetails?vehicleId=${vehicle.vehicleId}' />">
                                                                    <i class="fas fa-info-circle"></i> View Slot Details
                                                                </a>
                                                            </c:if>
                                                            <c:if test="${vehicle.parking == null}">
                                                                <div class="no-slot-message">
                                                                    Book the slot as your vehicle does not have any slot allocated
                                                                </div>
                                                            </c:if>
                                                            <c:if test="${vehicle.parking.slotStatus == 2}">
                                                                <a class="vehicle-action-button receipt-button" href="<s:url value='/user/vehicle/receipt?slotId=${vehicle.parking.slotId}' />">
                                                                    <i class="fas fa-receipt"></i> View Receipt
                                                                </a>
                                                            </c:if>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </table>
                                    </div>
                                </main>
                            </div>

                            <footer class="footer">
                                <p>&copy; 2024-2025 <a href="http://yash.com" target="_blank">YASH TECHNOLOGIES PVT LTD</a> | All Rights Reserved</p>
                            </footer>
                        </body>
                   </html>