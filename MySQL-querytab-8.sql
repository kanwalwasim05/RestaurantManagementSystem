-- Make sure you are using your library database (replace 'library_db' with your actual database name if different)
USE libraryDB;

-- 1. View configuration for popular books summary (Requirement #10 - View 1)
CREATE OR REPLACE VIEW v_popular_books_summary AS 
SELECT b.book_id, b.title, COUNT(l.loan_id) AS total_rentals 
FROM book b
LEFT JOIN Book_Copy bc ON b.book_id = bc.book_id
LEFT JOIN loan l ON bc.copy_id = l.copy_id
GROUP BY b.book_id, b.title
ORDER BY total_rentals DESC 
LIMIT 10;

-- 2. View configuration for stock audit by category (Requirement #10 - View 2)
CREATE OR REPLACE VIEW v_categorized_stock_audit AS
SELECT category_id, COUNT(book_id) AS total_distinct_titles, SUM(total_copies) AS total_physical_stock
FROM book
GROUP BY category_id;

-- 3. View configuration for inactive library accounts (Requirement #10 - View 3)
CREATE OR REPLACE VIEW v_inactive_users_list AS
SELECT member_id, name, phone 
FROM member 
WHERE member_id NOT IN (SELECT DISTINCT member_id FROM loan);