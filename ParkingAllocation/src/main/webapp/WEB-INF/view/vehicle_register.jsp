<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Vehicle - Parking Allocation System</title>
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

        .registration-container {
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

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.75rem;
            color: var(--text-secondary);
            font-weight: 500;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 0.875rem;
            background-color: var(--surface-light);
            border: 1px solid var(--border-color);
            border-radius: var(--border-radius);
            color: var(--text-primary);
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .form-group input:focus,
        .form-group select:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2);
        }

        .submit-btn {
            background-color: var(--primary-color);
            color: white;
            border: none;
            padding: 0.875rem;
            border-radius: var(--border-radius);
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.3s ease;
            width: 100%;
            font-weight: 600;
        }

        .submit-btn:hover {
            background-color: var(--secondary-color);
            transform: translateY(-2px);
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

    <script type="text/javascript">
    function validateForm() {
        var vehicleNumber = document.getElementById("vehicleNumber").value;
        var vehicleType = document.getElementById("vehicleType").value;
        var errorMessage = document.getElementById("errorMessage");
        if (vehicleNumber.trim() === "" || vehicleType.trim() === "") {
            errorMessage.innerText = "All fields are required.";
            return false;
        }
        return true;
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
                <li><a href="#" class="active"><i class="fas fa-car"></i> Register Vehicle</a></li>
                <li><a href="<s:url value='/user/vehicle/details'/>"><i class="fas fa-info-circle"></i> Vehicle Details</a></li>
                <li><a href="<s:url value='/user/parking/bookings'/>"><i class="fas fa-parking"></i> My Bookings</a></li>
                <li><a href="<s:url value='/logout'/>"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <h1>Register Vehicle</h1>
            <p>Add a new vehicle to your profile for parking management.</p>

            <div class="registration-container">
                <h2 class="text-center mb-4"><i class="fas fa-car"></i> Vehicle Registration</h2>

                <c:if test="${not empty errorMessage}">
                    <div style="color: var(--warning-color); margin-bottom: 1rem;">
                        <p>${errorMessage}</p>
                    </div>
                </c:if>

                <f:form method="POST" action="${pageContext.request.contextPath}/user/vehicle/register" modelAttribute="command">
                    <div class="form-group">
                        <label><i class="fas fa-id-card"></i> Vehicle Number</label>
                        <f:input path="vehicle.vehicleNumber" required="required" placeholder="Enter Vehicle Number Ex.(MP08CD3478)"/>
                    </div>

                    <div class="form-group">
                        <label><i class="fas fa-car-side"></i> Vehicle Type</label>
                        <f:select path="vehicle.vehicleType" required="required">
                            <f:option value="1">Two Wheeler</f:option>
                            <f:option value="2">Four Wheeler</f:option>
                        </f:select>
                    </div>

                    <div class="form-group">
                        <label><i class="fas fa-car"></i> Chassis Number</label>
                        <f:input path="vehicle.chassisNumber" required="required" placeholder="Enter Chassis Number Ex.(SV30-0169266)"/>
                    </div>

                    <div class="form-group">
                        <button type="submit" class="submit-btn"><i class="fas fa-paper-plane"></i> Register Vehicle</button>
                    </div>
                </f:form>
            </div>
        </main>
    </div>

    <footer class="footer">
        <p>&copy; 2024-2025 <a href="http://yash.com" target="_blank">YASH TECHNOLOGIES PVT LTD</a> | All Rights Reserved</p>
    </footer>
</body>
</html>