USE CarStore_FinalWeb;
GO

-- 1. BƠM DỮ LIỆU DANH MỤC (Category)
-- Thêm dòng số 4 để Bảng Phụ Kiện trên Dashboard có dữ liệu hiển thị
INSERT INTO Category (CategoryName, IsActive) VALUES 
(N'SUV Luxury', 1),
(N'Sport Car', 1),
(N'Sedan Premium', 1),
(N'Phụ kiện kỹ thuật', 1); 

-- 2. BƠM DỮ LIỆU NHÀ CUNG CẤP (Supplier)
INSERT INTO Supplier (SupplierName, Phone, Address, IsActive) VALUES 
(N'Mercedes-Benz Việt Nam', '18006142', N'Quận Gò Vấp, TP.HCM', 1),
(N'Audi Việt Nam', '18008888', N'Quận 1, TP.HCM', 1),
(N'Porsche Việt Nam', '18009999', N'Quận 7, TP.HCM', 1);

-- 3. BƠM DỮ LIỆU PHƯƠNG THỨC THANH TOÁN (PaymentMethod)
INSERT INTO PaymentMethod (MethodName, IsActive) VALUES 
(N'Chuyển khoản Ngân hàng (Internet Banking)', 1),
(N'Thẻ Tín dụng (Visa/MasterCard)', 1),
(N'Tiền mặt tại Showroom', 1);

-- 4. BƠM DỮ LIỆU KHUYẾN MÃI (Promotion)
INSERT INTO Promotion (PromoCode, DiscountPercent, StartDate, EndDate, IsActive) VALUES 
('FAUTO_VIP', 5, '2026-01-01', '2026-12-31', 1),
('FLASH_SALE', 10, '2026-03-01', '2026-03-31', 1);

-- 5. BƠM DỮ LIỆU SHOWROOM
INSERT INTO Showroom (ShowroomName, Address, Hotline, IsActive) VALUES 
(N'F-Auto Hội Sở Chính', N'Khu Công Nghệ Cao, Thủ Đức, TP.HCM', '0909123456', 1),
(N'F-Auto Quận 1', N'Lê Duẩn, Quận 1, TP.HCM', '0909987654', 1);

-- 6. BƠM DỮ LIỆU NGƯỜI DÙNG (User: 1 Admin, 1 Khách hàng)
INSERT INTO [User] (Username, Password, FullName, Email, Phone, Role) VALUES 
('admin_hao', '123456', N'Tạ Vũ Hảo', 'haotv@fpt.edu.vn', '0987654321', 1),
('customer_duy', '123456', N'Nguyễn Hồng Duy', 'duynh@gmail.com', '0123456789', 0);

-- 7. BƠM DỮ LIỆU SIÊU XE & PHỤ KIỆN (Product)
-- [Đã thêm cột Status = 1 để kích hoạt bán]
INSERT INTO Product (CategoryID, SupplierID, ProductName, Price, StockQuantity, Description, ImageURL, [Status]) VALUES 
(1, 1, N'Mercedes-Benz AMG G63', 10950000000, 5, N'Biểu tượng quyền lực và sức mạnh. Động cơ V8 Biturbo 4.0L mạnh mẽ.', 'IMG/OIP (2).webp', 1),
(2, 2, N'Audi R8 V10 Performance', 12500000000, 2, N'Siêu xe thể thao đường phố với động cơ hút khí tự nhiên V10 5.2L.', 'IMG/OIP.webp', 1),
(3, 1, N'Mercedes-Benz C300 AMG', 2150000000, 10, N'Mẫu Sedan thể thao cỡ nhỏ bán chạy nhất phân khúc sang trọng.', 'IMG/Mec300.webp', 1),
(2, 3, N'Porsche 911 Carrera S', 9500000000, 3, N'Huyền thoại xe thể thao đến từ Đức với thiết kế vượt thời gian.', 'IMG/Por.jpg', 1),
(4, 1, N'Bộ dụng cụ cơ khí cao cấp', 15000000, 40, N'Hộp đồ nghề sửa chữa siêu xe đa năng 150 chi tiết thép Cr-V chống gỉ.', 'IMG/logo.jpg', 1);

-- 8. BƠM DỮ LIỆU NHẬT KÝ HỆ THỐNG (Activity_Logs)
INSERT INTO Activity_Logs (log_type, title, created_by, reference_code, amount) VALUES 
('SYSTEM', N'Khởi tạo thành công hệ thống F-Auto Database', 'System Admin', 'SYS-INIT', NULL),
('IMPORT', N'Nhập kho 5 chiếc Mercedes AMG G63', 'admin_hao', 'IMP-1001', 54750000000);

PRINT N'✅ Bơm dữ liệu thành công! Hãy mở NetBeans và kết nối JDBC ngay.';