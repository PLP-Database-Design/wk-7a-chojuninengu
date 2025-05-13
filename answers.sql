-- Question 1: Transforming ProductDetail table to 1NF
-- Original table violates 1NF by having multiple values in Products column
-- Solution: Create a new table with one product per row

-- First create a properly normalized table structure
CREATE TABLE NormalizedOrders (
    OrderID INT,
    CustomerName VARCHAR(100),
    Product VARCHAR(50)
);

-- Insert data split into individual product rows
INSERT INTO NormalizedOrders (OrderID, CustomerName, Product)
VALUES 
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');

-- Alternative approach if modifying existing table:
-- This would involve creating a new table and dropping the old one
-- as SQL doesn't directly support converting comma-separated values to rows

-- Question 2: Transforming OrderDetails table to 2NF
-- Original table has partial dependency (CustomerName depends only on OrderID)
-- Solution: Split into two tables - Orders and OrderItems

-- Create Orders table (contains order-level information)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

-- Create OrderItems table (contains product-level information)
CREATE TABLE OrderItems (
    OrderItemID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT,
    Product VARCHAR(50),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert data into the new normalized structure
-- First insert order information
INSERT INTO Orders (OrderID, CustomerName)
VALUES 
    (101, 'John Doe'),
    (102, 'Jane Smith'),
    (103, 'Emily Clark');

-- Then insert product information
INSERT INTO OrderItems (OrderID, Product, Quantity)
VALUES 
    (101, 'Laptop', 2),
    (101, 'Mouse', 1),
    (102, 'Tablet', 3),
    (102, 'Keyboard', 1),
    (102, 'Mouse', 2),
    (103, 'Phone', 1);
