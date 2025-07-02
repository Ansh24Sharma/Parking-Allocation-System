<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard - Parking Allocation System</title>
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
            display: flex;
            flex-direction: column;
            gap: 1rem;
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

        .parking-slots {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }

        .slot-card {
            background-color: var(--surface-light);
            border-radius: var(--border-radius);
            padding: 1.5rem;
            text-align: center;
            box-shadow: var(--box-shadow);
            border: 1px solid var(--border-color);
        }

        .slot-price {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--accent-color);
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
                <img src="${pageContext.request.contextPath}/static/images/logo.jpg" alt="User  Avatar">
                <div>
                    <h3>${user.name}</h3>
                </div>
            </div>
            <ul class="sidebar-menu">
                <li><a href="#" class="active"><i class="fas fa-home"></i> Dashboard</a></li>
                <li><a href="<s:url value='/user/vehicle/register'/>"><i class="fas fa-car"></i> Register Vehicle</a></li>
                <li><a href="<s:url value='/user/vehicle/details'/>"><i class="fas fa-info-circle"></i> Vehicle Details</a></li>
                <li><a href="<s:url value='/user/parking/bookings'/>"><i class="fas fa-parking"></i> My Bookings</a></li>
                <li><a href="<s:url value='/logout'/>"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <h1>Welcome, ${user.name}!</h1>
            <p>Manage your parking needs efficiently.</p>

            <!-- Quick Actions -->
            <section class="dashboard-grid">
                <f:form method="POST" action="${pageContext.request.contextPath}/user/vehicle/register" modelAttribute="command">
                    <div class="card">
                        <div class="card-icon"><i class="fas fa-car"></i></div>
                        <h2 class="card-title">Register Vehicle</h2>
                        <p class="card-description">Add a new vehicle to your profile for easy parking management.</p>
                        <a href="<s:url value='/user/vehicle/register'/>" class="btn">Register Now</a>
                    </div>
                </f:form>
                <div class="card">
                    <div class="card-icon"><i class="fas fa-list"></i></div>
                    <h2 class="card-title">Vehicle Details</h2>
                    <p class="card-description">View and manage details of all your registered vehicles.</p>
                    <a href="<s:url value='/user/vehicle/details'/>" class="btn">View Details</a>
                </div>
                <div class="card">
                    <div class="card-icon"><i class="fas fa-ticket-alt"></i></div>
                    <h2 class="card-title">My Bookings</h2>
                    <p class="card-description">Check your current and past parking slot bookings.</p>
                    <a href="<s:url value='/user/parking/bookings'/>" class="btn">View Bookings</a>
                </div>
            </section>

            <!-- Parking Slots Information -->
            <section class="mt-4">
                <h2>Parking Slot Options</h2>
                <div class="parking-slots">
                    <div class="slot-card">
                        <h3>Hourly Parking</h3>
                        <p class="slot-price">₹10 per hour</p>
                        <p>Flexible short-term parking for quick stops.</p>
                        <a href="<s:url value='/user/vehicle/details'/>" class="btn">Book Hourly Slot</a>
                    </div>
                    <div class="slot-card">
                        <h3>Daily Parking</h3>
                        <p class="slot-price">₹100 per day</p>
                        <p>Convenient all-day parking for extended stays.</p>
                        <a href="<s:url value='/user/vehicle/details'/>" class="btn">Book Daily Slot</a>
                    </div>
                </div>
            </section>
        </main>
    </div>

    <footer class="footer">
            <p>&copy; 2024-2025 <a href="http://yash.com" target="_blank">YASH TECHNOLOGIES PVT LTD</a> | All Rights Reserved</p>
        </footer>
</body>
</html>