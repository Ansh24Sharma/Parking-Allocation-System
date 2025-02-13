# Parking Allocation System

A web-based parking management solution built with Spring 4 and Java that streamlines vehicle parking allocation, user management, and payment processing.

## Features

### User Features
- User registration and authentication system
- Vehicle registration and management
- Real-time parking slot allocation
- Online payment integration with Razorpay
- Digital receipt generation
- Vehicle and booking history tracking

### Admin Features
- User account management and activation
- Comprehensive user activity monitoring
- Revenue tracking and analysis
- Task completion tracking (registrations, bookings, etc.)
- System-wide parking slot management

## Technology Stack

### Backend
- Java
- Spring Framework 4
- RESTful Web Services
- MySQL Database

### Frontend
- JSP (JavaServer Pages)
- HTML/CSS
- JavaScript
- Bootstrap (for responsive design)

### Payment Integration
- Razorpay Payment Gateway

## System Architecture

The application follows a 3-tier architecture:
1. Presentation Layer (JSP Views)
2. Business Layer (Spring Controllers & Services)
3. Data Layer (Database & Repositories)

## Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/parking-allocation-system.git
```

2. Configure MySQL database settings in `application.properties`
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/parking_system
spring.datasource.username=your_username
spring.datasource.password=your_password
```

3. Configure Razorpay credentials in the application configuration

4. Build the project
```bash
mvn clean install
```

5. Deploy the WAR file to your application server

## API Endpoints

The system provides REST APIs for:
- User Management
- Vehicle Registration
- Parking Allocation
- Payment Processing
- Admin Operations

Detailed API documentation can be found in the `/docs` directory.

## Usage

### For Users
1. Register an account
2. Wait for admin activation
3. Log in to the system
4. Register vehicle details
5. Book a parking slot
6. Complete payment
7. Download receipt

### For Administrators
1. Access admin dashboard
2. Manage user accounts
3. Monitor parking allocations
4. Track revenue
5. View system activities

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE.md file for details

## Contact

Ansh Sharma - [ansh1313jan@gmail.com](mailto:ansh1313jan@gmail.com)

Project Link: [https://github.com/yourusername/parking-allocation-system](https://github.com/yourusername/parking-allocation-system)
