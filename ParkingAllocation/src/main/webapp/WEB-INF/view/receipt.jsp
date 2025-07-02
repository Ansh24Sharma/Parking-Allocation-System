<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Receipt - Parking Allocation System</title>
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

        .receipt-container {
            max-width: 800px;
            margin: auto;
            background: var(--surface-light);
            backdrop-filter: blur(10px);
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 2.5rem;
            animation: slideIn 0.5s ease-out;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .receipt-header {
            text-align: center;
            margin-bottom: 2.5rem;
            padding-bottom: 1.5rem;
            border-bottom: 2px solid var(--border-color);
        }

        .receipt-header h1 {
            color: var(--primary-color);
            font-size: 2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
        }

        .receipt-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 2rem;
            margin-bottom: 2.5rem;
        }

        .detail-group {
            background: rgba(255, 255, 255, 0.5);
            padding: 1.25rem;
            border-radius: var(--border-radius);
            border: 1px solid var(--border-color);
            transition: transform 0.3s ease;
        }

        .detail-group:hover {
            transform: translateY(-5px);
        }

        .detail-group dt {
            font-weight: 600;
            color: var(--text-secondary);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .detail-group dd {
            color: var(--text-primary);
            font-size: 1.125rem;
            font-weight: 500;
        }

        .receipt-footer {
            text-align: center;
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 2px solid var(--border-color);
        }

        .receipt-footer p {
            margin-bottom: 1.5rem;
            font-size: 1.125rem;
            color: var(--accent-color);
        }

        .btn-group {
            display: flex;
            gap: 1rem;
            justify-content: center;
            flex-wrap: wrap;
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
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .btn:hover {
            background-color: var(--secondary-color);
            transform: translateY(-2px);
        }

        .btn i {
            font-size: 1.1rem;
        }

        @media (max-width: 768px) {
            .receipt-container {
                padding: 1.5rem;
            }

            .receipt-details {
                grid-template-columns: 1fr;
            }

            .btn-group {
                flex-direction: column;
            }

            .btn {
                width: 100%;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <div class="receipt-container">
        <div class="receipt-header">
            <h1><i class="fas fa-receipt"></i> Payment Receipt</h1>
        </div>

        <div class="receipt-details">
            <div class="detail-group">
                <dt><i class="fas fa-hashtag"></i> Order ID</dt>
                <dd>${orderId}</dd>
            </div>
            <div class="detail-group">
                <dt><i class="fas fa-money-bill-wave"></i> Amount</dt>
                <dd>${amount}</dd>
            </div>
            <div class="detail-group">
                <dt><i class="fas fa-coins"></i> Currency</dt>
                <dd>${currency}</dd>
            </div>
            <div class="detail-group">
                <dt><i class="fas fa-file-invoice"></i> Receipt</dt>
                <dd>${receipt}</dd>
            </div>
            <div class="detail-group">
                <dt><i class="fas fa-parking"></i> Slot ID</dt>
                <dd>${slotId}</dd>
            </div>
            <div class="detail-group">
                <dt><i class="fas fa-calendar-alt"></i> Created At</dt>
                <dd id="createdAt"></dd>
            </div>
        </div>

        <div class="receipt-footer">
            <p><i class="fas fa-check-circle"></i> Thank you for your payment!</p>
            <div class="btn-group">
                <a href="/parkingallocation/user/vehicle/details" class="btn">
                    <i class="fas fa-info-circle"></i> Vehicle Details
                </a>
                <a href="<s:url value='/downloadReceipt'/>?slotId=${slotId}" class="btn">
                    <i class="fas fa-file-download"></i> Download Receipt
                </a>
            </div>
        </div>
    </div>

    <script>
        function formatDateTime(dateString) {
            const options = {
                year: 'numeric',
                month: 'long',
                day: 'numeric',
                hour: '2-digit',
                minute: '2-digit',
                hour12: true
            };
            const date = new Date(dateString);
            return date.toLocaleString('en-US', options);
        }

        const createdAtString = '${createdAt}';
        document.getElementById('createdAt').innerText = formatDateTime(createdAtString);
    </script>
</body>
</html>