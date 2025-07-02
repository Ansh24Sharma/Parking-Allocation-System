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
  <title>Parking Allocation System</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.16/dist/tailwind.min.css" rel="stylesheet">
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
  <link rel="icon" href="static/images/logo.jpg" type="image/jpg">
  <style>
    body {
      font-family: 'Roboto', sans-serif;
    }
    .hero-bg {
      background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
      url('${pageContext.request.contextPath}/static/images/bg.jpg');
      background-size: cover;
      background-position: center;
    }
    .feature-icon {
      width: 60px;
      height: 60px;
      background-color: #4299e1;
      color: white;
      display: flex;
      justify-content: center;
      align-items: center;
      border-radius: 50%;
      font-size: 24px;
    }
    .pricing-card {
      border: 1px solid #e2e8f0;
      border-radius: 8px;
      box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
      transition: transform 0.3s ease;
    }
    .pricing-card:hover {
      transform: translateY(-5px);
    }
    .feature-image {
      height: 200px;
      object-fit: cover;
      border-radius: 8px;
    }
    .steps-card {
      transition: transform 0.3s ease, box-shadow 0.3s ease;
    }
    .steps-card:hover {
      transform: translateY(-10px);
      box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
    }
  </style>
</head>
<body>
 <header class="bg-white text-gray-900 py-4 shadow" style="position:sticky; top:0%; padding: 1rem 2rem;">
     <div class="flex justify-between items-center">
       <div class="text-2xl font-bold flex items-center">
         <img src="${pageContext.request.contextPath}/static/images/logo.jpg" alt="Logo" style="height:40px; width:40px;" class="mr-2">
         Parking Allocation System
       </div>
       <nav>
         <s:url var="url_reg_form" value="/reg_form"/>
         <s:url var="url_login" value="/index"/>
         <ul class="flex space-x-4">
           <li><a href="#" class="text-gray-600 px-4 py-3 rounded-lg transition-all duration-300 hover:bg-blue-500 hover:text-gray-900">
             <i class="fas fa-home"></i> Home</a></li>
           <li><a href="#features" class="text-gray-600 px-4 py-3 rounded-lg transition-all duration-300 hover:bg-blue-500 hover:text-gray-900">
             <i class="fas fa-star"></i> Features</a></li>
           <li><a href="#how-it-works" class="text-gray-600 px-4 py-3 rounded-lg transition-all duration-300 hover:bg-blue-500 hover:text-gray-900">
             <i class="fas fa-info-circle"></i> How It Works</a></li>
           <li><a href="#pricing" class="text-gray-600 px-4 py-3 rounded-lg transition-all duration-300 hover:bg-blue-500 hover:text-gray-900">
             <i class="fas fa-dollar-sign money-icon"></i> Pricing</a></li>
           <li><a href="${url_login}" class="text-gray-600 px-4 py-3 rounded-lg transition-all duration-300 hover:bg-blue-500 hover:text-gray-900">
             <i class="fas fa-sign-in-alt"></i> Login</a></li>
           <li><a href="${url_reg_form}" class="text-gray-600 px-4 py-3 rounded-lg transition-all duration-300 hover:bg-blue-500 hover:text-gray-900">
             <i class="fas fa-user-plus"></i> Register</a></li>
         </ul>
       </nav>
     </div>
 </header>

  <main>
    <section class="hero-bg py-32">
      <div class="container mx-auto px-4 text-white text-center">
        <h1 class="text-5xl font-bold mb-4">Parking Allocation System</h1>
        <p class="text-xl mb-8">Our platform streamlines the parking experience for customers.</p>
        <div class="flex justify-center space-x-4">
          <a href="${url_login}" class="bg-blue-500 hover:bg-blue-600 text-white py-3 px-6 rounded-md inline-block transition duration-300">
            <i class="fas fa-user-plus mr-2"></i>Get Started
          </a>
          <a href="#features" class="bg-transparent border-2 border-white hover:bg-white hover:text-gray-900 text-white py-3 px-6 rounded-md inline-block transition duration-300">
            <i class="fas fa-info-circle mr-2"></i>Learn More
          </a>
        </div>
      </div>
    </section>

    <section id="features" class="py-16">
      <div class="container mx-auto px-4">
        <h2 class="text-3xl font-bold mb-12 text-center">Key Features</h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
          <div class="text-center">
            <img src="${pageContext.request.contextPath}/static/images/register.jpg" alt="User Registration" class="feature-image mb-4 mx-auto" style="width: auto; height: 150px;">
            <div class="feature-icon mx-auto mb-4">
              <i class="fas fa-user-plus"></i>
            </div>
            <h3 class="text-xl font-bold mb-2">User Registration</h3>
            <p class="text-gray-600">Allow users to easily register and manage their parking accounts.</p>
          </div>
          <div class="text-center">
            <img src="${pageContext.request.contextPath}/static/images/vehicle.jpg" alt="Vehicle Registration" class="feature-image mb-4 mx-auto" style="width: auto; height: 150px;">
            <div class="feature-icon mx-auto mb-4">
              <i class="fas fa-car"></i>
            </div>
            <h3 class="text-xl font-bold mb-2">Vehicle Registration</h3>
            <p class="text-gray-600">Users can register their vehicles and view their details.</p>
          </div>
          <div class="text-center">
            <img src="${pageContext.request.contextPath}/static/images/booking.jpg" alt="Slot Booking" class="feature-image mb-4 mx-auto" style="width: auto; height: 150px;">
            <div class="feature-icon mx-auto mb-4">
              <i class="fas fa-calendar-check"></i>
            </div>
            <h3 class="text-xl font-bold mb-2">Slot Booking</h3>
            <p class="text-gray-600">Users can easily book available parking slots.</p>
          </div>
        </div>
      </div>
    </section>

    <section class="bg-gray-100 py-16">
      <div class="container mx-auto px-4">
        <h2 class="text-3xl font-bold mb-12 text-center">Our Benefits</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
          <div class="flex items-center">
            <img src="${pageContext.request.contextPath}/static/images/parking.jpg" alt="Parking Allocation" class="rounded-lg w-full" style="width: 300px; height: auto;">
          </div>
          <div class="flex flex-col justify-center">
            <h3 class="text-2xl font-bold mb-4">Parking Allocation System</h3>
            <ul class="space-y-4">
              <li class="flex items-center">
                <i class="fas fa-check-circle text-green-500 mr-2"></i>
                Real-time parking slot availability
              </li>
              <li class="flex items-center">
                 <i class="fas fa-check-circle text-green-500 mr-2"></i>
                  Pre-booking of Slots
                 </li>
            </ul>
          </div>
        </div>
      </div>
    </section>

    <section id="how-it-works" class="py-16 bg-white">
      <div class="container mx-auto px-4">
        <h2 class="text-3xl font-bold mb-12 text-center">How It Works</h2>
        <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
          <div class="text-center steps-card bg-gray-100 p-6 rounded-lg shadow-md">
            <div class="w-24 h-24 bg-blue-500 text-white rounded-full flex items-center justify-center mx-auto mb-4 text-4xl">
              <i class="fas fa-user-plus"></i>
            </div>
            <h3 class="text-xl font-bold mb-4">Step 1: Register/Login</h3>
            <p class="text-gray-600 h-20">Create an account or log in if you already have one.</p>
            <div class="mt-4 text-blue-500 font-semibold">
              <i class="fas fa-arrow-right"></i>
            </div>
          </div>

          <div class="text-center steps-card bg-gray-100 p-6 rounded-lg shadow-md">
            <div class="w-24 h-24 bg-green-500 text-white rounded-full flex items-center justify-center mx-auto mb-4 text-4xl">
              <i class="fas fa-car"></i>
            </div>
            <h3 class="text-xl font-bold mb-4">Step 2: Vehicle Registration</h3>
            <p class="text-gray-600 h-20">Add your vehicle details to your profile.</p>
            <div class="mt-4 text-green-500 font-semibold">
              <i class="fas fa-arrow-right"></i>
            </div>
          </div>

          <div class="text-center steps-card bg-gray-100 p-6 rounded-lg shadow-md">
            <div class="w-24 h-24 bg-purple-500 text-white rounded-full flex items-center justify-center mx-auto mb-4 text-4xl">
              <i class="fas fa-parking"></i>
            </div>
            <h3 class="text-xl font-bold mb-4">Step 3: Book Your Slot</h3>
            <p class="text-gray-600 h-20">Book the parking slot by the pricing preference.</p>
            <div class="mt-4 text-purple-500 font-semibold">
              <i class="fas fa-arrow-right"></i>
            </div>
          </div>

          <div class="text-center steps-card bg-gray-100 p-6 rounded-lg shadow-md">
            <div class="w-24 h-24 bg-red-500 text-white rounded-full flex items-center justify-center mx-auto mb-4 text-4xl">
              <i class="fas fa-check-circle"></i>
            </div>
            <h3 class="text-xl font-bold mb-4">Step 4: Confirm Booking</h3>
            <p class="text-gray-600 h-20">Review and confirm your parking slot reservation.</p>
            <div class="mt-4 text-red-500 font-semibold">
                <i class="fas fa-arrow-right"></i>
            </div>
          </div>
        </div>
      </div>
    </section>

    <section id="pricing" class="bg-gray-100 py-16">
      <div class="container mx-auto px-4">
        <h2 class="text-3xl font-bold mb-8 text-center">Pricing</h2>
        <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
          <div class="pricing-card p-6 bg-white">
            <h3 class="text-xl font-bold mb-4">Hourly</h3>
            <p class="text-4xl font-bold mb-4">₹10/hr</p>
            <ul class="text-gray-600 mb-8 space-y-2">
              <li class="flex items-center"><i class="fas fa-check text-green-500 mr-2"></i>1 Parking Slot</li>
              <li class="flex items-center"><i class="fas fa-check text-green-500 mr-2"></i>Basic Features</li>
            </ul>
            <a href="${url_login}" class="bg-blue-500 hover:bg-blue-600 text-white py-3 px-6 rounded-md inline-block w-full text-center transition duration-300">Join In</a>
          </div>

          <div class="pricing-card p-6 bg-white">
              <h3 class="text-xl font-bold mb-4">Daily</h3>
              <p class="text-4xl font-bold mb-4">₹200/day</p>
              <ul class="text-gray-600 mb-8 space-y-2">
                  <li class="flex items-center"><i class="fas fa-check text-green-500 mr-2"></i>1 Parking Slot</li>
                  <li class="flex items-center"><i class="fas fa-check text-green-500 mr-2"></i>Basic Features</li>
              </ul>
              <a href="${url_login}" class="bg-blue-500 hover:bg-blue-600 text-white py-3 px-6 rounded-md inline-block w-full text-center transition duration-300">Join In</a>
          </div>

          <div class="pricing-card p-6 bg-white">
            <h3 class="text-xl font-bold mb-4">Monthly</h3>
            <p class="text-4xl font-bold mb-4">₹4000/mo</p>
            <ul class="text-gray-600 mb-8 space-y-2">
              <li class="flex items-center"><i class="fas fa-check text-green-500 mr-2"></i>Various Slots</li>
              <li class="flex items-center"><i class="fas fa-check text-green-500 mr-2"></i>Custom Features</li>
            </ul>
            <a href="#" class="bg-blue-500 hover:bg-blue-600 text-white py-3 px-6 rounded-md inline-block w-full text-center transition duration-300">Coming Soon...</a>
          </div>
        </div>
      </div>
    </section>
  </main>

  <footer class="bg-gray-900 text-white py-8">
    <div class="container mx-auto px-4">
      <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
        <div>
          <h4 class="text-lg font-bold mb-4">About Us</h4>
          <p class="text-gray-400">Parking Allocation System for the customers who needs to book slots.</p>
        </div>
        <div>
          <h4 class="text-lg font-bold mb-4">Quick Links</h4>
          <ul class="space-y-2">
            <li><a href="#" class="text-gray-400 hover:text-white">Home</a></li>
            <li><a href="#features" class="text-gray-400 hover:text-white">Features</a></li>
            <li><a href="#how-it-works" class="text-gray-400 hover:text-white">How it works</a></li>
            <li><a href="#pricing" class="text-gray-400 hover:text-white">Pricing</a></li>
          </ul>
        </div>
        <div>
          <h4 class="text-lg font-bold mb-4">Support</h4>
          <ul class="space-y-2">
            <li><a href="#" class="text-gray-400 hover:text-white">Help Center</a></li>
            <li><a href="#" class="text-gray-400 hover:text-white">Privacy Policy</a></li>
            <li><a href="#" class="text-gray-400 hover:text-white">Terms of Service</a></li>
          </ul>
        </div>
        <div>
          <h4 class="text-lg font-bold mb-4">Contact</h4>
          <ul class="space-y-2 text-gray-400">
            <li><i class="fas fa-envelope mr-2"></i>support@parking.com</li>
            <li><i class="fas fa-phone mr-2"></i>+91 731 567 8900</li>
          </ul>
        </div>
      </div>
      <div class="border-t border-gray-800 mt-8 pt-8 text-center">
       <p>&copy; 2024-2025 <a href="http://yash.com" target="_blank">YASH TECHNOLOGIES PVT LTD</a> | All Rights Reserved</p>
      </div>
    </div>
  </footer>
</body>
</html>