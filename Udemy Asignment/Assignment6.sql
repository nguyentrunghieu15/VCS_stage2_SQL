-- Exercise 1
-- Create table orders_part with the same columns as orders.

-- Partition the table by month using range partitioning on order_date.

-- Add 14 partitions - 13 based up on the data and 1 default. Here is the naming convention.

-- Default - orders_part_default

-- Partition for 2014 January - orders_part_201401

CREATE TABLE IF NOT EXISTS orders_part (
  order_id INT NOT NULL,
  order_date TIMESTAMP NOT NULL,
  order_customer_id INT NOT NULL,
  order_status VARCHAR(45) NOT NULL,
  PRIMARY KEY (order_id, order_date)
) PARTITION BY RANGE(order_date);

CREATE INDEX IF NOT EXISTS orders_part_order_id_idx ON orders_part(order_id);

DO $$
BEGIN
	FOR i in 1..12  LOOP
		EXECUTE format('CREATE TABLE IF NOT EXISTS orders_part_2014%s PARTITION OF orders_part FOR VALUES FROM (TO_DATE(''2014-%s-01'',''YYYY-MM-DD'')) TO (DATE_TRUNC(''MONTH'',TO_DATE(''2014-%s-01'',''YYYY-MM-DD'')) + INTERVAL ''1 MONTH - 1 DAY'');',i,i,i);
	END LOOP;
END $$;

CREATE TABLE  IF NOT EXISTS orders_part_default PARTITION OF orders_part  DEFAULT;


-- Exercise 2
-- Let us load and validate data in the partitioned table.

-- Load the data from orders into orders_part.

-- Get count on orders_part as well as all the 14 partitions. You should get 0 for default partition and all the records should be distributed using the other 13 partitions.

INSERT INTO orders_part SELECT * FROM orders;

DO $$
DECLARE
	counter integer;

BEGIN
	FOR i in 1..12 LOOP
		EXECUTE format('SELECT count(*) FROM orders_part_2014%s',i) INTO counter;
		RAISE NOTICE 'Table orders_part_2014%s have % record',i,counter;
	END LOOP;
	EXECUTE format('SELECT count(*) FROM orders_part_default') INTO counter;
	RAISE NOTICE 'Table orders_part_default have % record',counter;
END $$;