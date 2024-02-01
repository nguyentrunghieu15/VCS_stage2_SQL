-- This asignment using data of file create_db_tables_pg and load_db_tables_pg


-- Exercise 1 - Customer order count
-- Get order count per customer for the month of 2014 January.

-- Tables - orders and customers

-- Data should be sorted in descending order by count and ascending order by customer id.

-- Output should contain customer_id, customer_first_name, customer_last_name and customer_order_count.

SELECT customer_id, customer_fname as customer_first_name ,customer_lname as customer_last_name , count(*) as  customer_order_count
FROM customers JOIN orders on customers.customer_id = orders.order_customer_id
WHERE EXTRACT(YEAR FROM order_date) = 2014 and EXTRACT(MONTH FROM order_date) = 1
GROUP BY customer_id 
ORDER BY count(*) DESC , customer_id ASC;

-- Get the customer details who have not placed any order for the month of 2014 January.

-- Tables - orders and customers

-- Data should be sorted in ascending order by customer_id

-- Output should contain all the fields from customers

SELECT customers.*,order_date
FROM customers JOIN orders on customers.customer_id = orders.order_customer_id
WHERE NOT(EXTRACT(YEAR FROM order_date) = 2014 and EXTRACT(MONTH FROM order_date) = 1)
ORDER BY customer_id ASC;


-- Exercise 3 - Revenue Per Customer
-- Get the revenue generated by each customer for the month of 2014 January

-- Tables - orders, order_items and customers

-- Data should be sorted in descending order by revenue and then ascending order by customer_id

-- Output should contain customer_id, customer_first_name, customer_last_name, customer_revenue.

-- If there are no orders placed by customer, then the corresponding revenue for a give customer should be 0.

-- Consider only COMPLETE and CLOSED orders

SELECT customer_id, customer_fname as customer_first_name ,customer_lname as customer_last_name , sum(order_items.order_item_subtotal) as  customer_revenue
FROM customers JOIN orders on customers.customer_id = orders.order_customer_id
JOIN order_items on orders.order_customer_id = order_items.order_item_order_id
WHERE EXTRACT(YEAR FROM order_date) = 2014 and EXTRACT(MONTH FROM order_date) = 1 and orders.order_status in ('COMPLETE','CLOSED')
GROUP BY customer_id;

-- Exercise 4 - Revenue Per Category¶
-- Get the revenue generated for each category for the month of 2014 January

-- Tables - orders, order_items, products and categories

-- Data should be sorted in ascending order by category_id.

-- Output should contain all the fields from category along with the revenue as category_revenue.

-- Consider only COMPLETE and CLOSED orders

SELECT categories.*, sum(order_item_subtotal) as category_revenue 
FROM categories 
JOIN products on categories.category_id = products.product_category_id
JOIN order_items on order_items.order_item_product_id = products.product_id
JOIN orders on orders.order_id = order_items.order_item_order_id
WHERE EXTRACT(YEAR FROM order_date) = 2014 and EXTRACT(MONTH FROM order_date) = 1 and orders.order_status in ('COMPLETE','CLOSED')
GROUP BY category_id
ORDER BY category_id ASC;

-- Exercise 5 - Product Count Per Department
-- Get the products for each department.

-- Tables - departments, categories, products

-- Data should be sorted in ascending order by department_id

-- Output should contain all the fields from department and the product count as product_count

SELECT departments.*, sum(product_id) as product_count 
FROM departments
JOIN categories on categories.category_department_id = departments.department_id
JOIN products on categories.category_id = products.product_category_id
GROUP BY department_id
ORDER BY department_id ASC