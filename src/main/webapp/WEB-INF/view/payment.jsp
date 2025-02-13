<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>

<!DOCTYPE html>
<html>
<head>
    <title>Make Payment</title>
    <link rel="icon" href="static/images/logo.png" type="image/png" />
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    <link rel="stylesheet" href="static/css/payment.css" />
</head>
<body>
    <div class="container">
        <h2>Processing Payment</h2>
        <div class="spinner"></div>
        <p>Please do not close or refresh this page</p>
        <div class="order-info">
            <span>Order ID: </span><span id="order-id">${paymentId}</span>
        </div>
        <div id="error-message" style="color: red;"></div>
    </div>

    <script>
        function handlePayment() {
            try {
                var options = {
                    key: "${razorpayKeyId}", // Enter the Key ID generated from the Dashboard
                    amount: "${amount * 100}", // Amount is in currency subunits (paisa)
                    currency: "INR",
                    name: "Parking Allocation System",
                    description: "Test Transaction",
                    image: "${pageContext.request.contextPath}/static/images/logo.jpg",
                    order_id: "${paymentId}", // Use the correct variable for order ID
                    callback_url: "${pageContext.request.contextPath}/verify",
                    prefill: {
                        name: "Test User",
                        email: "test.user@example.com",
                        contact: "9999999999",
                    },
                    notes: {
                        address: "Razorpay Corporate Office",
                    },
                    theme: {
                        color: "#3399cc",
                    },
                    handler: function (response) {
                        console.log("Payment successful!");
                        console.log("Payment ID: " + response.razorpay_payment_id);
                        console.log("Order ID: " + response.razorpay_order_id);
                        console.log("Signature: " + response.razorpay_signature);

                        // Create a form to submit the payment details
                        var form = document.createElement("form");
                        form.method = "POST";
                        form.action = "${pageContext.request.contextPath}/verify";

                        var fields = {
                            razorpay_payment_id: response.razorpay_payment_id,
                            razorpay_order_id: response.razorpay_order_id,
                            razorpay_signature: response.razorpay_signature,
                        };

                        for (var fieldName in fields) {
                            var hiddenField = document.createElement("input");
                            hiddenField.type = "hidden";
                            hiddenField.name = fieldName;
                            hiddenField.value = fields[fieldName];
                            form.appendChild(hiddenField);
                        }

                        document.body.appendChild(form);
                        form.submit(); // Submit the form to verify the payment
                    },
                    modal: {
                        ondismiss: function () {
                            console.log("Checkout form closed");
                            window.location.href = "${pageContext.request.contextPath}/checkout"; // Redirect to checkout
                        },
                    },
                };

                console.log("Initializing Razorpay with options:", options);
                var rzp1 = new Razorpay(options);

                rzp1.on("payment.failed", function (response) {
                    console.error("Payment failed:", response.error);
                    document.getElementById("error-message").innerText =
                        "Payment failed: " + response.error.description; // Display error message
                });

                // Open Razorpay checkout
                rzp1.open();
            } catch (error) {
                console.error("Error in payment processing:", error);
                document.getElementById("error-message").innerText =
                    "Error initializing payment: " + error.message; // Display initialization error
            }
        }

        // Call handlePayment when the page loads
        window.onload = handlePayment;
    </script>
</body>
</html>