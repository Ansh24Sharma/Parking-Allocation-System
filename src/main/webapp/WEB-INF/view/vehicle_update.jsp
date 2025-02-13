<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register Vehicle - Parking Allocation System</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">

    <style>
        :root {
            --primary-color: #3b82f6;
            --secondary-color: #1d4ed8;
            --background-light: #f9fafb;
            --surface-light: #ffffff;
            --text-primary: #1f2937;
            --text-secondary: #6b7280;
            --error-color: #ef4444;
            --success-color: #22c55e;
            --border-color: #d1d5db;
            --input-bg: #ffffff;
            --border-radius: 8px;
            --box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', system-ui, sans-serif;
        }

        body {
            background-color: var(--background-light);
            color: var(--text-primary);
            line-height: 1.5;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .header {
            background: var(--surface-light);
            padding: 1rem 2rem;
            box-shadow: var(--box-shadow);
            color: var(--text-primary);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .header h1 {
            font-size: 1.5rem;
            font-weight: 650;
        }

        .navbar {
            display: flex;
            justify-content: center;
            background: var(--surface-light);
            padding: 1px;
        }

        .navbar a {
            color: var(--text-secondary);
            text-decoration: none;
            padding: 0.75rem 1rem;
            border-radius: var(--border-radius);
            transition: all 0.3s ease;
            margin: 0 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .navbar a:hover {
            background-color: var(--primary-color);
            color: var(--text-primary);
        }

        .main-content {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
            background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
                  url('${pageContext.request.contextPath}/static/images/bg.jpg');
                  background-size: cover;
                  background-position: center;
        }

        .registration-container {
            background: var(--surface-light);
            padding: 2.5rem;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            width: 100%;
            max-width: 600px;
            border: 1px solid var(--border-color);
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

        .registration-container h3 {
            margin-bottom: 1.5rem;
            text-align: center;
            color: var(--primary-color);
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
            background-color: var(--input -bg);
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
            color: #ffffff;
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

        .submit-btn:active {
            transform: translateY(0);
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
            .navbar {
                flex-direction: column;
                align-items: center;
            }

            .navbar a {
                margin: 0.5rem 0;
            }

            .registration-container {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <header class="header" style="position:sticky; top:0%;">
        <h1><img src="${pageContext.request.contextPath}/static/images/logo.jpg" alt="Logo" style="height:40px; width:40px;"> Register Vehicle - Parking Allocation System</h1>
        <nav class="navbar">
                <s:url var="url_logout" value="/logout"/>
                <s:url var="url_index" value="/index"/>
                <a href="<s:url value='/user/dashboard' />"><i class="fas fa-home"></i> Home</a>
                <a href="<s:url value='/user/dashboard' />"><i class="fas fa-car"></i> Register Vehicle</a>
                <a href="<s:url value='/user/vehicle/details' />"><i class="fas fa-info-circle"></i> Vehicle Details</a>
                <a href="${url_logout}"><i class="fas fa-sign-out-alt"></i> Logout</a>
            </nav>
    </header>


    <main class="main-content">
        <div class="registration-container">
            <h3><i class="fas fa-car"></i> Update Vehicle Details</h3>
            <f:form method="POST" action="${pageContext.request.contextPath}/user/vehicle/update" modelAttribute="command">
            <form:hidden path="vehicle.vehicleId" />
                <div class="form-group">
                    <label><i class="fas fa-id-card"></i> Vehicle Number</label>
                    <f:input path="vehicle.vehicleNumber" value="${command.vehicle.vehicleNumber}"/>
                </div>
                <div class="form-group">
                    <label><i class="fas fa-car-side"></i> Vehicle Type</label>

                   <form:select path="vehicle.vehicleType">
                       <form:option value="1" label="Two Wheeler" />
                       <form:option value="2" label="Four Wheeler" />
                   </form:select>


                </div>
                <div class="form-group">
                    <label><i class="fas fa-car"></i> Chassis Number</label>
                    <f:input path="vehicle.chassisNumber" value="${command.vehicle.chassisNumber}"/>
                </div>
                <div class="form-group">
                    <button type="submit" class="submit-btn"><i class="fas fa-paper-plane"></i> Update Vehicle</button>
                </div>
            </f:form>
        </div>
    </main>

    <footer class="footer">
        <p>© 2024-2025 <a href="http://yash.com" target="_blank">YASH TECHNOLOGIES PVT LTD</a> | All Rights Reserved</p>
    </footer>
</body>
</html>