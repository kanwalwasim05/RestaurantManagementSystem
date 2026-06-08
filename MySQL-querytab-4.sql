USE LibraryDB;

-- This automatically finds the correct book_id for 'The Alchemist' and inserts a copy!
INSERT INTO Book_Copy (book_id, branch_id, status) 
VALUES (
    (SELECT book_id FROM Book WHERE isbn = '9780062315007'), 
    1, 
    'Available'
);

-- Let's also add a copy for the 'Harry Potter' book you tried to add earlier!
INSERT INTO Book_Copy (book_id, branch_id, status) 
VALUES (
    (SELECT book_id FROM Book WHERE isbn = '1234567890'), 
    1, 
    'Available'
);

-- First make sure you have a member, a book copy, and a loan with a past due date
-- Check your existing data first:
USE LibraryDB;

SELECT * FROM member LIMIT 5;
SELECT * FROM book LIMIT 5;
SELECT * FROM book_copy LIMIT 5;
SELECT * FROM branch LIMIT 5;
SELECT * FROM staff LIMIT 5;
SELECT * FROM loan LIMIT 5;

DESCRIBE member;
DESCRIBE book;
DESCRIBE book_copy;
DESCRIBE loan;
DESCRIBE fine;