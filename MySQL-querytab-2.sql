USE LibraryDB;

-- ---------------- VIEWS (5 Minimum) ------------------

-- 1. View for Available Books
CREATE VIEW v_AvailableBooks AS
SELECT b.book_id, b.title, c.name AS category, bc.copy_id, br.name AS branch_name
FROM Book b
JOIN Book_Copy bc ON b.book_id = bc.book_id
JOIN Category c ON b.category_id = c.category_id
JOIN Branch br ON bc.branch_id = br.branch_id
WHERE bc.status = 'Available';

-- 2. View for Member Loan History
CREATE VIEW v_MemberLoans AS
SELECT m.name AS member_name, b.title, l.loan_date, l.due_date, l.return_date, l.status
FROM Loan l
JOIN Member m ON l.member_id = m.member_id
JOIN Book_Copy bc ON l.copy_id = bc.copy_id
JOIN Book b ON bc.book_id = b.book_id;

-- 3. View for Overdue Books
DROP VIEW IF EXISTS v_OverdueBooks;

CREATE VIEW v_OverdueBooks AS
SELECT m.name, m.phone, b.title, l.due_date, CURDATE() AS todays_date
FROM Loan l
JOIN Member m ON l.member_id = m.member_id
JOIN Book_Copy bc ON l.copy_id = bc.copy_id
JOIN Book b ON bc.book_id = b.book_id
WHERE l.status = 'Active' AND l.due_date < CURDATE();

-- 4. View for Book Popularity
CREATE VIEW v_PopularBooks AS
SELECT b.title, COUNT(l.loan_id) AS times_borrowed
FROM Book b
JOIN Book_Copy bc ON b.book_id = bc.book_id
JOIN Loan l ON bc.copy_id = l.copy_id
GROUP BY b.title
ORDER BY times_borrowed DESC;

-- 5. View for Staff Shifts
CREATE VIEW v_StaffShifts AS
SELECT s.name AS staff_name, s.role, sh.shift_date, sh.start_time, sh.end_time, b.name AS branch_name
FROM Staff s
JOIN Shift sh ON s.staff_id = sh.staff_id
JOIN Branch b ON s.branch_id = b.branch_id;


-- ---------------- TRIGGERS (2 Minimum) ------------------

-- 1. Trigger: Auto-generate fine when a book is returned late
DELIMITER //
CREATE TRIGGER trg_AutoFine
AFTER UPDATE ON Loan
FOR EACH ROW
BEGIN
    IF NEW.return_date IS NOT NULL AND NEW.return_date > OLD.due_date THEN
        INSERT INTO Fine (loan_id, amount, issued_date, status)
        VALUES (NEW.loan_id, 5.00, CURDATE(), 'Unpaid'); -- $5 flat fine for simplicity
    END IF;
END //
DELIMITER ;

-- 2. Trigger: Update Book_Copy status to 'Loaned' when a new Loan is inserted
DELIMITER //
CREATE TRIGGER trg_UpdateCopyStatus
AFTER INSERT ON Loan
FOR EACH ROW
BEGIN
    UPDATE Book_Copy SET status = 'Loaned' WHERE copy_id = NEW.copy_id;
END //
DELIMITER ;


-- ---------------- STORED PROCEDURES (3 Minimum with TRANSACTIONS) ------------------

-- 1. Procedure: Issue a Book (Transaction: Insert Loan + Update Copy Status)
DELIMITER //
CREATE PROCEDURE sp_IssueBook(
    IN p_copy_id INT, 
    IN p_member_id INT, 
    IN p_staff_id INT, 
    IN p_due_date DATE
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    
    START TRANSACTION;
    INSERT INTO Loan (copy_id, member_id, staff_id, due_date, status)
    VALUES (p_copy_id, p_member_id, p_staff_id, p_due_date, 'Active');
    
    UPDATE Book_Copy SET status = 'Loaned' WHERE copy_id = p_copy_id;
    COMMIT;
END //
DELIMITER ;

-- 2. Procedure: Return a Book (Transaction: Update Loan + Update Copy Status)
DELIMITER //
CREATE PROCEDURE sp_ReturnBook(
    IN p_loan_id INT, 
    IN p_copy_id INT
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    
    START TRANSACTION;
    UPDATE Loan SET return_date = CURDATE(), status = 'Returned' WHERE loan_id = p_loan_id;
    UPDATE Book_Copy SET status = 'Available' WHERE copy_id = p_copy_id;
    COMMIT;
END //
DELIMITER ;

-- 3. Procedure: Pay Fine (Transaction: Insert Payment + Update Fine Status)
DELIMITER //
CREATE PROCEDURE sp_PayFine(
    IN p_fine_id INT, 
    IN p_amount_paid DECIMAL(10,2)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    
    START TRANSACTION;
    INSERT INTO Payment (fine_id, amount_paid, payment_date)
    VALUES (p_fine_id, p_amount_paid, CURDATE());
    
    UPDATE Fine SET status = 'Paid' WHERE fine_id = p_fine_id;
    COMMIT;
END //
DELIMITER ;