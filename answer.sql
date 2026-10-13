-- Week 4 Database Assignment — DRAFT
-- Based on the visible lesson titles: Aggregations and Grouping Logic, Handling NULL Value.
-- The Academy assignment page is locked, so compare these examples with the exact questions before using them.

USE sales;

-- Aggregate order counts by order status.
SELECT status, COUNT(*) AS order_count
FROM orders
GROUP BY status
ORDER BY order_count DESC;

-- Calculate each customer's order count and total sales value.
-- LEFT JOIN keeps customers who have no orders; COALESCE displays zero instead of NULL.
SELECT
    c.customerNumber,
    c.customerName,
    COUNT(DISTINCT o.orderNumber) AS order_count,
    COALESCE(SUM(od.quantityOrdered * od.priceEach), 0) AS total_sales
FROM customers AS c
LEFT JOIN orders AS o
    ON o.customerNumber = c.customerNumber
LEFT JOIN orderdetails AS od
    ON od.orderNumber = o.orderNumber
GROUP BY c.customerNumber, c.customerName
HAVING COALESCE(SUM(od.quantityOrdered * od.priceEach), 0) > 0
ORDER BY total_sales DESC;

-- Replace missing phone values with a readable label.
SELECT
    customerNumber,
    customerName,
    COALESCE(phone, 'Not provided') AS phone
FROM customers;

-- Example of filtering for missing values directly.
SELECT customerNumber, customerName
FROM customers
WHERE phone IS NULL;
