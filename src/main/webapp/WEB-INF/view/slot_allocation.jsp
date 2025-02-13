<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Slot Allocation - Parking Allocation System</title>
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

            .slot-allocation-container {
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

            #price {
                margin-bottom: 1rem;
                font-weight: bold;
                color: var(--primary-color);
                text-align: center;
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


<script src="https://cdnjs.cloudflare.com/ajax/libs/flatpickr/4.6.9/flatpickr.min.js"></script>
    <script type="text/javascript">

        function calculatePrice() {
            let durationType = document.getElementById("allocationType").value;
            let duration = parseFloat(document.getElementById("duration").value);
            let hourlyRate = 10.0;
            let dailyRate = 200.0;
            let price = 0.0;

            if (durationType === "1") {
                price = hourlyRate * duration; // Hourly rate
                document.getElementById("price").innerText = "Total Price: " + price;
            } else if (durationType === "2") {
                price = dailyRate * duration; // Daily rate
                 document.getElementById("price").innerText = "Total Price: " + price;
            }

        }

        document.addEventListener('DOMContentLoaded', function() {
            flatpickr("#dateTime", {
                enableTime: true,
                dateFormat: "Y-m-d h:i",
                minDate: "today"
            });

            document.getElementById("duration").addEventListener("input", function() {
                this.value = this.value.replace(/[^0-9]/g, '');
            });
        });
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
                    <li><a href="<s:url value='/user/vehicle/details'/>"><i class="fas fa-info-circle"></i> Vehicle Details</a></li>
                    <li><a href="<s:url value='/user/parking/bookings'/>"><i class="fas fa-parking"></i> My Bookings</a></li>
                    <li><a href="<s:url value='/logout'/>"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
                </ul>
    </aside>


    <main class="main-content">
            <h1>Allocate Parking Slot</h1>
            <p>Select a parking slot and duration for your vehicle.</p>

            <div class="slot-allocation-container">
            <h2 class="text-center mb-4"><i class="fas fa-parking"></i> Slot Allocation</h2>
            <f:form method="POST" action="${pageContext.request.contextPath}/user/vehicle/allocateSlot" modelAttribute="command">

                <div class="form-group">
                    <label><i class="fas fa-clock"></i> Allocation Type (Price Per Hour: ₹10, Price Per Day: ₹200)</label>
                    <f:select path="allocationType" id="allocationType">
                        <f:option value="1">Hourly</f:option>
                        <f:option value="2">Daily</f:option>
                    </f:select>
                </div>

                <div class="form-group">
                                    <label><i class="fas fa-map-marker-alt"></i> Location</label>
                                    <f:select path="location" id="location">
                                        <f:option value="Mahatma Gandhi Road, Rajwada, Indore, MP">Mahatma Gandhi Road, Rajwada, Indore, MP</f:option>
                                        <f:option value="O-8, Ashokagar, Bhawarkuaraod, Indore, MP">O-8, Ashokagar, Bhawarkuaraod, Indore, MP</f:option>
                                        <f:option value="Vijay Nagar, Indore, MP">Vijay Nagar, Indore, MP</f:option>
                                    </f:select>
                 </div>


                <div class="form-group">
                    <label><i class="fas fa-hourglass-start"></i> Duration</label>
                    <f:input path="duration" id="duration" oninput="calculatePrice()" placeholder="Enter Duration"/>
                </div>

                <div class="form-group"> <label>Start Date and Time</label>
                      <input type="datetime-local" id="startDateTime" name="startDateTime" required />
                </div>

                <f:hidden path="vehicleId" value="${vehicleId}"/>

                <div id="price"></div>
                <div class="form-group">
                    <button type="submit" class="submit-btn"><i class="fas fa-check-circle"></i> Allocate Slot</button>
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