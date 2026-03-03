-- Category
INSERT INTO Category (CategoryName) VALUES (N'Xe SUV'), (N'Xe Sedan'), (N'Phụ kiện Nội thất'), (N'Lốp & Mâm');

-- Supplier
INSERT INTO Supplier (SupplierName, Phone, Address) VALUES 
(N'Toyota Việt Nam', '024123456', N'Vĩnh Phúc'),
(N'Michelin', '028999999', N'TP. Hồ Chí Minh'),
(N'Honda Việt Nam', '024888888', N'Hà Nội');

-- PaymentMethod
INSERT INTO PaymentMethod (MethodName) VALUES (N'Tiền mặt'), (N'VNPay'), (N'Chuyển khoản ngân hàng');

-- Promotion
INSERT INTO Promotion (PromoCode, DiscountPercent, StartDate, EndDate) VALUES 
('XUAN2026', 10, '2026-01-01', '2026-03-31'),
('PHUKIEN5', 5, '2026-02-01', '2026-12-31');

-- Showroom
INSERT INTO Showroom (ShowroomName, Address, Hotline) VALUES 
(N'Showroom Quận 1', N'123 Lê Lợi, Q1, HCM', '19001001'),
(N'Showroom Cầu Giấy', N'456 Xuân Thủy, Cầu Giấy, HN', '19001002');

-- User (Admin: 123, Khách: 123)
INSERT INTO [User] (Username, Password, FullName, Email, Phone, Role) VALUES 
('admin', '123', N'Nguyễn Văn Duy Admin', 'admin@carstore.com', '0912345678', 1),
('khachhang1', '123', N'Trần Thị B', 'customer1@gmail.com', '0988777666', 0);

-- Product
INSERT INTO Product (CategoryID, SupplierID, ProductName, Price, StockQuantity, Description, ImageURL) VALUES 
(1, 1, N'Toyota Fortuner 2026', 1200000000, 5, N'Xe SUV 7 chỗ mạnh mẽ', 'fortuner.jpg'),
(2, 3, N'Honda City RS', 600000000, 10, N'Xe Sedan đô thị trẻ trung', 'city.jpg'),
(4, 2, N'Lốp Michelin Pilot Sport 4', 4500000, 50, N'Lốp hiệu năng cao', 'michelin.jpg');

-- News
INSERT INTO News (Title, Content, Thumbnail) VALUES 
(N'Ra mắt dòng xe điện mới 2026', N'Nội dung chi tiết về xe điện...', 'news1.jpg'),
(N'Mẹo bảo dưỡng lốp xe mùa mưa', N'Các bước kiểm tra lốp...', 'news2.jpg');

-- Lịch sử tìm kiếm mẫu
INSERT INTO SearchHistory (Keyword, SearchCount) VALUES ('SUV', 15), ('Toyota', 20);
GO

