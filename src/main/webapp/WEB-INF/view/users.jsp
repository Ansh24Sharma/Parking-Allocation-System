<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User List - Parking Allocation System</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="icon" href="static/images/logo.jpg" type="image/jpg">
    <s:url var="url_jqlib" value="/static/js/jquery-3.2.1.min.js" />
    <script src="${url_jqlib}"></script>
    <script>
        function changeStatus(uid, lstatus){
            $.ajax({
                url:'change_status',
                data:{userId:uid, loginStatus:lstatus},
                success: function (data) {
                    alert(data);
                }
            });
        }
    </script>
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

        select {
            padding: 0.5rem;
            border-radius: var(--border-radius);
            border: 1px solid var(--border-color);
            background: var(--surface-light);
            color: var(--text-primary);
            transition: all 0.3s ease;
        }

        select:hover {
            border-color: var(--primary-color);
        }

        .footer {
            background: var(--surface-light);
            padding: 1.5rem;
            text-align: center;
            border-top: 1px solid var(--border-color);
            color: var(--text-secondary);
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
                <li><a href="#" class="active"><i class="fas fa-users"></i> User Management</a></li>
                <li><a href="<s:url value='/admin/bookings'/>"><i class="fas fa-calendar-check"></i> Booking Overview</a></li>
                <li><a href="<s:url value='/admin/viewReports'/>"><i class="fas fa-chart-bar"></i> Reports & Analytics</a></li>
                <li><a href="<s:url value='/logout'/>"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <div class="content-wrapper">
                <h1>User Management</h1>
                <p class="mb-4">Manage user accounts and their access status.</p>

                <div class="table-container">
                    <h3><i class="fas fa-users"></i> User List</h3>
                    <table>
                        <thead>
                            <tr>
                                <th>SN</th>
                                <th>NAME</th>
                                <th>PHONE</th>
                                <th>EMAIL</th>
                                <th>LOGIN NAME</th>
                                <th>STATUS</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="u" items="${userList}" varStatus="st">
                                <tr>
                                    <td>${st.count}</td>
                                    <td>${u.name}</td>
                                    <td>${u.phone}</td>
                                    <td>${u.email}</td>
                                    <td>${u.loginName}</td>
                                    <td>
                                        <select id="id_${u.userId}" onchange="changeStatus(${u.userId}, $(this).val())">
                                            <option value="1">Active</option>
                                            <option value="2">Block</option>
                                        </select>
                                        <script>
                                            $('#id_${u.userId}').val(${u.loginStatus});
                                        </script>
                                    </td>
                                </tr>
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
</body>
</html>