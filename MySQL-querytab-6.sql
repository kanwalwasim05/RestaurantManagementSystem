USE LibraryDB;

CREATE OR REPLACE VIEW v_OverdueBooks AS
SELECT 
    m.name        AS name,
    m.phone       AS phone,
    b.title       AS title,
    l.due_date    AS due_date
FROM loan l
JOIN member m    ON l.member_id = m.member_id
JOIN book_copy bc ON l.copy_id  = bc.copy_id
JOIN book b      ON bc.book_id  = b.book_id
WHERE l.status = 'Overdue';

SELECT * FROM v_OverdueBooks;

USE LibraryDB;
SELECT * FROM book_copy;
SELECT * FROM member;


USE LibraryDB;

-- 4 new members
INSERT INTO member (name, email, phone, date_of_birth, address)
VALUES 
('Fatima Zahra',  'fatima@uet.edu.pk',  '0311-4444444', '2002-01-15', 'Lahore'),
('Hassan Raza',   'hassan@uet.edu.pk',  '0312-5555555', '2000-07-22', 'Lahore'),
('Ayesha Tariq',  'ayesha@uet.edu.pk',  '0313-6666666', '2001-11-30', 'Lahore'),
('Bilal Mahmood', 'bilal@uet.edu.pk',   '0314-7777777', '1999-04-18', 'Lahore');

-- 4 new book copies using existing books (book_id 3 and 4)
INSERT INTO book_copy (book_id, branch_id, status)
VALUES 
(3, 1, 'Loaned'),
(4, 1, 'Loaned'),
(3, 1, 'Loaned'),
(4, 1, 'Loaned');

-- Check the new copy_ids and member_ids
SELECT copy_id, book_id FROM book_copy ORDER BY copy_id DESC LIMIT 4;
SELECT member_id, name FROM member ORDER BY member_id DESC LIMIT 4;


USE LibraryDB;

-- Insert 4 overdue loans with exact IDs
INSERT INTO loan (copy_id, member_id, staff_id, loan_date, due_date, return_date, status)
VALUES 
(5, 4, 1, '2026-03-01', '2026-03-15', NULL, 'Overdue'),
(6, 5, 1, '2026-03-10', '2026-03-25', NULL, 'Overdue'),
(7, 6, 1, '2026-04-01', '2026-04-10', NULL, 'Overdue'),
(8, 7, 1, '2026-04-15', '2026-04-30', NULL, 'Overdue');

-- Check what loan_ids were assigned
SELECT loan_id, copy_id, member_id, status FROM loan ORDER BY loan_id DESC LIMIT 4;

USE LibraryDB;

INSERT INTO fine (loan_id, amount, status)
VALUES 
(12, 420.00, 'Unpaid'),
(13, 280.00, 'Unpaid'),
(14, 490.00, 'Unpaid'),
(15, 210.00, 'Unpaid');

-- Verify final result
SELECT * FROM v_OverdueBooks;

USE LibraryDB;

CREATE OR REPLACE VIEW v_MemberLoans AS
SELECT 
    l.loan_id,
    m.member_id,
    m.name        AS member_name,
    b.title       AS book_title,
    bc.copy_id,
    s.name        AS staff_name,
    l.loan_date,
    l.due_date,
    l.return_date,
    l.status
FROM loan l
JOIN member    m  ON l.member_id = m.member_id
JOIN book_copy bc ON l.copy_id   = bc.copy_id
JOIN book      b  ON bc.book_id  = b.book_id
JOIN staff     s  ON l.staff_id  = s.staff_id;

USE LibraryDB;

-- ══════════════════════════════════════════════════════════════
-- UPDATE existing loans to show variety
-- ══════════════════════════════════════════════════════════════

-- Some loans stay Overdue (no changes needed)

-- Change some to Active (future due dates, not yet returned)
UPDATE loan SET status='Active', due_date='2026-06-20', return_date=NULL 
WHERE loan_id=12;

UPDATE loan SET status='Active', due_date='2026-06-25', return_date=NULL 
WHERE loan_id=13;

-- ══════════════════════════════════════════════════════════════
-- ADD NEW RETURNED LOANS (books that were issued and then returned)
-- ══════════════════════════════════════════════════════════════

-- First add 3 more book copies (if you have books available)
INSERT INTO book_copy (book_id, branch_id, status)
VALUES 
(3, 1, 'Available'),
(4, 1, 'Available'),
(3, 1, 'Available');

-- Get the new copy_ids (they will be 9, 10, 11 likely)
SELECT copy_id, book_id FROM book_copy ORDER BY copy_id DESC LIMIT 5;

-- INSERT returned loans (books that were borrowed and returned)
INSERT INTO loan (copy_id, member_id, staff_id, loan_date, due_date, return_date, status)
VALUES 
(9,  1, 1, '2026-02-01', '2026-02-15', '2026-02-14', 'Returned'),
(10, 2, 1, '2026-02-10', '2026-02-25', '2026-02-24', 'Returned'),
(11, 3, 1, '2026-03-01', '2026-03-15', '2026-03-10', 'Returned');

-- Verify all three statuses now exist
SELECT loan_id, status, due_date, return_date FROM loan ORDER BY loan_id DESC LIMIT 8;