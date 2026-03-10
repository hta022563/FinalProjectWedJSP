-- ==============================================================================
-- 3. BƠM DỮ LIỆU CHUẨN HÓA (DATA SEEDING)
-- ==============================================================================

-- 3.2. BƠM DỮ LIỆU TIN TỨC MỚI NHẤT

INSERT INTO News (Title, Content, Thumbnail, PublishDate, ExternalLink) VALUES 
(N'F-AUTO Chính Thức Khai Trương Showroom Siêu Xe Lớn Nhất TP.HCM', 
 N'Sáng nay, F-AUTO đã chính thức cắt băng khánh thành showroom xe sang và siêu xe lớn nhất miền Nam tọa lạc tại trung tâm TP.HCM. Showroom trưng bày hàng loạt tên tuổi lớn như Rolls-Royce, Bentley, Porsche, Ferrari... hứa hẹn là điểm đến lý tưởng cho giới thượng lưu.', 
 'IMG/OIP (2).webp', GETDATE(), 'https://autopro.com.vn'),

(N'Siêu Phẩm Mercedes-AMG G63 Phiên Bản Đặc Biệt Về Việt Nam', 
 N'Chiếc "chuyên cơ mặt đất" G63 AMG bản giới hạn với màu sơn độc quyền vừa cập cảng Việt Nam và sẽ được bàn giao ngay cho một đại gia giấu tên. Điểm nhấn của mẫu xe này là nội thất bọc da Nappa và động cơ V8 Bi-turbo công suất khủng.', 
 'IMG/Mec300.webp', DATEADD(day, -2, GETDATE()), 'https://vnexpress.net/oto-xe-may'),

(N'Thị Trường Siêu Xe Tại Việt Nam 2026: Nhu Cầu Tăng Đột Biến', 
 N'Bất chấp các biến động kinh tế, doanh số bán siêu xe và xe siêu sang tại Việt Nam quý đầu năm 2026 vẫn ghi nhận mức tăng trưởng 150% so với cùng kỳ năm ngoái. Giới chuyên gia nhận định đây là xu hướng khẳng định đẳng cấp của các doanh nhân trẻ.', 
 'IMG/Por.jpg', DATEADD(day, -5, GETDATE()), 'https://dantri.com.vn/o-to-xe-may.htm');

-- 3.1. DANH MỤC SẢN PHẨM (ID 1 -> 6)
INSERT INTO Category (CategoryName, IsActive) VALUES 
(N'SEDAN', 1), (N'SPORT', 1), (N'SUV & CUV', 1), 
(N'BÁN TẢI', 1), (N'MPV', 1), (N'PHỤ TÙNG / ĐỒ CHƠI', 1);

-- 3.2. NHÀ CUNG CẤP (ID 1 -> 24 để không bị lỗi Khóa Ngoại khi insert xe)
INSERT INTO Supplier (SupplierName, Phone, Address, IsActive) VALUES 
(N'Toyota', '18001001', N'TP.HCM', 1),           -- 1
(N'Honda', '18001002', N'TP.HCM', 1),            -- 2
(N'Mercedes-Benz', '18001003', N'TP.HCM', 1),    -- 3
(N'BMW', '18001004', N'TP.HCM', 1),              -- 4
(N'Porsche', '18001005', N'TP.HCM', 1),          -- 5
(N'Lexus', '18001006', N'TP.HCM', 1),            -- 6
(N'Ford', '18001007', N'TP.HCM', 1),             -- 7
(N'Mazda', '18001008', N'TP.HCM', 1),            -- 8
(N'Hyundai', '18001009', N'TP.HCM', 1),          -- 9
(N'Kia', '18001010', N'TP.HCM', 1),              -- 10
(N'Audi', '18001011', N'TP.HCM', 1),             -- 11
(N'Mitsubishi', '18001012', N'TP.HCM', 1),       -- 12
(N'Nissan', '18001013', N'TP.HCM', 1),           -- 13
(N'Isuzu', '18001014', N'TP.HCM', 1),            -- 14
(N'Suzuki', '18001015', N'TP.HCM', 1),           -- 15
(N'Subaru', '18001016', N'TP.HCM', 1),           -- 16
(N'Michelin', '18001017', N'TP.HCM', 1),         -- 17
(N'Vietmap', '18001018', N'TP.HCM', 1),          -- 18
(N'Panasonic', '18001019', N'TP.HCM', 1),        -- 19
(N'Steelmate', '18001020', N'TP.HCM', 1),        -- 20
(N'70mai', '18001021', N'TP.HCM', 1),            -- 21
(N'Areon', '18001022', N'TP.HCM', 1),            -- 22
(N'KATA', '18001023', N'TP.HCM', 1),             -- 23
(N'Khác', '18001024', N'TP.HCM', 1);             -- 24

-- 3.3. PHƯƠNG THỨC THANH TOÁN
INSERT INTO PaymentMethod (MethodName, IsActive) VALUES 
(N'Chuyển khoản Ngân hàng (Internet Banking)', 1),
(N'Thẻ Tín dụng (Visa/MasterCard)', 1),
(N'Tiền mặt tại Showroom', 1);

-- 3.4. KHUYẾN MÃI
INSERT INTO Promotion (PromoCode, DiscountPercent, StartDate, EndDate, IsActive) VALUES 
('FAUTO_VIP', 5, '2026-01-01', '2026-12-31', 1),
('FLASH_SALE', 10, '2026-03-01', '2026-03-31', 1);

-- 3.5. SHOWROOM
INSERT INTO Showroom (ShowroomName, Address, Hotline, IsActive) VALUES 
(N'F-Auto Hội Sở Chính', N'Khu Công Nghệ Cao, Thủ Đức, TP.HCM', '0909123456', 1),
(N'F-Auto Quận 1', N'Lê Duẩn, Quận 1, TP.HCM', '0909987654', 1);



-- 3.7. SẢN PHẨM (SIÊU XE & PHỤ KIỆN)
INSERT INTO Product (ProductName, Description, Price, StockQuantity, ImageURL, CategoryID, SupplierID, [Status]) VALUES 
-- CATEGORY 1: SEDAN
(N'Toyota Camry 2.5Q 2024', N'Mẫu sedan hạng D chuẩn mực cho doanh nhân, nội thất sang trọng.', 1405000000, 5, 'IMG/car_camry.jpg', 1, 1, 1),
(N'Honda City RS', N'Sedan hạng B thể thao, không gian rộng rãi, động cơ 1.5L i-VTEC.', 609000000, 20, 'IMG/car_city.jpg', 1, 2, 1),
(N'Mercedes-Benz S 450 Luxury', N'Sedan hạng F đầu bảng, biểu tượng của sự thành đạt.', 5559000000, 2, 'IMG/car_s450.jpg', 1, 3, 1),
(N'BMW 330i M Sport', N'Sedan thể thao với cảm giác lái sắc bén, ngoại thất gói M Sport.', 1899000000, 5, 'IMG/car_330i.jpg', 1, 4, 1),
(N'Mercedes-Benz C300 AMG', N'Mẫu Sedan thể thao cỡ nhỏ bán chạy nhất phân khúc sang trọng.', 2150000000, 10, 'IMG/Mec300.webp', 1, 3, 1),

-- CATEGORY 2: SPORT (SIÊU XE THỂ THAO)
(N'Honda Civic Type R', N'Mẫu xe đua đường phố, động cơ 2.0L Turbo 315 mã lực.', 2399000000, 3, 'IMG/car_civic_typer.jpg', 2, 2, 1),
(N'Porsche 911 Carrera S', N'Huyền thoại xe thể thao đến từ Đức với thiết kế vượt thời gian.', 9500000000, 3, 'IMG/Por.jpg', 2, 5, 1),
(N'Audi R8 V10 Performance', N'Siêu xe thể thao đường phố với động cơ hút khí tự nhiên V10 5.2L.', 12500000000, 2, 'IMG/OIP.webp', 2, 11, 1),

-- CATEGORY 3: SUV & CUV
(N'Toyota Fortuner Legender', N'Ông vua SUV 7 chỗ gầm cao, vượt mọi địa hình.', 1259000000, 8, 'IMG/car_fortuner.jpg', 3, 1, 1),
(N'Toyota Corolla Cross HEV', N'Crossover Hybrid đô thị siêu tiết kiệm nhiên liệu.', 955000000, 12, 'IMG/car_cross.jpg', 3, 1, 1),
(N'Honda CR-V L AWD 2024', N'Mẫu CUV 5+2 bán chạy nhất của Honda, dẫn động 4 bánh.', 1310000000, 10, 'IMG/car_crv.jpg', 3, 2, 1),
(N'Lexus RX 350 F Sport', N'SUV hạng sang cỡ trung bán chạy nhất, thiết kế sắc sảo.', 3430000000, 4, 'IMG/car_rx350.jpg', 3, 6, 1),
(N'Mercedes-Benz GLC 300', N'Mẫu SUV sang trọng, loa Burmester đẳng cấp.', 2799000000, 6, 'IMG/car_glc300.jpg', 3, 3, 1),
(N'BMW X5 xDrive40i', N'Mẫu SAV cỡ lớn, thiết kế nam tính, nội thất pha lê.', 4169000000, 3, 'IMG/car_x5.jpg', 3, 4, 1),
(N'Mercedes-Benz AMG G63', N'Biểu tượng quyền lực và sức mạnh. Động cơ V8 Biturbo 4.0L.', 10950000000, 5, 'IMG/OIP (2).webp', 3, 3, 1),

-- CATEGORY 4: BÁN TẢI 
(N'Ford Ranger Raptor 2024', N'Siêu bán tải hiệu suất cao, phuộc FOX Racing.', 1299000000, 5, 'IMG/car_raptor.jpg', 4, 7, 1),
(N'Ford Ranger Wildtrak 2.0L', N'Bán tải quốc dân, trang bị tiện nghi như SUV hạng sang.', 979000000, 12, 'IMG/car_wildtrak.jpg', 4, 7, 1),
(N'Mitsubishi Triton Athlete', N'Bán tải thể thao, hệ dẫn động Super Select linh hoạt.', 905000000, 10, 'IMG/car_triton.jpg', 4, 12, 1),

-- CATEGORY 5: MPV (XE ĐA DỤNG)
(N'Kia Carnival Royal', N'MPV đa dụng dành cho gia đình, cửa lùa điện, không gian vô đối.', 2499000000, 6, 'IMG/car_carnival.jpg', 5, 10, 1),
(N'Mitsubishi Xpander Premium', N'Vua doanh số phân khúc MPV 7 chỗ, gầm cao.', 658000000, 25, 'IMG/car_xpander.jpg', 5, 12, 1),
(N'Toyota Innova Cross HEV', N'MPV công nghệ Hybrid êm ái và siêu tiết kiệm.', 990000000, 12, 'IMG/car_innova.jpg', 5, 1, 1),

-- CATEGORY 6: PHỤ TÙNG & PHỤ KIỆN
(N'Lốp xe Michelin Primacy 4 (1 cái)', N'Lốp cao cấp bám đường tuyệt đỉnh trên đường ướt.', 2800000, 100, 'IMG/part_michelin.jpg', 6, 17, 1),
(N'Camera hành trình Vietmap KC01', N'Ghi hình chuẩn 2K nét căng, cảnh báo tốc độ.', 4200000, 45, 'IMG/part_vietmap.jpg', 6, 18, 1),
(N'Thảm lót sàn KATA 360 độ', N'Đúc khuân theo từng phom xe, chống thấm nước, không mùi.', 2500000, 60, 'IMG/part_kata.jpg', 6, 23, 1),
(N'Bơm lốp điện mini 70mai', N'Bơm hơi tự động ngắt cực kỳ nhỏ gọn, để vừa cốp xe.', 890000, 80, 'IMG/part_pump.jpg', 6, 21, 1),
(N'Bộ dụng cụ cơ khí cao cấp', N'Hộp đồ nghề sửa chữa siêu xe đa năng 150 chi tiết thép Cr-V.', 15000000, 40, 'IMG/logo.jpg', 6, 24, 1);

-- 3.8. NHẬT KÝ HỆ THỐNG
INSERT INTO Activity_Logs (log_type, title, created_by, reference_code, amount) VALUES 
('SYSTEM', N'Khởi tạo thành công hệ thống F-Auto Database', 'System Admin', 'SYS-INIT', NULL),
('IMPORT', N'Nhập kho 5 chiếc Mercedes AMG G63', 'admin_hao', 'IMP-1001', 54750000000);
GO

PRINT N'✅ Đã khởi tạo lại toàn bộ Database CarStore_FinalWeb thành công rực rỡ!';