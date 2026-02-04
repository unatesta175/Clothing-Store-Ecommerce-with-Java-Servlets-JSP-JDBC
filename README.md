# 🖨️ Expose Printing

A robust, enterprise-grade e-commerce platform tailored for printing businesses. This application provides a seamless experience for customers to browse and order custom apparel, while offering a comprehensive administrative suite for business management.

## 📖 Development Journey

### The Challenge: Semester 4 Academic Project

This platform originated as a comprehensive academic project during Semester 4 of my Information Systems Engineering degree. What started as a team assignment evolved into a technical showcase that challenged conventional expectations and demonstrated the power of early planning and dedicated execution.

### Multi-Subject Integration

The project was uniquely designed to fulfill requirements across four critical subjects simultaneously:

- **CSC584 (Enterprise Programming)**: Backend architecture and business logic implementation
- **ICT502 (Database Engineering)**: Database design, optimization, and CRUD operations
- **ICT551 (Human Computer Interaction)**: Frontend design principles and user experience
- **ISP551 (System Design & Implementation)**: Complete system architecture and SDLC practices

### Team Composition & Role Distribution

While officially a four-member team project, the technical implementation was undertaken entirely by a single developer, showcasing end-to-end full-stack capabilities:

- **Muhammad Ilyas Bin Amran**: Solo Developer (Frontend, Backend, Database), System Analyst, System Designer
- **Khairul Amirin Bin Ahmad Shafri**: Lead Technical Writer, System Analyst, System Designer
- **Izzul Syahmi & Mashitah Balqis**: Documentation Support

### Development Timeline

#### Phase 1: Early Start (February - March, Semester Break)
Began development during the semester 3 break, establishing the foundation:
- Complete authentication system (login, registration, password management)
- Customer and admin portal interfaces
- Profile management functionality

#### Phase 2: Core Development (March - June, 4 Months)
Systematic implementation following the Software Development Life Cycle:
- Full-featured e-commerce functionality
- Administrative dashboard with analytics
- Order processing and inventory management
- Payment gateway integration

**Original Implementation**: [Java Servlets + JSP + JDBC + Oracle](https://github.com/unatesta175/Clothing-Store-Ecommerce-with-Java-Servlets-JSP-JDBC)

#### Phase 3: Framework Modernization (June - July, 1 Month)
To demonstrate adaptability and modern development practices, the entire system was reconstructed using contemporary frameworks:
- Migrated from Jakarta EE to **Spring Boot**
- Database transition from Oracle to **PostgreSQL**
- Leveraged Spring Data JPA and Hibernate for rapid schema generation
- Achieved deployment-ready status in just 30 days

**Modernized Version**: [Spring Boot + PostgreSQL + JPA](https://github.com/unatesta175/Clothing-Store-Ecommerce-System-with-Java-Spring-Boot-)

#### Phase 4: Microservices Architecture (July)
Extended the project with a dedicated registration microservice at the instructor's request, demonstrating understanding of distributed systems architecture.

**Microservice Implementation**: [Customer Registration Microservice](https://github.com/unatesta175/Register-Microservice-For-Clothing-Store-Ecommerce-System-with-Java-Spring-Boot-)

### Achievement Highlights

- **Deployment Success**: Out of 96 students across 3 groups, only 2 groups successfully deployed both main application and microservices to production hosting services
- **Early Completion**: Finished by Week 12, allowing focused preparation for final assessments
- **Academic Excellence**: Achieved Dean's List with GPA 3.78 (6 A grades, 1 A-, 1 B-)
- **Multiple Implementations**: Delivered 3 distinct codebases (Jakarta EE, Spring Boot, Microservice) within 6 months

### Key Takeaway

This project challenged the prevailing narrative that Semester 4 would be the most difficult term. Through early preparation, disciplined execution, and comprehensive understanding of the full development stack, it became a demonstration that ambitious technical goals are achievable even under academic pressure. The experience reinforced that starting early and maintaining consistent progress transforms seemingly impossible challenges into manageable milestones.


## 🚀 Features

### 🛒 Customer Interface
- **Product Catalog**: Dynamic browsing of Topwear and Bottomwear categories.
- **Shopping Cart**: Real-time management of selected items.
- **Secure Checkout**: Integrated payment processing flow.
- **Order History**: Personal dashboard for customers to track their previous purchases.
- **Profile Management**: Easy-to-use customer account settings.

### 🛠️ Administrative Dashboard
- **Sales Analytics**: Monthly and yearly sales visualizations.
- **Order Management**: Streamlined processing and updating of customer orders.
- **Inventory Control**: Full CRUD operations for products and staff members.
- **Performance Tracking**: Geographic sales data and staff activity monitoring.

## 💻 Tech Stack

- **Backend**: Java 17+, Jakarta EE 10 (Servlets 6.0)
- **Frontend**: JSP, HTML5, CSS3, JavaScript (ES6+), Bootstrap 4/5
- **Database**: Oracle Database / MySQL support
- **Design**: AdminLTE 3.2.0 Dashboard Template
- **Architecture**: DAO (Data Access Object) Pattern

## 📚 Libraries & Dependencies

### Backend (Java Libraries)
- **Google Gson (2.10.1)**: For JSON serialization and deserialization.
- **jBCrypt (0.4)**: Secure password hashing for user authentication.
- **Jakarta JSTL (2.0.0)**: Standard Tag Library for JSP development.
- **Oracle JDBC (ojdbc17)**: Database connectivity for Oracle environments.
- **MySQL Connector/J (8.0.31)**: Database connectivity for MySQL environments.

### Frontend (JavaScript/CSS)
- **AdminLTE (3.2.0)**: Core administrative dashboard framework.
- **Bootstrap (4.6.1 & 5)**: Responsive UI components.
- **jQuery (3.6.0)**: DOM manipulation and AJAX operations.
- **Chart.js (2.9.4)**: Data visualization for sales dashboards.
- **DataTables**: Advanced table interaction and formatting.
- **SweetAlert2**: Enhanced popup notifications and alerts.
- **Select2**: Advanced select boxes with search functionality.
- **Moment.js / Day.js**: Date and time manipulation.
- **FontAwesome 5 / Feather Icons**: Comprehensive icon sets.

### Additional Plugins & Tools
- **ECharts / Flot**: Advanced charting and plotting.
- **Leaflet**: Interactive maps for location-based data.
- **FullCalendar**: Scheduling and event management.
- **Dropzone / TinyMCE**: File uploads and rich text editing.
- **Swiper / GLightbox**: Modern touch sliders and image lightboxes.
- **Isotope / Packery**: Dynamic layout filtering and sorting.
- **Lodash**: Utility library for JavaScript.

## 🛠️ Installation & Setup

1. **Prerequisites**:
   - JDK 17 or higher
   - Apache Tomcat 10.1 or higher
   - Oracle Database (FREEPDB1 instance)
   - Eclipse IDE (Optional, but recommended for development)

2. **Database Configuration**:
   - Ensure your Oracle Database is running.
   - Update `src/main/java/db/connection/ConnectionManager.java` with your local credentials:
     ```java
     private static final String DB_CONNECTION = "jdbc:oracle:thin:@//localhost:1521/FREEPDB1";
     private static final String DB_USER = "your_username";
     private static final String DB_PASSWORD = "your_password";
     ```

3. **Deployment**:
   - Clone the repository.
   - Import as a Dynamic Web Project in Eclipse or build using your preferred tool.
   - Deploy the WAR file to your Tomcat server.

## 📞 Contact Information

📧 **Email**: muhammadilyasamran@gmail.com

🐙 **GitHub**: [@unatesta175](https://github.com/unatesta175)

🔗 **LinkedIn**: [muhammad-ilyas-bin-amran-3a9a2a298](https://www.linkedin.com/in/muhammad-ilyas-bin-amran-3a9a2a298)

---
Developed with ❤️ by Muhammad Ilyas Bin Amran

