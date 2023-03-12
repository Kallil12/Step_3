CREATE DATABASE vention_database
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

----------------------------------------------------------------------------------------

DROP TABLE users, partner_feature, orders, order_partner_line_items, order_line_items;
TRUNCATE users, partner_feature, orders, order_partner_line_items, order_line_items;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL
);

-- insert 30 random users
INSERT INTO users (email)
SELECT 'user' || generate_series(1, 30) || '@example.com'
FROM generate_series(1, 30);

----------------------------------------------------------------------------------------

-- create the partner_feature table FOREIGN KEY (order_id) REFERENCES orders(id)
CREATE TABLE partner_feature (
    id SERIAL PRIMARY KEY,
    contract_rate NUMERIC(10, 2) NOT NULL,
	FOREIGN KEY (id) REFERENCES order_partner_line_items(partner_id)
);

-- insert 30 random partner features
INSERT INTO partner_feature (contract_rate)
SELECT (random() * 100)::numeric(10,2)
FROM generate_series(1, 30);

----------------------------------------------------------------------------------------

-- create the orders table
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP NOT NULL,
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- insert 30 random orders
INSERT INTO orders (created_at, user_id)
SELECT 
    CURRENT_TIMESTAMP - INTERVAL '1 day' * (30 - generate_series(1, 30)),
    (random() * 30 + 1)::integer
FROM generate_series(1, 30);

----------------------------------------------------------------------------------------

CREATE TABLE order_line_items (
    order_id INTEGER NOT NULL,
    part_number VARCHAR(255) NOT NULL,
    item_price NUMERIC(10, 2) NOT NULL,
    item_cost NUMERIC(10, 2) NOT NULL,
    quantity INTEGER NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- insert 30 random order line items for each order
INSERT INTO order_line_items (order_id, part_number, item_price, item_cost, quantity)
SELECT 
    o.id,
    'part' || generate_series(1, 30),
    (random() * 100)::numeric(10,2),
    (random() * 50)::numeric(10,2),
    (random() * 5 + 1)::integer
FROM orders o
CROSS JOIN generate_series(1, 30);

----------------------------------------------------------------------------------------

CREATE TABLE order_partner_line_items (
    order_id INTEGER NOT NULL,
    part_number VARCHAR(255) NOT NULL,
    partner_id INTEGER NOT NULL,
    item_price NUMERIC(10, 2) NOT NULL,
    quantity INTEGER NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

----------------------------------------------------------------------------------------

ALTER TABLE order_partner_line_items
ADD CONSTRAINT constraint_name UNIQUE (column_name);