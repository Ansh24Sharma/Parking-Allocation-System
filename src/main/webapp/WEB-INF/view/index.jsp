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
    <title>Login - Parking Allocation System</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="icon" href="static/images/logo.jpg" type="image/jpg">
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
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .header {
            background: var(--surface-light);
            padding: 1rem 2rem;
            box-shadow: var(--box-shadow);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .header h1 {
            font-size: 1.5rem;
            font-weight: 650;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .navbar {
            display: flex;
            justify-content: flex-end; /* Aligns the navbar to the right */
            gap: 1rem; /* Space between navbar items */
        }

        .navbar a {
            color: var(--text-secondary);
            text-decoration: none;
            padding: 0.75rem 1rem;
            border-radius: var(--border-radius);
            transition: all 0.3s ease;
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

        .login-container {
            background: var(--surface-light);
            padding: 2.5rem;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            width: 100%;
            max-width: 400px;
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

        .login-container h3 {
            color: var(--primary-color);
            margin-bottom: 2rem;
            font-size: 1.5rem;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
        }

        .message {
            padding: 1rem;
            border-radius: var(--border-radius);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .message.error {
            background-color: rgba(239, 68, 68, 0.2);
            color: var(--error-color);
            border: 1px solid rgba(239, 68, 68, 0.3);
        }

        .message.success {
            background-color: rgba(34, 197, 94, 0.2);
            color: var(--success-color);
            border: 1px solid rgba(34, 197, 94, 0.3);
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.75rem;
            color: var(--text-secondary);
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .form-group input {
            width: 100%;
            padding: 0.875rem;
            background-color: var(--input-bg);
            border: 1px solid var(--border-color);
            border-radius: var(--border-radius);
            color: var(--text-primary);
            transition: all 0.3s ease;
            font-size: 1rem;
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2);
        }

        .form-group input::placeholder {
            color: var(--text-secondary);
        }

        .login-btn {
            width: 100%;
            padding: 0.875rem;
            background-color: var(--primary-color);
            color: var(--text-primary);
            border: none;
            border-radius: var(--border-radius);
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
            font-size: 1rem;
        }

        .login-btn:hover {
            background-color: var(--secondary-color);
            transform: translateY(-2px);
        }

        .login-btn:active {
            transform: translateY(0);
        }

        .register-link {
            text-align: center;
            margin-top: 1.5rem;
            padding-top: 1.5rem;
            border-top: 1px solid var(--border-color);
            color: var(--text-secondary);
        }

        .register-link a {
            color: var(--primary-color);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .register-link a:hover {
            color: var(--text-primary);
            text-decoration: underline;
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
            transition: color 0.3s ease;
        }

        .footer a:hover {
            color: var(--text-primary);
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .navbar {
                flex-direction: row;
                flex-wrap: wrap;
                justify-content: center;
                gap: 0.5rem;
            }

            .navbar a {
                padding: 0.5rem 0.75rem;
                font-size: 0.875rem;
            }

            .main-content {
                padding: 1rem;
            }

            .login-container {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <header class="header" style="position:sticky; top:0%; padding: 1rem 2rem;">
        <h1><img src="${pageContext.request.contextPath}/static/images/logo.jpg" alt="Logo" style="height:40px; width:40px;">Login - Parking Allocation System</h1>
        <nav class="navbar">
            <s:url var="url_logout" value="/logout"/>
            <s:url var="url_reg_form" value="/reg_form"/>
            <s:url var="url_landing" value="/landing"/>
            <a href="${url_landing}"><i class="fas fa-home"></i> Home</a>
            <a href="${url_reg_form}"><i class="fas fa-user-plus"></i> Register</a>
        </nav>
    </header>

    <main class="main-content">
        <div class="login-container">
            <h3><i class="fas fa-user-circle"></i> User Login</h3>

            <c:if test="${err!=null}">
                <div class="message error">
                    <i class="fas fa-exclamation-circle"></i> ${err}
                </div>
            </c:if>

            <c:if test="${param.act eq 'lo'}">
                <div class="message success">
                    <i class="fas fa-check-circle"></i> Logout Successfully!
                </div>
            </c:if>

            <c:if test="${param.act eq 'reg'}">
                <div class="message success">
                    <i class="fas fa-check-circle"></i> Registration Successful. Please login
                </div>
            </c:if>

            <c:if test="${param.act eq 'abs'}">
                 <div class="message error">
                      <p><i class="fas fa-info-circle"></i>Payment failed!! Try again later.</p>
                 </div>
            </c:if>

            <s:url var="url_login" value="/login"/>
            <f:form action="${url_login}" modelAttribute="command">
                <div class="form-group">
                    <label for="loginName"><i class="fas fa-user"></i> Username</label>
                    <f:input path="loginName" id="loginName" placeholder="Enter your username" required="required"/>
                </div>

                <div class="form-group">
                    <label for="password"><i class="fas fa-lock"></i> Password</label>
                    <f:password path="password" id="password" placeholder="Enter your password" required="required"/>
                </div>

                <button type="submit" class="login-btn">
                    <i class="fas fa-sign-in-alt"></i> Login
                </button>

                <div class="register-link">
                    <p>Don't have an account? <a href="<s:url value="/reg_form"/>">Register Now</a></p>
                </div>
            </f:form>
        </div>
    </main>

    <footer class="footer">
        <p>&copy; 2024-2025 <a href="http://yash.com" target="_blank">YASH TECHNOLOGIES PVT LTD</a> | All Rights Reserved</p>
    </footer>
</body>
</html>