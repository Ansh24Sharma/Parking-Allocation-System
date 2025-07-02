<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="f" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration - Parking Allocation System</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="icon" href="static/images/logo.jpg" type="image/jpg">
    <s:url var="url_jqlib" value="/static/js/jquery-3.2.1.min.js" />
    <script src="${url_jqlib}"></script>
    <script>
        $(document).ready(function (){
            $("#id_check_avail").click(function(){
                $.ajax({
                    url : 'check_avail',
                    data : { username: $("#id_username").val() },
                    success : function(data){
                        $("#id_res_div").html(data);

                        if (data.includes("Yes! You can take this")) {
                            $("#id_res_div").removeClass('error').addClass('success');
                        } else {
                            $("#id_res_div").removeClass('success').addClass('error');
                        }
                    }
                });
            });
        });
    </script>
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

        .registration-container table {
            width: 100%;
            margin: 1rem 0;
        }

        .registration-container td {
            padding: 0.5rem;
        }

        .registration-container input {
            width: 100%;
            padding: 0.875rem;
            border: 1px solid var(--border-color);
            border-radius: var(--border-radius);
            background-color: var(--input-bg);
            color: var(--text-primary);
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .registration-container input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2);
        }

        .registration-container button {
            width: 100%;
            padding: 0.875rem;
            background-color: var(--primary-color);
            color: var(--text-primary);
            border: none;
            border-radius: var(--border-radius);
            cursor: pointer;
            font-weight: 600;
            transition: background-color 0.3s ease, transform 0.3s ease;
        }

        .registration-container button:hover {
            background-color: var(--secondary-color);
            transform: translateY(-2px);
        }

        .registration-container button:active {
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

        .error {
            color: var(--error-color);
            font-weight: bold;
            font-size: 0.875rem; /* Smaller font size */
            display: flex;
            align-items: center;
            margin-top: 0.5rem;
        }

        .error i {
            margin-right: 0.5rem; /* Space between icon and text */
        }

        .success { color: green; }

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

    <script>
        function validateName() {
            const name = document.querySelector('input[name="user.name"]').value;
            const namePattern = /^[A-Z][a-zA-Z\s]*$/;
            const nameError = document.getElementById('nameError');
            if (!namePattern.test(name)) {
                nameError.innerHTML = '<i class="fas fa-exclamation-circle"></i>Name should start with a capital letter and contain only letters.';
                return false;
            } else {
                nameError.textContent = "";
                return true;
            }
        }

       function validatePhone() {
                   const phone = document.querySelector('input[name="user.phone"]').value;
                   const phonePattern = /^\d{10}$/;
                   const phoneError = document.getElementById('phoneError');

                   // Return early if the phone number contains non-numeric characters
                   if (/[^0-9]/.test(phone)) {
                       phoneError.innerHTML = '<i class="fas fa-exclamation-circle"></i>Phone number should only contain digits.';
                       return false;
                   }

                   // Check if the phone number is exactly 10 digits long
                   if (!phonePattern.test(phone)) {
                       phoneError.innerHTML = '<i class="fas fa-exclamation-circle"></i>Phone number should be exactly 10 digits long.';
                       return false;
                   } else {
                       phoneError.textContent = "";
                       return true;
                   }
               }


        function validateEmail() {
            const email = document.querySelector('input[name="user.email"]').value;
            const emailPattern = /^[a-zA-Z0-9._%+-]+@(yash\.com|gmail\.com)$/;
            const emailError = document.getElementById('emailError');
            if (!emailPattern.test(email)) {
                emailError.innerHTML = '<i class="fas fa-exclamation-circle"></i>Please enter a valid email address with @yash.com or @gmail.com.';
                return false;
            } else {
                emailError.textContent = "";
                return true;
            }
        }

        function validatePassword() {
            const password = document.querySelector('input[name="user.password"]').value;
            const passwordError = document.getElementById('passwordError');

             const minLength = 8;
                        const uppercasePattern = /[A-Z]/;
                        const lowercasePattern = /[a-z]/;
                        const numberPattern = /[0-9]/;
                        const specialCharacterPattern = /[!@#$%^&*(),.?":{}|<>]/;

                        let message = "";

                        // Check the length
                        if (password.length < minLength) {
                            message += "Password must be at least " + minLength + " characters long. ";
                        }
                        // Check for uppercase letter
                        if (!uppercasePattern.test(password)) {
                            message += "Password must contain at least one uppercase letter. ";
                        }
                        // Check for lowercase letter
                        if (!lowercasePattern.test(password)) {
                            message += "Password must contain at least one lowercase letter. ";
                        }
                        // Check for number
                        if (!numberPattern.test(password)) {
                            message += "Password must contain at least one number. ";
                        }
                        // Check for special character
                        if (!specialCharacterPattern.test(password)) {
                            message += "Password must contain at least one special character. ";
                        }

                        // Display the validation message
                        if (message) {
                            passwordError.textContent = message;
                            passwordError.className = "error";
                        } else {
                            passwordError.textContent = "Password is valid.";
                            passwordError.className = "valid";
                        }
        }

        function validateForm() {
            return validateName() && validatePhone() && validateEmail() && validatePassword();
        }



        document.addEventListener('DOMContentLoaded', () => {
            document.querySelector('input[name="user.name"]').addEventListener('blur', validateName);
           document.querySelector('input[name="user.phone"]').addEventListener('input', function (event) {
                              this.value = this.value.replace(/[^0-9]/g, '');
                              });
            document.querySelector('input[name="user.email"]').addEventListener('blur', validateEmail);
            document.querySelector('input[name="user.password"]').addEventListener('blur', validatePassword);
        });
    </script>
</head>
<body>
    <header class="header" style="position:sticky; top:0%;">
        <h1 style="margin-right: auto;">
            <img src="${pageContext.request.contextPath}/static/images/logo.jpg" alt="Logo" style="height:40px; width:40px;">
            User Registration - Parking Allocation System
        </h1>
        <nav class="navbar">
            <s:url var="url_logout" value="/logout"/>

                <s:url var="url_reg_form" value="/reg_form"/>
                <s:url var="url_index" value="/index"/>
                <s:url var="url_landing" value="/landing"/>
                <a href="${url_landing}"><i class="fas fa-home"></i> Home</a>
                <a href="${url_index}"><i class="fas fa-sign-in-alt"></i> Login</a>
        </nav>
    </header>

    <main class="main-content">
        <div class="registration-container">
            <h3><i class="fas fa-user-plus"></i> User Registration</h3>
            <c:if test="${err!=null}">
                <p class="error">${err}</p>
            </c:if>
            <s:url var="url_reg" value="/register"/>
            <f:form action="${url_reg}" modelAttribute="command" oninput="return validateForm()">
                <table>
                    <tr>
                        <td><i class="fas fa-user"></i> Name</td>
                        <td>
                            <f:input path="user.name" required="required" placeholder="Enter your name"/>
                            <div id="nameError" class="error"></div>
                        </td>
                    </tr>
                    <tr>
                        <td><i class="fas fa-phone"></i> Phone</td>
                        <td>
                            <f:input path="user.phone" oninput="validatePhone()" required="required" placeholder="Enter valid phone number"/>
                            <div id="phoneError" class="error"></div>
                        </td>
                    </tr>
                    <tr>
                        <td><i class="fas fa-envelope"></i> Email</td>
                        <td>
                            <f:input path="user.email" required="required" placeholder="Enter valid email"/>
                            <div id="emailError" class="error"></div>
                        </td>
                    </tr>
                    <tr>
                        <td><i class="fas fa-user-circle"></i> Username</td>
                        <td>
                            <f:input id="id_username" path="user.loginName" required="required" placeholder="Enter your username"/>
                            <button type="button" id="id_check_avail"><i class="fas fa-check"></i> Check Availability</button>
                            <div id="id_res_div" class="error "></div>
                        </td>
                    </tr>
                    <tr>
                        <td><i class="fas fa-lock"></i> Password</td>
                        <td>
                            <f:password path="user.password" required="required" placeholder="Enter the password"/>
                            <div id="passwordError" class="error"></div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="right">
                            <button type="submit"><i class="fas fa-paper-plane"></i> Submit</button>
                        </td>
                    </tr>
                </table>
            </f:form>

             <div class="register-link">
                   <p>Already have an account? <a href="<s:url value="/index"/>">Login Now</a></p>
             </div>

        </div>
    </main>

    <footer class="footer">
        <p>&copy; 2024-2025 <a href="http://yash.com" target="_blank">YASH TECHNOLOGIES PVT LTD</a> | All Rights Reserved</p>
    </footer>
</body>
</html>