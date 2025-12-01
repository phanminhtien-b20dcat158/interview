# Interview Management System

A comprehensive web-based Interview Management System built with Spring Boot, designed to streamline the recruitment process by managing candidates, interviews, job positions, and offers.

## 📋 Table of Contents

- [Features](#features)
- [Technology Stack](#technology-stack)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Configuration](#configuration)
- [Database Setup](#database-setup)
- [Running the Application](#running-the-application)
- [Project Structure](#project-structure)
- [API Documentation](#api-documentation)
- [Security](#security)
- [Contributing](#contributing)

## ✨ Features

- **User Management**: Role-based access control with authentication and authorization
- **Candidate Management**: Track and manage candidate information throughout the recruitment process
- **Job Management**: Create and manage job positions
- **Interview Scheduling**: Schedule and manage interviews with candidates
- **Offer Management**: Generate and track job offers
- **Email Notifications**: Automated email notifications for interview schedules and offers
- **File Management**: Integration with Google Drive for document storage
- **Excel Export**: Export data to Excel format for reporting
- **Responsive UI**: JSP-based user interface with JSTL support

## 🛠 Technology Stack

### Backend
- **Framework**: Spring Boot 3.3.2
- **Java Version**: 17
- **Build Tool**: Maven
- **Database**: MySQL
- **ORM**: Spring Data JPA
- **Security**: Spring Security with JWT authentication
- **Validation**: Spring Validation

### Key Dependencies
- **MapStruct**: Object mapping
- **Lombok**: Reduce boilerplate code
- **JWT**: JSON Web Token for authentication (jjwt 0.11.5, java-jwt 4.4.0)
- **Apache POI**: Excel file generation
- **Google Drive API**: File storage integration
- **Spring Mail**: Email functionality
- **Spring DevTools**: Development utilities

### Frontend
- **Template Engine**: JSP with JSTL
- **Embedded Server**: Apache Tomcat

## 📦 Prerequisites

Before you begin, ensure you have the following installed:

- **Java Development Kit (JDK) 17** or higher
- **Maven 3.6+** (or use the included Maven wrapper)
- **MySQL 8.0+**
- **Git** (for version control)

## 🚀 Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/phanminhtien-b20dcat158/interview.git
   cd interview
   ```

2. **Verify Java and Maven installation**
   ```bash
   java -version
   mvn -version
   ```

## ⚙️ Configuration

1. **Create a `.env` file** in the project root directory with the following variables:
   ```env
   JWT_SECRET=your_jwt_secret_key_here
   DB_USERNAME=your_database_username
   DB_PASSWORD=your_database_password
   ```

2. **Configure application properties** (if needed)
   
   The application uses Spring Boot's default configuration. You can customize settings in `src/main/resources/application.properties` or `application.yml` if they exist.

   Typical configurations include:
   - Database connection URL
   - Server port
   - Email server settings
   - Google Drive API credentials

## 🗄️ Database Setup

1. **Create MySQL database**
   ```sql
   CREATE DATABASE interview_management;
   ```

2. **Import initial data**
   
   The `sql` folder contains mock data for testing:
   ```bash
   mysql -u your_username -p interview_management < sql/mock_roles.sql
   mysql -u your_username -p interview_management < sql/mock_users.sql
   mysql -u your_username -p interview_management < sql/mock_candidates.sql
   mysql -u your_username -p interview_management < sql/mock_jobs.sql
   mysql -u your_username -p interview_management < sql/mock_interviews.sql
   mysql -u your_username -p interview_management < sql/mock_scheduled_interviews.sql
   mysql -u your_username -p interview_management < sql/mock_offers.sql
   ```

   Or import them in the order listed above to maintain referential integrity.

## 🏃 Running the Application

### Using Maven Wrapper (Recommended)

**Windows:**
```bash
mvnw.cmd spring-boot:run
```

**Linux/Mac:**
```bash
./mvnw spring-boot:run
```

### Using Maven

```bash
mvn spring-boot:run
```

### Building and Running JAR

1. **Build the project**
   ```bash
   mvn clean package
   ```

2. **Run the JAR file**
   ```bash
   java -jar target/interview_managerment-0.0.1-SNAPSHOT.jar
   ```

The application will start on the default port (usually 8080). Access it at:
```
http://localhost:8080
```

## 📁 Project Structure

```
interview_managerment/
├── src/
│   ├── main/
│   │   ├── java/org/mock/interview_managerment/
│   │   │   ├── config/           # Configuration classes
│   │   │   ├── controller/       # REST controllers
│   │   │   ├── dto/              # Data Transfer Objects
│   │   │   ├── entities/         # JPA entities
│   │   │   ├── enums/            # Enumeration types
│   │   │   ├── exception/        # Custom exceptions
│   │   │   ├── mapper/           # MapStruct mappers
│   │   │   ├── repository/       # JPA repositories
│   │   │   ├── security/         # Security configuration
│   │   │   ├── services/         # Business logic services
│   │   │   ├── util/             # Utility classes
│   │   │   ├── validator/        # Custom validators
│   │   │   └── InterviewManagermentApplication.java
│   │   ├── resources/            # Application resources
│   │   └── webapp/               # JSP views and static files
│   └── test/                     # Test classes
├── sql/                          # Database scripts
├── .env                          # Environment variables
├── pom.xml                       # Maven configuration
└── README.md                     # This file
```

## 📚 API Documentation

The application provides RESTful APIs for:

- **Authentication**: Login, logout, token refresh
- **Users**: CRUD operations for user management
- **Candidates**: Manage candidate profiles
- **Jobs**: Job position management
- **Interviews**: Interview scheduling and management
- **Offers**: Job offer generation and tracking

> **Note**: Detailed API documentation can be generated using Swagger/OpenAPI (if integrated) or refer to the controller classes in `src/main/java/org/mock/interview_managerment/controller/`

## 🔒 Security

This application implements security features including:

- **JWT Authentication**: Secure token-based authentication
- **Role-Based Access Control (RBAC)**: Different permissions for different user roles
- **Password Encryption**: Secure password storage
- **Spring Security**: Comprehensive security framework

### Default Roles
The system supports multiple user roles (defined in `mock_roles.sql`). Check the SQL files for default users and their credentials.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

### Development Guidelines

- Follow Java coding conventions
- Write unit tests for new features
- Update documentation as needed
- Ensure all tests pass before submitting PR


---

