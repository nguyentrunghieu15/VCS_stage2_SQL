-- you need to perform to take care of this exercise.

-- Create tables

-- Load data

-- All the tables have surrogate primary keys. Here are the details.

-- orders.order_id

-- order_items.order_item_id

-- customers.customer_id

-- products.product_id

-- categories.category_id

-- departments.department_id

-- Get the maximum value from all surrogate primary key fields.

-- Create sequences for all surrogate primary key fields using maximum value. Make sure to use standard naming conventions for sequences.

-- Ensure sequences are mapped to the surrogate primary key fields.

-- Create foreign key constraints based up on this information.

-- orders.order_customer_id to customers.customer_id

-- order_items.order_item_order_id to orders.order_id

-- order_items.order_item_product_id to products.product_id

-- products.product_category_id to categories.category_id

-- categories.category_department_id to departments.department_id

-- Insert few records in departments to ensure that sequence generated numbers are used for department_id.

-- Here are the sample commands to launch psql and run scripts to create tables as well as load data into tables.

-- psql -U itversity_retail_user \
--   -h localhost \
--   -p 5432 \
--   -d itversity_retail_db \
--   -W
 
-- \i /data/retail_db/create_db_tables_pg.sql
 
-- \i /data/retail_db/load_db_tables_pg.sql
-- We use this approach of creating tables, loading data and then adding constraints as well as resetting sequences for large volume data migrations from one database to another database.

-- Here are the exercises for which you need to come up with commands or queries.


-- CREATE SEQUENCE seq_pk_categories START WITH 1 INCREMENT BY 1;
SELECT * FROM pg_catalog.pg_sequence;

ALTER SEQUENCE seq_pk_categories RESTART WITH 59;

-- ALTER TABLE categories
--     ALTER COLUMN category_id SET DEFAULT nextval('seq_pk_categories');



INSERT INTO categories(category_department_id,category_name) VALUES (2,'Football')