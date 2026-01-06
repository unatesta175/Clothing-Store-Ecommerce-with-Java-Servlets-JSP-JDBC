# 🖨️ Expose Printing

A robust, enterprise-grade e-commerce platform tailored for printing businesses. This application provides a seamless experience for customers to browse and order custom apparel, while offering a comprehensive administrative suite for business management.

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

