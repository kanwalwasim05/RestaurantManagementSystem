CREATE DATABASE LibraryDB;
USE LibraryDB;

-- 1. Branch Table
CREATE TABLE Branch (
    branch_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL
);

-- 2. Staff Table
CREATE TABLE Staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_id INT,
    name VARCHAR(100) NOT NULL,
    role VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    password VARCHAR(100) NOT NULL,
    CONSTRAINT fk_staff_branch FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

-- 3. Shift Table
CREATE TABLE Shift (
    shift_id INT PRIMARY KEY AUTO_INCREMENT,
    staff_id INT,
    shift_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    CONSTRAINT fk_shift_staff FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
);

-- 4. Category Table
CREATE TABLE Category (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) UNIQUE NOT NULL
);

-- 5. Publisher Table
CREATE TABLE Publisher (
    publisher_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(200),
    phone VARCHAR(20)
);

-- 6. Author Table
CREATE TABLE Author (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    bio TEXT
);

-- 7. Book Table
CREATE TABLE Book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200) NOT NULL,
    category_id INT,
    publisher_id INT,
    isbn VARCHAR(20) UNIQUE,
    publish_year INT,
    total_copies INT DEFAULT 1,
    CONSTRAINT fk_book_cat FOREIGN KEY (category_id) REFERENCES Category(category_id),
    CONSTRAINT fk_book_pub FOREIGN KEY (publisher_id) REFERENCES Publisher(publisher_id),
    CONSTRAINT chk_copies CHECK (total_copies >= 0)
);

-- 8. Book_Author Table (Many-to-Many)
CREATE TABLE Book_Author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    CONSTRAINT fk_ba_book FOREIGN KEY (book_id) REFERENCES Book(book_id),
    CONSTRAINT fk_ba_author FOREIGN KEY (author_id) REFERENCES Author(author_id)
);

-- 9. Member Table
CREATE TABLE Member (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20) NOT NULL,
    date_of_birth DATE,
    address TEXT,
    registration_date DATE DEFAULT (CURRENT_DATE)
);

-- 10. Book_Copy Table
CREATE TABLE Book_Copy (
    copy_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    branch_id INT,
    status ENUM('Available', 'Loaned', 'Reserved', 'Lost') DEFAULT 'Available',
    CONSTRAINT fk_copy_book FOREIGN KEY (book_id) REFERENCES Book(book_id),
    CONSTRAINT fk_copy_branch FOREIGN KEY (branch_id) REFERENCES Branch(branch_id)
);

-- 11. Loan Table
CREATE TABLE Loan (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    copy_id INT,
    member_id INT,
    staff_id INT,
    loan_date DATE DEFAULT (CURRENT_DATE),
    due_date DATE NOT NULL,
    return_date DATE,
    status ENUM('Active', 'Returned', 'Overdue') DEFAULT 'Active',
    CONSTRAINT fk_loan_copy FOREIGN KEY (copy_id) REFERENCES Book_Copy(copy_id),
    CONSTRAINT fk_loan_member FOREIGN KEY (member_id) REFERENCES Member(member_id),
    CONSTRAINT fk_loan_staff FOREIGN KEY (staff_id) REFERENCES Staff(staff_id),
    CONSTRAINT chk_dates CHECK (due_date > loan_date)
);

-- 12. Reservation Table
CREATE TABLE Reservation (
    reservation_id INT PRIMARY KEY AUTO_INCREMENT,
    book_id INT,
    member_id INT,
    reservation_date DATE DEFAULT (CURRENT_DATE),
    status ENUM('Pending', 'Fulfilled', 'Cancelled') DEFAULT 'Pending',
    CONSTRAINT fk_res_book FOREIGN KEY (book_id) REFERENCES Book(book_id),
    CONSTRAINT fk_res_member FOREIGN KEY (member_id) REFERENCES Member(member_id)
);

-- 13. Fine Table
CREATE TABLE Fine (
    fine_id INT PRIMARY KEY AUTO_INCREMENT,
    loan_id INT,
    amount DECIMAL(10,2) NOT NULL,
    issued_date DATE DEFAULT (CURRENT_DATE),
    status ENUM('Unpaid', 'Paid') DEFAULT 'Unpaid',
    CONSTRAINT fk_fine_loan FOREIGN KEY (loan_id) REFERENCES Loan(loan_id),
    CONSTRAINT chk_amount CHECK (amount > 0)
);

-- 14. Payment Table
CREATE TABLE Payment (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    fine_id INT,
    amount_paid DECIMAL(10,2) NOT NULL,
    payment_date DATE DEFAULT (CURRENT_DATE),
    CONSTRAINT fk_pay_fine FOREIGN KEY (fine_id) REFERENCES Fine(fine_id)
);

-- 15. Supplier Table
CREATE TABLE Supplier (
    supplier_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(20)
);