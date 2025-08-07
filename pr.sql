-- 1. Total number of employees
SELECT COUNT(*) FROM employees;

-- 2. Average salary of all employees
SELECT AVG(salary) FROM employees;

-- 3. Maximum salary in the company
SELECT MAX(salary) FROM employees;

-- 4. Employees with salary > 100000
SELECT * FROM employees WHERE salary > 100000;

-- 5. Employees who joined after 2022
SELECT * FROM employees WHERE join_date > '2022-01-01';

-- 6. Count of employees by department
SELECT department, COUNT(*) FROM employees GROUP BY department;

-- 7. Average salary by department
SELECT department, AVG(salary) FROM employees GROUP BY department;

-- 8. Products costing more than 200
SELECT * FROM products WHERE price > 200;

-- 9. Products in the 'Electronics' category
SELECT * FROM products WHERE category = 'Electronics';

-- 10. Top 5 most expensive products
SELECT * FROM products ORDER BY price DESC LIMIT 5;

-- 11. Products never sold
SELECT * FROM products WHERE id NOT IN (SELECT DISTINCT product_id FROM sales);

-- 12. Total number of sales
SELECT COUNT(*) FROM sales;

-- 13. Total quantity sold for each product
SELECT product_id, SUM(quantity) FROM sales GROUP BY product_id;

-- 14. Total revenue per product
SELECT product_id, SUM(quantity * price) AS revenue
FROM sales JOIN products ON sales.product_id = products.id
GROUP BY product_id;

-- 15. Total revenue generated
SELECT SUM(quantity * price) AS total_revenue
FROM sales JOIN products ON sales.product_id = products.id;

-- 16. Average quantity per sale
SELECT AVG(quantity) FROM sales;

-- 17. Number of sales per employee
SELECT employee_id, COUNT(*) FROM sales GROUP BY employee_id;

-- 18. Total items sold by each employee
SELECT employee_id, SUM(quantity) FROM sales GROUP BY employee_id;

-- 19. Employees who made more than 10 sales
SELECT employee_id, COUNT(*) AS num_sales
FROM sales GROUP BY employee_id HAVING num_sales > 10;

-- 20. Most recent sale
SELECT * FROM sales ORDER BY sale_date DESC LIMIT 1;

-- 21. Oldest sale
SELECT * FROM sales ORDER BY sale_date ASC LIMIT 1;

-- 22. Number of sales in 2023
SELECT COUNT(*) FROM sales WHERE sale_date LIKE '2023-%';

-- 23. Monthly sales count
SELECT strftime('%Y-%m', sale_date) AS month, COUNT(*) 
FROM sales GROUP BY month;

-- 24. Day of week sales distribution
SELECT strftime('%w', sale_date) AS weekday, COUNT(*) 
FROM sales GROUP BY weekday;

-- 25. Employees who sold products from all categories
SELECT employee_id
FROM sales s JOIN products p ON s.product_id = p.id
GROUP BY employee_id
HAVING COUNT(DISTINCT p.category) = (SELECT COUNT(DISTINCT category) FROM products);

-- 26. Most sold product by quantity
SELECT product_id, SUM(quantity) AS total_qty
FROM sales GROUP BY product_id ORDER BY total_qty DESC LIMIT 1;

-- 27. Product with highest revenue
SELECT p.name, SUM(s.quantity * p.price) AS revenue
FROM sales s JOIN products p ON s.product_id = p.id
GROUP BY p.id ORDER BY revenue DESC LIMIT 1;

-- 28. Average price of products by category
SELECT category, AVG(price) FROM products GROUP BY category;

-- 29. Number of products in each category
SELECT category, COUNT(*) FROM products GROUP BY category;

-- 30. Products with price above category average
SELECT * FROM products
WHERE price > (SELECT AVG(price) FROM products WHERE category = products.category);

-- 31. Top 3 departments by sales count
SELECT e.department, COUNT(*) AS sale_count
FROM sales s JOIN employees e ON s.employee_id = e.id
GROUP BY e.department ORDER BY sale_count DESC LIMIT 3;

-- 32. Top 3 employees by revenue generated
SELECT e.name, SUM(s.quantity * p.price) AS total_revenue
FROM sales s
JOIN employees e ON s.employee_id = e.id
JOIN products p ON s.product_id = p.id
GROUP BY e.id ORDER BY total_revenue DESC LIMIT 3;

-- 33. Average revenue per day
SELECT sale_date, SUM(quantity * price) AS revenue
FROM sales JOIN products ON sales.product_id = products.id
GROUP BY sale_date;

-- 34. Employees who sold more than 3 different products
SELECT employee_id, COUNT(DISTINCT product_id) AS unique_products
FROM sales GROUP BY employee_id HAVING unique_products > 3;

-- 35. Sales with quantity > 3
SELECT * FROM sales WHERE quantity > 3;

-- 36. Employees whose names start with 'S'
SELECT * FROM employees WHERE name LIKE 'S%';

-- 37. Products with names shorter than 6 letters
SELECT * FROM products WHERE LENGTH(name) < 6;

-- 38. Total quantity sold per category
SELECT p.category, SUM(s.quantity)
FROM sales s JOIN products p ON s.product_id = p.id
GROUP BY p.category;

-- 39. Department with highest average salary
SELECT department, AVG(salary) AS avg_salary
FROM employees GROUP BY department ORDER BY avg_salary DESC LIMIT 1;

-- 40. Top 5 products by number of transactions
SELECT product_id, COUNT(*) AS txns
FROM sales GROUP BY product_id ORDER BY txns DESC LIMIT 5;

-- 41. Employees who joined before 2020 and are still active
SELECT * FROM employees WHERE join_date < '2020-01-01';

-- 42. Total revenue generated per department
SELECT e.department, SUM(s.quantity * p.price) AS dept_revenue
FROM sales s
JOIN employees e ON s.employee_id = e.id
JOIN products p ON s.product_id = p.id
GROUP BY e.department;

-- 43. Sales made in the last 30 days
SELECT * FROM sales WHERE sale_date >= date('now', '-30 day');

-- 44. Average sales per employee
SELECT AVG(sale_count) FROM (
  SELECT employee_id, COUNT(*) AS sale_count FROM sales GROUP BY employee_id
);

-- 45. Products sold in at least 5 different months
SELECT product_id
FROM sales
GROUP BY product_id
HAVING COUNT(DISTINCT strftime('%Y-%m', sale_date)) >= 5;

-- 46. Employees with no sales
SELECT * FROM employees
WHERE id NOT IN (SELECT DISTINCT employee_id FROM sales);

-- 47. Departments with fewer than 10 employees
SELECT department FROM employees
GROUP BY department HAVING COUNT(*) < 10;

-- 48. Employees who sold products priced over $300
SELECT DISTINCT e.name
FROM sales s
JOIN employees e ON s.employee_id = e.id
JOIN products p ON s.product_id = p.id
WHERE p.price > 300;

-- 49. Products sold by only one employee
SELECT product_id FROM sales
GROUP BY product_id HAVING COUNT(DISTINCT employee_id) = 1;

-- 50. Average quantity sold per employee per product
SELECT employee_id, product_id, AVG(quantity) AS avg_qty
FROM sales GROUP BY employee_id, product_id;
