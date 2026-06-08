# G5: SmartShelf Management System

A robust, enterprise-grade, full-stack Library Management System engineered to digitize asset auditing, branch logistics, and transactional circulation workflows. Built for the **Database Systems Lab (CSC-104L)** course at the **University of Engineering and Technology (UET), Lahore**.

---

## 📖 Table of Contents
1. [Project Overview](#-project-overview)
2. [Key Architecture Requirements](#-key-architecture-requirements)
3. [Technology Stack](#-technology-stack)
4. [Database Design & ERD](#-database-design--erd)
5. [Core SQL Programming Components](#-core-sql-programming-components)
6. [User Interface Design Patterns](#-user-interface-design-patterns)
7. [Enterprise Business PDF Reports](#-enterprise-business-pdf-reports)
8. [Setup & Installation](#-setup--installation)

---

## 🚀 Project Overview
The **SmartShelf Management System** transforms manually tracked academic libraries into an integrated RDBMS-driven digital ecosystem. It provides deep programmatic management of institutional physical resources, personnel allocations, client borrowing patterns, and real-time fine assessment mechanisms.

### Institutional Operational Scope
* **Asset Tracking Optimization:** Implements a layered catalog model tracking abstract multi-author works down to separate physical item conditions mapped globally across branch networks.
* **Automated Financial Penalization:** Implements an exact database calculation tracking borrowing horizons, establishing late fees dynamically at **Rs. 5 per day overdue**.
* **ACID Transactions:** Runs core multi-entity changes inside atomic database boundaries to block resource collisions or race parameters during checkouts.

---

## 🛠️ Key Architecture Requirements
This platform completely implements all operational core elements defined in the official **CSC-104L Lab Project Guidelines**:

| System Standard Requirement | Implemented Architectural Feature | Verification Reference |
| :--- | :--- | :--- |
| **Domain Classes** | 14 Fully Mapped Database Entities | `/src/main/java/com/smartshelf/model/` |
| **Software Classes** | Dedicated Connection Pool, Utilities, Evaluators | `/src/main/java/com/smartshelf/util/` |
| **ERD Entities** | 15 Highly Normalized Relational Entities | See ERD Section Below |
| **Relational Tables** | 15 Interlocked Structural Base Schemas | `schema.sql` Database Init Script |
| **Robust Constraint Profiling** | 10+ Explicit PK, FK, CHECK, and ENUM Constraints | Database Schema DDL Architecture |
| **Atomic Transactions** | Explicit transaction sequences handling workflows | Service Layer Persistence Pipeline |
| **Pre-Calculated Views** | 5 Custom Complex Views Tracking Operations | View Initialization Queries |
| **Stored Procedures** | 3 Core Enterprise Context Routines | Database Routine Definitions |
| **Active Triggers** | 2 Automated Real-Time Status Evaluators | Database Automated Elements |
| **Runtime Error Logging** | Contextual Exception Routing to `error_log.txt` | Custom App Global Exception Handler |
| **Enterprise Data Reporting** | 10 Parameter-Filtered PDF Data Pipelines | PDF Template Engine Wrapper |
| **Responsive UX Architecture** | Decoupled Modern UI Optimized for Desktop/Tablets | Modular Frontend Views Engine |

---

## 💻 Technology Stack
* **Frontend Engine:** Semantic HTML5, Modular CSS3 Architecture (Grid/Flexbox layout definitions), and Modern Asynchronous JavaScript.
* **Core Application Runtime:** Java 17, Spring Boot Framework, Spring Data JPA, and Hibernate Engine.
* **Relational Storage Kernel:** MySQL 8.0 RDBMS Server instance utilizing the high-performance InnoDB transaction engine.
* **Build Architecture & Version Operations:** Apache Maven dependency controller and Git Version Control environment.

---

## 📊 Database Design & ERD

The relational database layer features a highly normalized schema designed to maintain total data consistency and prevent structural redundancies.

### Entity Relationship Diagram (ERD)

![SmartShelf ERD]
<img width="1386" height="1050" alt="WhatsApp Image 2026-06-08 at 3 41 19 PM" src="https://github.com/user-attachments/assets/a843be21-da12-410b-97d9-5586e9d00dc7" />


---

## 💾 Core SQL Programming Components

### 1. Pre-Calculated Database Views
* `vw_ActiveLoans`: Monitors live, ongoing checkouts with real-time member data links.
* `vw_OverdueLoans`: Isolates late checkouts while projecting real-time financial late fees.
* `vw_BookAvailability`: Indexes clean quantities of available books mapped by section branch.
* `vw_MemberLoanHistory`: Centralizes a unified logging log track of all historical member allocations.
* `vw_FinesSummary`: Filters all unpaid monetary fines to support administrative recovery workflows.

### 2. Embedded Stored Procedures
* `sp_IssueBook`: Validates checkout eligibility rules, instantiates the loan record, and toggles copy flags inside a safe wrapper.
* `sp_ReturnBook`: Evaluates structural due date limits, automatically assesses fines if overdue, and opens asset codes back up for general catalog availability.
* `sp_GenerateMemberReport`: Aggregates dynamic individual statistics, pulling active totals and borrowing trends for a specified member.

### 3. Automated Database Triggers
* `trg_AfterLoanInsert`: Automates inventory state updates, turning copy rows instantly to `Loaned` on new checkout creations.
* `trg_AfterReturnUpdate`: Monitors returning workflows to release copy flags back to `Available` right when loan return fields populate.

---

## 🎨 User Interface Design Patterns

The frontend provides a fast, responsive Single-Page Application (SPA) design optimized for desktop and tablet displays.

### App Screen Previews

#### 1. Reception Operations & Analytics Dashboard
<img width="1600" height="762" alt="image" src="https://github.com/user-attachments/assets/d31651e7-0761-4b45-903e-6f1500df5084" />


#### 2. Asset Cataloging & Form Editing Modal
<img width="1600" height="754" alt="image" src="https://github.com/user-attachments/assets/c6a286f6-ca61-46c9-9a52-1d121bd675af" />

#### 3. Circulation Management Panel (Issue/Return)
<img width="1600" height="804" alt="image" src="https://github.com/user-attachments/assets/3053b213-45f3-4fe5-8676-bd2f4d0855b5" />

#### 4. Books Issued List Table
<img width="1600" height="799" alt="image" src="https://github.com/user-attachments/assets/f406c1eb-81ff-4b8d-9e89-309534ddd678" />

#### 5. Interactive Inventory & Asset Data Sheet
<img width="1600" height="804" alt="image" src="https://github.com/user-attachments/assets/1f89cb4f-7022-45e6-a7e5-379c90ee8aec" />
#### LISTING IN CATALOGS 
<img width="1600" height="794" alt="image" src="https://github.com/user-attachments/assets/1ccd56a8-1304-41c4-ae62-906d3336744e" />

#### 6. Financial Ledger & Fine Tracking Panel
<img width="1600" height="797" alt="image" src="https://github.com/user-attachments/assets/af291d53-1b16-4873-8295-ed809e4aa34a" />

#### 7. Parameterized Executive Report Center
<img width="1600" height="813" alt="image" src="https://github.com/user-attachments/assets/6ed39838-69f3-4129-92aa-9218847dfd24" />


---

## 📊 Enterprise Business PDF Reports
8. PDF Reports
The reporting system supports 10 parameter-filtered business reports:

Category 1: Time-Period Ledger Reports
1. Book Issuance Audit: Tracks all library books checked out within a chosen date range, helping administrators analyze circulation volume trends. It logs specific transaction timestamps, book details, and the staff members who authorized each checkout.

2. Fine Income Statement: Summarizes the total financial revenue generated from overdue penalties over a specified time period. It details the distribution between outstanding balances and completed cash collections to help clear student financial accounts.

3. Acquisitions Audit: Provides a detailed log of all new books and reading assets purchased or added to the library system during a set timeline. It records supplier data, procurement costs, and catalog entry dates to keep inventory balances perfectly up to date.

Category 2: Target Variable Tracking Reports
4. Member Activity Summary: Generates a personalized profile of a single user's interaction history based on their specific Member ID. It isolates their current checkouts, total historical borrows, outstanding fines, and returns to track client accountability.

5. Supplier Order Profile: Extracts comprehensive transaction histories and delivery logs from a targeted vendor using their database Supplier ID. It audits vendor fulfillment rates, bulk book shipment records, and invoicing metrics to optimize procurement choices.

6. Individual Book History: Delivers an itemized lifetime circulation timeline for a specific book asset using its unique Book ID. It tracks every member who has ever borrowed that exact physical copy, helping evaluate asset wear-and-tear or identify missing items.

Category 3: System Compilation Summaries
7. Active Overdue Records: Compiles a comprehensive real-time list of all unreturned books currently past their assigned due dates across the library network. It links member contact info with daily penalty formulas to display exactly how much fine money has accumulated.

8. Top Borrowed Analytics: Analyzes and ranks high-demand reading materials by counting their total checkouts to highlight student reading trends. This report guides department heads in making budget-friendly decisions on when to order duplicate copies of popular titles.

9. Categorized Stock Audit: Evaluates the library's physical inventory by grouping existing items into distinct academic subjects, genres, or formats. It tracks the distribution of available versus borrowed stock, giving engineers a clear view of resource gaps.

10. Inactive Member List: Identifies registered students and external cardholders who have not checked out any books or used services within a prolonged timeframe. This helps the system clean out old database records or target specific profiles for library engagement.

---

G5: Smart Shelf Management System
A full-stack Library Management System built with Spring Boot & MySQL 
•	GitHub Repository: https://github.com/kanwalwasim05/RestaurantManagementSystem 
Group Members
•	Kanwal Wasim (2025-IST-10) – Backend / DB 
•	Syeda Narim Rehan (2025-IST-8) – Frontend / UI 
•	Maryam Asif (2025-IST-6) – Database / SQL 


## ⚙️ Setup & Installation

### Prerequisites
* Java Development Kit (JDK 17 or higher)
* Maven 3.8+ Build Core
* MySQL Server instance (v8.0 preferred)

### 1. Relational Database Initialization
Log into your local MySQL terminal and execute the structural schema script:
```bash
mysql -u root -p < src/main/resources/schema.sql


