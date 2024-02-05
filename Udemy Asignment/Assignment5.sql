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

-- Lay ra tat ca cac khoa chinh cua cac bang va gia tri lon nhat, tao sequene

DO $$
DECLARE
    table_record record;
    max_pk_value numeric;
BEGIN
    FOR table_record IN 
        SELECT table_name, column_name FROM information_schema.constraint_column_usage
		WHERE "constraint_name" IN ( SELECT conname FROM pg_catalog.pg_constraint
						WHERE contype = 'p'  and connamespace = 2200)
    LOOP
        EXECUTE format('SELECT MAX(%I) FROM %I', table_record.column_name, table_record.table_name) INTO max_pk_value;
        RAISE NOTICE 'Table: %, Max PK Value: %', table_record.table_name, max_pk_value;
		EXECUTE format('DROP SEQUENCE seq_%I_pk CASCADE; CREATE SEQUENCE  IF NOT EXISTS seq_%I_pk  START WITH %s INCREMENT BY 1 OWNED BY %s.%s' ,table_record.column_name , table_record.column_name ,max_pk_value +1 , table_record.table_name ,table_record.column_name);
		EXECUTE format('ALTER TABLE %I ALTER COLUMN %I SET DEFAULT nextval(''seq_%I_pk'');', table_record.table_name,table_record.column_name,table_record.column_name);
    END LOOP;
END $$;

-- -- Add foreignkey for table
-- orders.order_customer_id to customers.customer_id

-- order_items.order_item_order_id to orders.order_id

-- order_items.order_item_product_id to products.product_id

-- products.product_category_id to categories.category_id

-- categories.category_department_id to departments.department_id

ALTER TABLE orders
ADD CONSTRAINT IF NOT EXISTS fk_order_customer_id FOREIGN KEY (order_customer_id) REFERENCES customers(customer_id);

ALTER TABLE order_items
ADD CONSTRAINT IF NOT EXISTS fk_order_item_product_id FOREIGN KEY (order_item_product_id) REFERENCES orders(order_id);

ALTER TABLE order_items
ADD CONSTRAINT IF NOT EXISTS fk_order_item_product_id FOREIGN KEY (order_item_product_id) REFERENCES products(product_id);

ALTER TABLE products
ADD CONSTRAINT IF NOT EXISTS fk_product_category_id FOREIGN KEY (product_category_id) REFERENCES categories(category_id);

ALTER TABLE categories
ADD CONSTRAINT IF NOT EXISTS fk_category_department_id FOREIGN KEY (category_department_id) REFERENCES departments(department_id);

