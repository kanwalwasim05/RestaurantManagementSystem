USE LibraryDB;

-- 1. Insert Categories (So books can be added)
INSERT INTO Category (name) VALUES ('Fiction');
INSERT INTO Category (name) VALUES ('Non-Fiction');
INSERT INTO Category (name) VALUES ('Science');
INSERT INTO Category (name) VALUES ('History');

-- 2. Insert a Publisher (Books need a publisher)
INSERT INTO Publisher (name, address, phone) VALUES ('Penguin Books', 'New York', '1234567890');

-- 3. Insert a Branch
INSERT INTO Branch (name, address) VALUES ('Main Branch', 'Lahore');

-- 4. Insert a Staff Member (To issue/return books)
INSERT INTO Staff (branch_id, name, role, email, password) VALUES (1, 'Ali Khan', 'Librarian', 'ali@library.com', 'password123');

-- 5. Insert a Member (To borrow books)
INSERT INTO Member (name, email, phone, date_of_birth, address) VALUES ('Ahmed', 'ahmed@gmail.com', '03001234567', '2000-01-01', 'UET Lahore');

-- 6. Insert a Book (Using the IDs from above)
INSERT INTO Book (title, category_id, publisher_id, isbn, publish_year, total_copies) 
VALUES ('The Alchemist', 1, 1, '9780062315007', 1988, 5);

