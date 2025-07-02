<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Parking Allocation System</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="icon" href="static/images/logo.jpg" type="image/jpg">
    <s:url var="url_jqlib" value="/static/js/jquery-3.2.1.min.js" />
    <script src="${url_jqlib}"></script>
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

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background-color: var(--surface-light);
            border-radius: var(--border-radius);
            padding: 1.5rem;
            box-shadow: var(--box-shadow);
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .stat-icon {
            font-size: 2rem;
            padding: 1rem;
            border-radius: 50%;
        }

        .stat-info h3 {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 0.25rem;
        }

        .stat-info p {
            color: var(--text-secondary);
        }

        .users-icon { background-color: rgba(37, 99, 235, 0.1); color: var(--primary-color); }
        .bookings-icon { background-color: rgba(16, 185, 129, 0.1); color: var(--accent-color); }
        .revenue-icon { background-color: rgba(245, 158, 11, 0.1); color: var(--warning-color); }
        .alerts-icon { background-color: rgba(239, 68, 68, 0.1); color: var(--danger-color); }

        .dashboard-sections {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
        }

        .section-card {
            background-color: var(--surface-light);
            border-radius: var(--border-radius);
            padding: 1.5rem;
            box-shadow: var(--box-shadow);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .section-title {
            font-size: 1.25rem;
            font-weight: 600;
        }

        .recent-activities {
            list-style: none;
        }

        .activity-item {
            display: flex;
            align-items: start;
            gap: 1rem;
            padding: 1rem 0;
            border-bottom: 1px solid var(--border-color);
        }

        .activity-icon {
            padding: 0.5rem;
            border-radius: 50%;
            background-color: rgba(37, 99, 235, 0.1);
            color: var(--primary-color);
        }

        .activity-details h4 {
            font-weight: 500;
            margin-bottom: 0.25rem;
        }

        .activity-time {
            font-size: 0.875rem;
            color: var(--text-secondary);
        }

        .alerts-list {
            list-style: none;
        }

        .alert-item {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem;
            background-color: rgba(239, 68, 68, 0.1);
            border-radius: var(--border-radius);
            margin-bottom: 0.75rem;
        }

        .alert-icon {
            color: var(--danger-color);
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
        }

        .btn:hover {
            background-color: var(--secondary-color);
        }

        .btn-outline {
            background-color: transparent;
            border: 2px solid var(--primary-color);
            color: var(--primary-color);
        }

        .btn-outline:hover {
            background-color: var(--primary-color);
            color: white;
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

        @media (max-width: 1024px) {
            .dashboard-sections {
                grid-template-columns: 1fr;
            }
        }

        @media (max-width: 768px) {
            .dashboard-container {
                grid-template-columns: 1fr;
            }

            .sidebar {
                display: none;
            }

            .stats-grid {
                grid-template-columns: 1fr;
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
                <li><a href="#" class="active"><i class="fas fa-home"></i> Dashboard</a></li>
                <li><a href="<s:url value='/admin/users'/>"><i class="fas fa-users"></i> User Management</a></li>
                <li><a href="<s:url value='/admin/bookings'/>"><i class="fas fa-calendar-check"></i> Booking Overview</a></li>
                <li><a href="<s:url value='/admin/viewReports'/>"><i class="fas fa-chart-bar"></i> Reports & Analytics</a></li>
                <li><a href="<s:url value='/logout'/>"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <div class="content-wrapper">
                <h1>Admin Dashboard</h1>
                <p class="mb-4">Welcome back! Here's your parking system overview.</p>

                <!-- Statistics Grid -->
                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-icon users-icon">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stat-info">
                            <h3>${totalUsers}</h3>
                            <p>Total Users</p>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon bookings-icon">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <div class="stat-info">
                            <h3>${activeBooking}</h3>
                            <p>Active Bookings</p>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon revenue-icon">
                            <i class="fas fa-rupee-sign"></i>
                        </div>
                        <div class="stat-info">
                            <h3>₹ ${totalRevenue}</h3>
                            <p>Total Revenue</p>
                        </div>
                    </div>
                </div>

                <!-- Dashboard Sections -->
                <div class="dashboard-sections">
                    <!-- Recent Activities -->
                    <section class="section-card">
                        <div class="section-header">
                            <h2 class="section-title">Recent Activities</h2>
                            <button id="clearActivities" class="btn btn-outline">Clear All</button>
                        </div>
                        <ul class="recent-activities">
                        <c:choose>
                          <c:when test="${empty recentActivities}">
                             <li class="activity-item">No recent activities to display.</li>
                          </c:when>
                        <c:otherwise>
                           <c:forEach var="activity" items="${recentActivities}">
                            <li class="activity-item">
                                <span class="activity-icon">
                                    <i class="fas ${activity.type == 'New User' ? 'fa-user-plus' : (activity.type == 'New Booking' ? 'fa-car' : 'fa-registered')}"></i>
                                </span>
                                <div class="activity-details">
                                    <h4>${activity.type}</h4>
                                    <p>${activity.description}</p>
                                   <span class="activity-time">${activity.formattedTimestamp}</span>
                                </div>
                            </li>
                           </c:forEach>
                          </c:otherwise>
                         </c:choose>
                        </ul>
                    </section>


                                                <!-- Parking Overview -->
                                                <section class="section-card" style="margin-top: 2rem;">
                                                    <div class="section-header">
                                                        <h2 class="section-title">Parking Space Overview</h2>
                                                    </div>
                                                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 1rem; margin-top: 1rem;">
                                                        <div class="stat-card">
                                                            <div class="stat-icon" style="background-color: rgba(16, 185, 129, 0.1); color: var(--accent-color);">
                                                                <i class="fas fa-check-circle"></i>
                                                            </div>
                                                            <div class="stat-info">
                                                                <h3>${availableTwoWheelerSlots}</h3>
                                                                <p>Available Two Wheeler Slots</p>
                                                            </div>
                                                        </div>
                                                        <div class="stat-card">
                                                            <div class="stat-icon" style="background-color: rgba(16, 185, 129, 0.1); color: var(--accent-color);">
                                                                <i class="fas fa-check-circle"></i>
                                                            </div>
                                                            <div class="stat-info">
                                                                <h3>${availableFourWheelerSlots}</h3>
                                                            <p>Available Four Wheeler Slots</p>
                                                            </div>
                                                        </div>
                                                        <div class="stat-card">
                                                            <div class="stat-icon" style="background-color: rgba(245, 158, 11, 0.1); color: var(--warning-color);">
                                                                <i class="fas fa-clock"></i>
                                                            </div>
                                                            <div class="stat-info">
                                                                <h3>${activeBooking}</h3>
                                                                <p>Reserved Spots</p>
                                                            </div>
                                                        </div>

                                                    </div>
                                                </section>

                                            </div>
                                        </main>
                                    </div>

                                    <footer class="footer">
                                        <p>&copy; 2024-2025 <a href="http://yash.com" target="_blank">YASH TECHNOLOGIES PVT LTD</a> | All Rights Reserved</p>
                                    </footer>

                                 <script>
                                    $(document).ready(function() {
                                      $('#clearActivities').click(function() {
                                      $.post("${pageContext.request.contextPath}/admin/clear-activities", function() {
                                         $('.recent-activities').empty();
                                        });
                                      });
                                    });
                                 </script>

                                </body>
                                </html>