USE master;
<<<<<<< Updated upstream
GO
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'CarStoreDB_Finalweb')
    DROP DATABASE CarStore_FinalWeb;
GO
CREATE DATABASE CarStore_FinalWeb;
GO
USE CarStore_FinalWeb;
GO

-- 2. TẠO LOGIN VÀ USER (Cho Java Web kết nối)
-- Lưu ý: Nếu Duy dùng tài khoản 'sa' thì bỏ qua bước này. 
-- Nhưng làm chuyên nghiệp thì nên tạo User riêng.
=======
GO

-- Đã fix lỗi sai tên ở dòng DROP DATABASE
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'CarStore_FinalWeb')
    DROP DATABASE CarStore_FinalWeb;
GO

CREATE DATABASE CarStore_FinalWeb;
GO
USE CarStore_FinalWeb;
GO

-- 2. TẠO LOGIN VÀ USER
>>>>>>> Stashed changes
IF NOT EXISTS (SELECT * FROM sys.server_principals WHERE name = 'car_admin')
BEGIN
    CREATE LOGIN car_admin WITH PASSWORD = 'Password123', CHECK_POLICY = OFF;
END
GO
CREATE USER car_admin FOR LOGIN car_admin;
EXEC sp_addrolemember 'db_owner', 'car_admin';
GO

<<<<<<< Updated upstream
-- 3. TẠO CÁC BẢNG (TABLES)
-- (Phần này Duy đã có, mình chạy lại để đảm bảo thứ tự khóa ngoại)

CREATE TABLE Category (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(255) NOT NULL
=======
-- 3. TẠO CÁC BẢNG (TABLES) - SỬ DỤNG IsActive

CREATE TABLE Category (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(255) NOT NULL,
    IsActive INT DEFAULT 1 -- 1: Đang hoạt động, 0: Đã ẩn
>>>>>>> Stashed changes
);

CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY IDENTITY(1,1),
    SupplierName NVARCHAR(255) NOT NULL,
    Phone VARCHAR(20),
<<<<<<< Updated upstream
    Address NVARCHAR(500)
=======
    Address NVARCHAR(500),
    IsActive INT DEFAULT 1 -- 1: Đang hợp tác, 0: Ngừng hợp tác
>>>>>>> Stashed changes
);

CREATE TABLE PaymentMethod (
    MethodID INT PRIMARY KEY IDENTITY(1,1),
<<<<<<< Updated upstream
    MethodName NVARCHAR(100) NOT NULL
=======
    MethodName NVARCHAR(100) NOT NULL,
    IsActive INT DEFAULT 1 -- 1: Khả dụng, 0: Tạm khóa
>>>>>>> Stashed changes
);

CREATE TABLE Promotion (
    PromotionID INT PRIMARY KEY IDENTITY(1,1),
    PromoCode VARCHAR(50) NOT NULL,
    DiscountPercent INT,
    StartDate DATETIME,
<<<<<<< Updated upstream
    EndDate DATETIME
=======
    EndDate DATETIME,
    IsActive INT DEFAULT 1 -- 1: Kích hoạt, 0: Vô hiệu hóa
>>>>>>> Stashed changes
);

CREATE TABLE Showroom (
    ShowroomID INT PRIMARY KEY IDENTITY(1,1),
    ShowroomName NVARCHAR(255) NOT NULL,
    Address NVARCHAR(500),
<<<<<<< Updated upstream
    Hotline VARCHAR(20)
);

=======
    Hotline VARCHAR(20),
    IsActive INT DEFAULT 1 -- 1: Đang mở cửa, 0: Đóng cửa/Sửa chữa
);

-- ==========================================
-- CÁC BẢNG CÒN LẠI GIỮ NGUYÊN
-- ==========================================

>>>>>>> Stashed changes
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
    ImageURL VARCHAR(500)
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
    PublishDate DATETIME DEFAULT GETDATE()
);

CREATE TABLE SearchHistory (
    SearchID INT PRIMARY KEY IDENTITY(1,1),
    Keyword NVARCHAR(255),
    SearchCount INT DEFAULT 1
);
GO

CREATE TABLE Activity_Logs (
<<<<<<< Updated upstream
    log_id INT IDENTITY(1,1) PRIMARY KEY, -- Đã đổi AUTO_INCREMENT thành IDENTITY(1,1)
    log_type VARCHAR(50) NOT NULL,        -- VD: 'IMPORT', 'SECURITY', 'ORDER', 'SYSTEM'
    title NVARCHAR(255) NOT NULL,         -- VD: 'Nhập kho thành công 05 Mercedes S450'
    created_by NVARCHAR(100),             -- VD: 'Admin Hảo' hoặc 'Nginx Firewall'
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP, 
    reference_code VARCHAR(50),           
    amount DECIMAL(18, 2) NULL         

=======
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    log_type VARCHAR(50) NOT NULL,        
    title NVARCHAR(255) NOT NULL,         
    created_by NVARCHAR(100),             
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP, 
    reference_code VARCHAR(50),           
    amount DECIMAL(18, 2) NULL         
>>>>>>> Stashed changes
);