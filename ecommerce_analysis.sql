-- Creating Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(255),
    Email VARCHAR(255) UNIQUE,
    Location VARCHAR(255),
    SignupDate DATE
);

-- Creating Products Table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255),
    Category VARCHAR(255),
    Price DECIMAL(10,2),
    StockQuantity INT
);

-- Creating Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Creating Transactions Table
CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    OrderID INT,
    PaymentMethod VARCHAR(255),
    PaymentStatus VARCHAR(50),
    Amount DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Query to Calculate Total Sales
SELECT SUM(Amount) AS TotalSales FROM Transactions WHERE PaymentStatus = 'Completed';

-- Query to Calculate Average Order Value
SELECT AVG(TotalAmount) AS AverageOrderValue FROM Orders;

-- Query to Calculate Customer Lifetime Value (CLV)
SELECT CustomerID, SUM(TotalAmount) AS CustomerLifetimeValue 
FROM Orders 
GROUP BY CustomerID
ORDER BY CustomerLifetimeValue DESC;

-- Query to Identify Best-Selling Products
SELECT p.ProductName, SUM(o.TotalAmount) AS TotalRevenue
FROM Orders o
JOIN Products p ON o.OrderID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalRevenue DESC
LIMIT 10;

-- Query to Analyze Sales Trends Over Time
SELECT OrderDate, SUM(TotalAmount) AS DailySales
FROM Orders
GROUP BY OrderDate
ORDER BY OrderDate;
