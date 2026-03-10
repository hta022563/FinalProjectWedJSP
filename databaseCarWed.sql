USE master;
GO

-- ==============================================================================
-- 1. KHỞI TẠO DATABASE (Xóa DB cũ nếu đã tồn tại để làm lại từ đầu)
-- ==============================================================================
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'CarStore_FinalWeb')
BEGIN
    ALTER DATABASE CarStore_FinalWeb SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE CarStore_FinalWeb;
END
GO

CREATE DATABASE CarStore_FinalWeb;
GO

USE CarStore_FinalWeb;
GO

-- ==============================================================================
-- 2. TẠO CẤU TRÚC BẢNG (TABLES)
-- ==============================================================================
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(255) NOT NULL,
    IsActive INT DEFAULT 1 
);

CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY IDENTITY(1,1),
    SupplierName NVARCHAR(255) NOT NULL,
    Phone VARCHAR(20),
    Address NVARCHAR(500),
    IsActive INT DEFAULT 1 
);

CREATE TABLE PaymentMethod (
    MethodID INT PRIMARY KEY IDENTITY(1,1),
    MethodName NVARCHAR(100) NOT NULL,
    IsActive INT DEFAULT 1 
);

CREATE TABLE Promotion (
    PromotionID INT PRIMARY KEY IDENTITY(1,1),
    PromoCode VARCHAR(50) NOT NULL,
    DiscountPercent INT,
    StartDate DATETIME,
    EndDate DATETIME,
    IsActive INT DEFAULT 1 
);

CREATE TABLE Showroom (
    ShowroomID INT PRIMARY KEY IDENTITY(1,1),
    ShowroomName NVARCHAR(255) NOT NULL,
    Address NVARCHAR(500),
    Hotline VARCHAR(20),
    IsActive INT DEFAULT 1 
);

CREATE TABLE [User] (
    UserID INT PRIMARY KEY IDENTITY(1,1),
    Username VARCHAR(100) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    FullName NVARCHAR(255),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Role INT -- 1: Admin, 0: Customer
);

CREATE TABLE Product (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    CategoryID INT FOREIGN KEY REFERENCES Category(CategoryID),
    SupplierID INT FOREIGN KEY REFERENCES Supplier(SupplierID),
    ProductName NVARCHAR(255) NOT NULL,
    Price DECIMAL(18,2),
    StockQuantity INT,
    Description NVARCHAR(MAX),
    ImageURL VARCHAR(500),
    [Status] BIT DEFAULT 1 -- 1: Đang bán (True), 0: Đã ẩn (False)
);

CREATE TABLE Cart (
    CartID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES [User](UserID)
);

CREATE TABLE CartItem (
    CartItemID INT PRIMARY KEY IDENTITY(1,1),
    CartID INT FOREIGN KEY REFERENCES Cart(CartID),
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
    Quantity INT
);

CREATE TABLE [Order] (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES [User](UserID),
    MethodID INT FOREIGN KEY REFERENCES PaymentMethod(MethodID),
    PromotionID INT FOREIGN KEY REFERENCES Promotion(PromotionID),
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(18,2),
    Status NVARCHAR(50),
    ShippingAddress NVARCHAR(500)
);

CREATE TABLE OrderDetail (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT FOREIGN KEY REFERENCES [Order](OrderID),
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
    Quantity INT,
    UnitPrice DECIMAL(18,2)
);

CREATE TABLE Review (
    ReviewID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT FOREIGN KEY REFERENCES [User](UserID),
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID),
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment NVARCHAR(MAX),
    ReviewDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE News (
    NewsID INT PRIMARY KEY IDENTITY(1,1),
    Title NVARCHAR(500),
    Content NVARCHAR(MAX),
    Thumbnail VARCHAR(500),
    PublishDate DATETIME DEFAULT GETDATE(),
    ExternalLink NVARCHAR(MAX)
);

CREATE TABLE SearchHistory (
    SearchID INT PRIMARY KEY IDENTITY(1,1),
    Keyword NVARCHAR(255),
    SearchCount INT DEFAULT 1
);

CREATE TABLE Activity_Logs (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    log_type VARCHAR(50) NOT NULL,        
    title NVARCHAR(255) NOT NULL,         
    created_by NVARCHAR(100),             
    created_at DATETIME DEFAULT GETDATE(), 
    reference_code VARCHAR(50),           
    amount DECIMAL(18, 2) NULL            
);
GO