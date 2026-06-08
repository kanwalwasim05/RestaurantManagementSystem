USE LibraryDB;

UPDATE book_copy SET status = 'Loaned' WHERE copy_id IN (2, 3);

INSERT INTO book_copy (book_id, branch_id, status)
VALUES (4, 1, 'Loaned');

INSERT INTO member (name, email, phone, date_of_birth, address)
VALUES 
('Sara Malik', 'sara@uet.edu.pk',  '0301-2222222', '2001-03-20', 'Lahore'),
('Usman Ali',  'usman@uet.edu.pk', '0302-3333333', '1999-08-10', 'Lahore');
SELECT * FROM member;
USE LibraryDB;
SELECT * FROM book_copy;
USE LibraryDB;

-- Insert the 3 overdue loans using direct copy_id numbers (no subquery)
INSERT INTO loan (copy_id, member_id, staff_id, loan_date, due_date, return_date, status)
VALUES 
(2, 1, 1, '2026-04-01', '2026-04-15', NULL, 'Overdue'),
(3, 2, 1, '2026-04-10', '2026-04-25', NULL, 'Overdue'),
(4, 3, 1, '2026-05-01', '2026-05-10', NULL, 'Overdue');
SELECT * FROM book_copy;

USE LibraryDB;
SELECT loan_id, copy_id, member_id, status FROM loan;
USE LibraryDB;

INSERT INTO fine (loan_id, amount, status)
VALUES 
(9,  365.00, 'Unpaid'),
(10, 210.00, 'Unpaid'),
(11, 140.00, 'Unpaid');

SELECT m.name, m.phone, b.title, l.due_date
FROM loan l
JOIN member m ON l.member_id = m.member_id
JOIN book_copy bc ON l.copy_id = bc.copy_id
JOIN book b ON bc.book_id = b.book_id
WHERE l.status = 'Overdue';