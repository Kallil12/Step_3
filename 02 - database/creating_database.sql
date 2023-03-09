CREATE DATABASE vention_database
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

--------------------------------------------

-- Create the orders table
CREATE TABLE orders (
    id INTEGER PRIMARY KEY,
    created_at TIMESTAMP,
    user_id INTEGER,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Create the order_line_items table
CREATE TABLE order_line_items (
    order_id INTEGER,
    part_number TEXT,
    item_price DECIMAL(10, 2),
    item_cost DECIMAL(10, 2),
    quantity INTEGER,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- Create the order_partner_line_items table
CREATE TABLE order_partner_line_items (
    order_id INTEGER,
    part_number TEXT,
    partner_id INTEGER,
    item_price DECIMAL(10, 2),
    quantity INTEGER,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (partner_id) REFERENCES partner_feature(id)
);

-- Create the partner_feature table
CREATE TABLE partner_feature (
    id INTEGER PRIMARY KEY,
    contract_rate DECIMAL(10, 2)
);

-- Create the users table
CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    email TEXT
);
