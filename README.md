# Digital Government Scheme Eligibility Checker

A web application that helps Indian citizens find government schemes they are eligible for based on their personal details like age, income, gender, and category.

---

## 📌 Table of Contents

- [About the Project](#about-the-project)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Database Setup](#database-setup)
- [Prerequisites](#prerequisites)
- [Installation & Deployment](#installation--deployment)
- [How to Use](#how-to-use)
- [Features](#features)
- [Reports & Analytics](#reports--analytics)
- [Screenshots](#screenshots)
- [Team](#team)

---

## 📖 About the Project

Many Indian citizens are unaware of government schemes they qualify for. This web application solves that by:

- Taking user details (age, income, gender, category, location)
- Matching them against a database of government schemes
- Showing all eligible schemes with official apply links
- Providing analytics reports for administrators

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Frontend | JSP + HTML + CSS + Bootstrap 5 |
| Backend | Java Servlets (Jakarta EE) |
| Database | MySQL 8 |
| Connectivity | JDBC with PreparedStatements |
| Server | Apache Tomcat 10 |
| Architecture | MVC (Model-View-Controller) |

---

## 📁 Project Structure

```
SchemeChecker/
├── src/
│   ├── controller/
│   │   ├── CheckEligibilityServlet.java
│   │   └── ReportServlet.java
│   ├── model/
│   │   ├── User.java
│   │   └── Scheme.java
│   ├── dao/
│   │   ├── SchemeDAO.java
│   │   └── UserDAO.java
│   └── util/
│       └── DBConnection.java
│
└── WebContent/
    ├── index.jsp
    ├── form.jsp
    ├── result.jsp
    ├── report.jsp
    ├── css/
    │   └── style.css
    └── WEB-INF/
        ├── web.xml
        └── lib/
            ├── jstl-1.2.jar
            └── mysql-connector-j-8.x.jar
```

---

## 🗄️ Database Setup

**1. Open MySQL Workbench or MySQL CLI**

**2. Run the SQL script:**
```sql
source scheme_db.sql
```
Or open `scheme_db.sql` in MySQL Workbench and click Execute.

**3. This creates:**
- Database: `scheme_db`
- Table: `users` — stores user details
- Table: `schemes` — stores government schemes with eligibility criteria and apply links
- Table: `results` — stores eligibility check history

**Default DB credentials used in the project:**
```
Host     : localhost
Port     : 3306
Database : scheme_db
Username : root
Password : (empty)
```
> ⚠️ To change credentials, edit `src/util/DBConnection.java`

---

## ✅ Prerequisites

Make sure you have these installed:

- [JDK 11 or 17](https://www.oracle.com/java/technologies/downloads/)
- [Apache Tomcat 10](https://tomcat.apache.org/download-10.cgi)
- [MySQL 8](https://dev.mysql.com/downloads/installer/)
- [MySQL Connector/J JAR](https://dev.mysql.com/downloads/connector/j/) — place in `WEB-INF/lib/`
- [JSTL 1.2 JAR](https://mvnrepository.com/artifact/javax.servlet/jstl/1.2) — place in `WEB-INF/lib/`

---

## 🚀 Installation & Deployment

### Method 1 — Using build.bat (Windows, Easiest)

```bash
# 1. Clone the repository
git clone https://github.com/YOUR_USERNAME/SchemeChecker.git

# 2. Place JAR files in WebContent/WEB-INF/lib/
#    - mysql-connector-j-8.x.jar
#    - jstl-1.2.jar

# 3. Run the database script in MySQL
#    Open MySQL Workbench → run scheme_db.sql

# 4. Build and deploy
.\build.bat

# 5. Start Tomcat
C:\apache-tomcat-10.x\bin\startup.bat

# 6. Open browser
http://localhost:8080/SchemeChecker
```

### Method 2 — Using Eclipse IDE

```
1. File → Import → Existing Projects into Workspace
2. Select project folder → Finish
3. Right-click project → Properties → Java Build Path → Add JARs
   (add both JARs from WEB-INF/lib/)
4. Right-click project → Export → WAR File
5. Save to: C:\apache-tomcat-10.x\webapps\SchemeChecker.war
6. Start Tomcat → open http://localhost:8080/SchemeChecker
```

### Method 3 — Manual Build

```bash
# Compile
javac -cp "WebContent/WEB-INF/lib/*" -d WebContent/WEB-INF/classes src/**/*.java

# Package WAR
jar -cvf SchemeChecker.war -C WebContent .

# Deploy
copy SchemeChecker.war C:\apache-tomcat-10.x\webapps\
```

---

## 🧭 How to Use

1. Open `http://localhost:8080/SchemeChecker`
2. Click **"Check Eligibility"**
3. Fill in your details:
   - Full Name
   - Age
   - Gender
   - Annual Income (in ₹)
   - Category (General / OBC / SC / ST)
   - Location / State
4. Click **"Check My Eligibility"**
5. View all schemes you qualify for
6. Click **"Apply Now →"** on any scheme to visit the official government portal

---

## ✨ Features

- ✅ Eligibility check based on age, income, gender, and category
- ✅ 10+ real Indian government schemes in database
- ✅ Official apply links for each scheme (opens in new tab)
- ✅ Personalized results with user summary
- ✅ Analytics dashboard with reports
- ✅ MVC architecture with clean separation of concerns
- ✅ Secure JDBC with PreparedStatements (SQL injection safe)
- ✅ Responsive Bootstrap 5 UI

---

## 📊 Reports & Analytics

Navigate to `/report` or click **"View Reports"** to see:

| Report | Description |
|---|---|
| Most Recommended Schemes | Which schemes matched the most users |
| Users by Category | Distribution of General / OBC / SC / ST users |
| Users by Income Group | Low / Medium / High income breakdown |

---

## 🔐 Eligibility Logic

A user is marked **eligible** for a scheme if ALL conditions are met:

```
age BETWEEN scheme.minAge AND scheme.maxAge
AND income <= scheme.maxIncome
AND (scheme.category = 'Any' OR scheme.category = user.category)
AND (scheme.gender = 'Any' OR scheme.gender = user.gender)
```

---

## 🌐 Government Schemes Included

| Scheme | Category | Apply Link |
|---|---|---|
| PM Kisan Samman Nidhi | Farmers | pmkisan.gov.in |
| Ayushman Bharat Yojana | Health | beneficiary.nha.gov.in |
| Beti Bachao Beti Padhao | Girl Child | wcd.nic.in |
| Pradhan Mantri Ujjwala Yojana | Women/BPL | pmuy.gov.in |
| PM Awas Yojana (Urban) | Housing | pmaymis.gov.in |
| Post Matric Scholarship for SC | SC Students | scholarships.gov.in |
| National Fellowship for ST | ST Students | scholarships.gov.in |
| Sukanya Samriddhi Yojana | Girl Child | indiapost.gov.in |
| Stand-Up India Scheme | Entrepreneurs | mudra.org.in |
| OBC Pre-Matric Scholarship | OBC Students | scholarships.gov.in |

---

## 🔧 Troubleshooting

| Problem | Solution |
|---|---|
| Port 8080 busy | Edit `Tomcat/conf/server.xml` → change port to 9090 |
| ClassNotFoundException for MySQL | JAR missing from `WEB-INF/lib/` |
| 404 Not Found | Check WAR name matches URL path |
| DB connection refused | Make sure MySQL service is running |
| JSTL tags not working | Ensure `jstl-1.2.jar` is in `WEB-INF/lib/` |

---

## 👥 Team

| Member | Responsibility |
|---|---|
| Member 1 | JSP UI (index, form, result, report pages) |
| Member 2 | Servlet logic (CheckEligibilityServlet, ReportServlet) |
| Member 3 | JDBC + Database (DAO classes, DB design) |
| Member 4 | Reports + Testing |

---

## 📄 License

This project was built for educational purposes as part of a college project.

---

> Built with ❤️ using Java Servlets + JSP + MySQL
