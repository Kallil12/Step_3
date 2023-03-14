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


----------------------------------------------------------------------------------------

-- create the partner_feature table FOREIGN KEY (order_id) REFERENCES orders(id)
CREATE TABLE partner_feature (
    id SERIAL PRIMARY KEY,
    contract_rate NUMERIC(10, 2) NOT NULL,
	FOREIGN KEY (id) REFERENCES order_partner_line_items(partner_id)
);


----------------------------------------------------------------------------------------

-- create the orders table
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    created_at TIMESTAMP NOT NULL,
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id)
);


----------------------------------------------------------------------------------------

CREATE TABLE order_line_items (
    order_id INTEGER NOT NULL,
    part_number VARCHAR(255) NOT NULL,
    item_price NUMERIC(10, 2) NOT NULL,
    item_cost NUMERIC(10, 2) NOT NULL,
    quantity INTEGER NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);



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