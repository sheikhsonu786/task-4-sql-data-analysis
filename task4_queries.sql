-- QUERY 1: Show 10 sample orders from the orders table
SELECT * FROM orders
LIMIT 10;

-- QUERY 2: Count of orders by order status
SELECT order_status, COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

-- QUERY 3: Calculate total payment (revenue) collected
SELECT SUM(payment_value) AS total_revenue
FROM order_payments;

-- QUERY 4: Count of payment types used by customers
SELECT payment_type, COUNT(*) AS total
FROM order_payments
GROUP BY payment_type
ORDER BY total DESC;

-- QUERY 5: Join orders with customers to see location-wise orders
SELECT o.order_id, c.customer_city, c.customer_state, o.order_status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
LIMIT 10;

-- QUERY 6: Top 5 product categories by total sales
SELECT p.product_category_name, SUM(oi.price) AS total_sales
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_sales DESC
LIMIT 5;

-- QUERY 7: Top 5 sellers by total freight (delivery) charges
SELECT seller_id, SUM(freight_value) AS total_freight
FROM order_items
GROUP BY seller_id
ORDER BY total_freight DESC
LIMIT 5;

-- QUERY 8: Monthly order trend using order_purchase_timestamp
SELECT DATE_TRUNC('month', order_purchase_timestamp) AS month,
       COUNT(*) AS total_orders
FROM orders
GROUP BY month
ORDER BY month;

-- QUERY 9: Create a view for total payment by payment type
CREATE VIEW payment_summary AS
SELECT payment_type, SUM(payment_value) AS total_paid
FROM order_payments
GROUP BY payment_type;

-- QUERY 10: Find the top product category with highest sales (using subquery)
SELECT product_category_name, total_sales
FROM (
    SELECT p.product_category_name, SUM(oi.price) AS total_sales
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    GROUP BY p.product_category_name
) AS sales
ORDER BY total_sales DESC
LIMIT 1;
