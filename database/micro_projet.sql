CREATE DATABASE e_commerce;
USE e_commerce;

-- Dropping existing tables if they exist
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS suppliers;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS addresses;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS audit_logs;

-- Creating Customers table
CREATE TABLE customers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(30) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    date_of_birth DATE,
    phone VARCHAR(15)
);

-- Creating Suppliers table
CREATE TABLE suppliers(
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    contact_name VARCHAR(30),
    email VARCHAR(50) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    phone VARCHAR(15)
);

-- Creating Categories table
CREATE TABLE categories(
    id INT AUTO_INCREMENT PRIMARY KEY,
    label VARCHAR(50) NOT NULL
);

-- Creating Products table
CREATE TABLE products(
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(50) NOT NULL,
    price DECIMAL(12, 2) NOT NULL,
    stock INT NOT NULL,
    category_id INT NOT NULL,
    supplier_id INT NOT NULL,
    description TEXT,
    photo VARCHAR(200),
    status VARCHAR(15) DEFAULT 'active',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY(category_id) REFERENCES categories(id) ON DELETE CASCADE,
    FOREIGN KEY(supplier_id) REFERENCES suppliers(id) ON DELETE CASCADE
);

-- Creating Orders table
CREATE TABLE orders(
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(15) DEFAULT 'pending',
    total_amount DECIMAL(12, 2),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY(customer_id) REFERENCES customers(id)
);

-- Creating Order_Items table
CREATE TABLE order_items(
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY(order_id, product_id),
    FOREIGN KEY(order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY(product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- Creating Addresses table
CREATE TABLE addresses(
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    address VARCHAR(100),
    postal_code VARCHAR(10),
    city VARCHAR(30),
    phone VARCHAR(15),
    address_type VARCHAR(15),
    FOREIGN KEY(customer_id) REFERENCES customers(id)
);

-- Creating Payments table
CREATE TABLE payments(
    id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    amount DECIMAL(12, 2),
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    payment_method VARCHAR(30),
    status VARCHAR(15),
    FOREIGN KEY(order_id) REFERENCES orders(id)
);

-- Creating Audit_Logs table
CREATE TABLE audit_logs(
    id INT AUTO_INCREMENT PRIMARY KEY,
    table_name VARCHAR(30),
    operation VARCHAR(10),
    operation_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INT,
    description TEXT
);
-- Inserting sample data into the 'customers' table
INSERT INTO customers (first_name, last_name, email, password, date_of_birth, phone)
VALUES 
('Alice', 'Smith', 'alice.smith@example.com', 'password123', '1990-01-15', '555-0101'),
('Bob', 'Johnson', 'bob.johnson@example.com', 'password456', '1985-05-20', '555-0102');

-- Inserting sample data into the 'suppliers' table
INSERT INTO suppliers (name, contact_name, email, phone)
VALUES 
('Cake Supplies Co', 'John Doe', 'johndoe@cakesupplies.com', '555-0201'),
('Baking Goods Ltd', 'Emily White', 'emilywhite@bakinggoods.com', '555-0202');

-- Inserting sample data into the 'categories' table
INSERT INTO categories (label)
VALUES 
('Cupcakes'),
('Birthday Cakes'),
('Wedding Cakes');

-- Inserting sample data into the 'products' table
INSERT INTO products (title, price, stock, category_id, supplier_id, description)
VALUES 
('Chocolate Cupcake', 2.50, 100, 1, 1, 'Delicious chocolate cupcake with creamy frosting'),
('Vanilla Birthday Cake', 20.00, 20, 2, 2, 'Classic vanilla cake, perfect for birthdays'),
('Elegant Wedding Cake', 150.00, 5, 3, 1, 'Three-tier wedding cake with elegant design');

-- Inserting sample data into the 'orders' table
INSERT INTO orders (customer_id, total_amount)
VALUES 
(1, 25.00),
(2, 150.00);

-- Inserting sample data into the 'order_items' table
INSERT INTO order_items (order_id, product_id, quantity)
VALUES 
(1, 1, 10), -- 10 Chocolate Cupcakes for Alice
(2, 3, 1); -- 1 Wedding Cake for Bob
