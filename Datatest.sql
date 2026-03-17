USE [CarStore_FinalWeb];
GO

-- ==============================================================================
-- 3. BƠM DỮ LIỆU CHUẨN HÓA (DATA SEEDING) - BẢN FINAL
-- ==============================================================================

-- 3.1. DANH MỤC SẢN PHẨM (ID 1 -> 6)
INSERT INTO Category (CategoryName, IsActive) VALUES 
(N'SEDAN', 1), (N'SPORT', 1), (N'SUV & CUV', 1), 
(N'BÁN TẢI', 1), (N'MPV', 1), (N'PHỤ TÙNG / ĐỒ CHƠI', 1);

-- 3.2. NHÀ CUNG CẤP (ID 1 -> 24)
INSERT INTO Supplier (SupplierName, Phone, Address, IsActive) VALUES 
(N'Toyota', '18001001', N'TP.HCM', 1),            
(N'Honda', '18001002', N'TP.HCM', 1),             
(N'Mercedes-Benz', '18001003', N'TP.HCM', 1),    
(N'BMW', '18001004', N'TP.HCM', 1),              
(N'Porsche', '18001005', N'TP.HCM', 1),          
(N'Lexus', '18001006', N'TP.HCM', 1),            
(N'Ford', '18001007', N'TP.HCM', 1),             
(N'Mazda', '18001008', N'TP.HCM', 1),            
(N'Hyundai', '18001009', N'TP.HCM', 1),          
(N'Kia', '18001010', N'TP.HCM', 1),              
(N'Audi', '18001011', N'TP.HCM', 1),             
(N'Mitsubishi', '18001012', N'TP.HCM', 1),       
(N'Nissan', '18001013', N'TP.HCM', 1),           
(N'Isuzu', '18001014', N'TP.HCM', 1),            
(N'Suzuki', '18001015', N'TP.HCM', 1),           
(N'Subaru', '18001016', N'TP.HCM', 1),           
(N'Michelin', '18001017', N'TP.HCM', 1),         
(N'Vietmap', '18001018', N'TP.HCM', 1),          
(N'Panasonic', '18001019', N'TP.HCM', 1),        
(N'Steelmate', '18001020', N'TP.HCM', 1),        
(N'70mai', '18001021', N'TP.HCM', 1),            
(N'Areon', '18001022', N'TP.HCM', 1),            
(N'KATA', '18001023', N'TP.HCM', 1),             
(N'Khác', '18001024', N'TP.HCM', 1);             

-- 3.3. PHƯƠNG THỨC THANH TOÁN (Đã gộp chuẩn không cần UPDATE)
INSERT INTO PaymentMethod (MethodName, MethodCode, IconClass, [Description], BankName, AccountNo, AccountName, QRCodeURL) VALUES 
(N'Chuyển khoản QR', 'QR', 'fa-solid fa-qrcode', N'Hỗ trợ VNPay, Momo, ZaloPay và các ứng dụng ngân hàng.', 'TPB', '56511428888', N'Nguyễn Hồng Duy', 'IMG/1773415226708_TP Bank.jpg'),
(N'Thẻ tín dụng / Ghi nợ', 'CARD', 'fa-brands fa-cc-visa', N'Hỗ trợ thẻ Visa, Mastercard, JCB, Amex.', NULL, NULL, NULL, NULL),
(N'Thanh toán tiền mặt', 'CASH', 'fa-solid fa-money-bill-wave', N'Thanh toán trực tiếp khi đến nhận xe tại Showroom F-AUTO.', NULL, NULL, NULL, NULL);

-- 3.4. KHUYẾN MÃI
INSERT INTO Promotion (PromoCode, DiscountPercent, StartDate, EndDate, IsActive) VALUES 
('FAUTO_VIP', 5, '2026-01-01', '2026-12-31', 1),
('FLASH_SALE', 10, '2026-03-01', '2026-03-31', 1);

-- 3.5. SHOWROOM
INSERT INTO Showroom (ShowroomName, Address, Hotline, IsActive) VALUES 
(N'F-Auto Hội Sở Chính', N'Khu Công Nghệ Cao, Thủ Đức, TP.HCM', '0909123456', 1),
(N'F-Auto Quận 1', N'Lê Duẩn, Quận 1, TP.HCM', '0909987654', 1);

-- 3.6. TÀI KHOẢN MẪU
INSERT INTO [User] (Username, Password, FullName, Email, Phone, Role) VALUES 
('admin', '123', N'Quản Trị Viên', 'admin@fauto.vn', '0999999999', 1),
('hao123', '123', N'Tạ Vũ Hảo', 'haotv@gmail.com', '0888888888', 0);

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
(N'Mercedes-Benz AMG G63', N'Biểu tượng quyền lực và sức mạnh. Động cơ V8 Biturbo 4.0L.', 10950000000, 5, 'IMG/G63.jpg', 3, 3, 1),

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

-- 3.8. TIN TỨC (NEWS)
INSERT INTO News (Title, Content, Thumbnail, PublishDate, ExternalLink) VALUES 
(N'Tôi ngậm ngùi "trùm mền" chiếc Mercedes-Benz C 300 khi giá xăng gần 30.000 đồng/lít, đi xa cũng không dám dùng', 
 N'Khi giá xăng tăng từ 20.000 lên 27.000 đồng/lít, chi phí đổ đầy bình gần 2 triệu đồng khiến chiếc Mercedes-Benz C300 AMG đời 2014 của tôi bắt đầu ít ra khỏi gara.', 
 'https://autopro8.mediacdn.vn/thumb_w/640/134505113543774208/2026/3/9/trum-men-xe-vi-gia-xang-17730609237141013332968.jpg', 
 '2026-03-09 23:02:15', 'https://autopro.com.vn/toi-ngam-ngui-trum-men-chiec-mercedes-benz-c-300-khi-gia-xang-gan-30000-dong-lit-di-xa-cung-khong-dam-dung-177260309165452687.chn'),
(N'Range Rover Evoque 2026 ra mắt Việt Nam: Có thể chạy thuần điện 66 km, giá từ 2,739 tỷ đồng', 
 N'Không thay đổi nhiều về giá bán so với trước, nhưng Range Rover Evoque mới được nâng cấp đáng kể về công nghệ, hệ thống giải trí và bổ sung phiên bản plug-in hybrid có thể chạy thuần điện.', 
 'https://autopro8.mediacdn.vn/134505113543774208/2026/3/9/l551evoquearroiosgreyf34rt04300x250-1773033211352-1773033212856676196020.jpg', 
 '2026-03-09 23:05:08', 'https://autopro.com.vn/range-rover-evoque-2026-ra-mat-viet-nam-co-the-chay-thuan-dien-66-km-gia-tu-2739-ty-dong-177260309120714803.chn'),
(N'Chấp nhận lỗ 15,7 tỷ USD, Honda hủy bỏ kế hoạch ra mắt loạt xe điện mới', 
 N'Honda đã quyết định "quay xe" khi hủy bỏ kế hoạch ra mắt ba mẫu xe điện chiến lược tại thị trường Bắc Mỹ, bao gồm Honda 0 Saloon, Honda 0 SUV và Acura RSX EV để tập trung nhiều hơn vào dòng xe hybrid.', 
 'https://static-images.vnncdn.net/vps_images_publish/000001/000003/2026/3/13/honda-0-suv-concept-1578.jpg?width=0&s=kLIDMqmTSNzg7qVfmKjFxA', 
 '2026-03-13 22:44:10', 'https://vietnamnet.vn/chap-nhan-lo-15-7-ty-usd-honda-huy-bo-ke-hoach-ra-mat-loat-xe-dien-moi-2496993.html'),
(N'Tổng hợp những mẫu xe hơi mới nhất ra mắt năm 2026', 
 N'(PLO)- Thị trường xe hơi mới năm 2026 hứa hẹn sự bùng nổ của các dòng xe điện, xe xăng và xe hybrid.', 
 'https://image.plo.vn/w850/Uploaded/2026/lcemdurlq/2026_03_09/xe-hoi-1jpg-3-5787.png.webp', 
 '2026-03-09 22:49:45', 'https://plo.vn/tong-hop-nhung-mau-xe-hoi-moi-nhat-ra-mat-nam-2026-post898706.html'),
(N'Chi tiết siêu xe Ferrari Amalfi Spider hoàn toàn mới', 
 N'Sở hữu động cơ V8 twin-turbo 3.9L mạnh 640 mã lực, Ferrari Amalfi Spider là siêu xe mui trần nhập môn hoàn hảo đến từ Italy.', 
 'https://photo.znews.vn/w1920/Uploaded/aobhuua/2026_03_13/Ferrari_Amalfi_Spider_1.jpg', 
 '2026-03-13 22:50:39', 'https://znews.vn/chi-tiet-sieu-xe-ferrari-amalfi-spider-hoan-toan-moi-post1634614.html'),
(N'Bí quyết của người Nhật giúp ô tô vận hành bền bỉ', 
 N'(VTC News) - Thay vì thay đổi xe theo xu hướng, người tiêu dùng tại Nhật Bản tập trung vào các thói quen vận hành và bảo dưỡng chi tiết giúp phương tiện hoạt động bền bỉ.', 
 'https://cdn-i.vtcnews.vn/resize/th/upload/2026/03/12/bao-duong-xe-tai-nhat-14175796.jpg', 
 '2026-03-12 22:51:44', 'https://vtcnews.vn/bi-quyet-cua-nguoi-nhat-giup-o-to-van-hanh-ben-bi-ar1007239.html'),
(N'Xe đa dụng cỡ nhỏ bán chạy tháng 2/2026: Hyundai Creta vượt các đối thủ Nhật Bản', 
 N'Nếu tính riêng các mẫu xe sử dụng động cơ đốt trong, cuộc đua ở phân khúc xe đa dụng cỡ nhỏ vốn chật chội nhất thị trường vẫn là sự cạnh tranh của các thương hiệu Nhật Bản và Hàn Quốc.', 
 'https://static-images.vnncdn.net/vps_images_publish/000001/000003/2026/3/13/vinfast-vf-5-1583.jpeg?width=0&s=Rlo_mRffp3RfUn-OCz4shQ', 
 '2026-03-13 22:52:33', 'https://vietnamnet.vn/xe-da-dung-co-nho-ban-chay-thang-2-2026-hyundai-creta-vuot-cac-doi-thu-nhat-ban-2497002.html');

-- 3.9. NHẬT KÝ HỆ THỐNG
INSERT INTO Activity_Logs (log_type, title, created_by, reference_code, amount) VALUES 
('SYSTEM', N'Khởi tạo thành công hệ thống F-Auto Database', 'System Admin', 'SYS-INIT', NULL),
('IMPORT', N'Nhập kho 5 chiếc Mercedes AMG G63', 'admin', 'IMP-1001', 54750000000);
GO

PRINT N'✅ ĐÃ HOÀN TẤT BƠM DATA MẪU F-AUTO THÀNH CÔNG RỰC RỠ!';