<%-- File: web/home.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="includes/header.jsp"></jsp:include>

    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,600;1,700&family=Montserrat:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        body {
            background-color: #0a0a0a;
            color: #e0e0e0;
            font-family: 'Montserrat', sans-serif;
        }
        .luxury-title {
            font-family: 'Playfair Display', serif;
            color: #D4AF37;
            text-transform: uppercase;
            letter-spacing: 2px;
        }
        .text-gold {
            color: #D4AF37 !important;
        }
        .btn-luxury {
            background: #FFD700;
            color: #000 !important;
            font-weight: 700;
            text-transform: uppercase;
            border: none;
            padding: 12px 35px;
            transition: 0.3s;
            font-size: 0.9rem;
            letter-spacing: 1px;
        }
        .btn-luxury:hover {
            background: #D4AF37;
            transform: translateY(-2px);
        }
        .btn-outline-luxury {
            color: #D4AF37;
            border: 1px solid #D4AF37;
            text-transform: uppercase;
            font-weight: 600;
            transition: 0.3s;
            background: transparent;
            padding: 10px 30px;
            font-size: 0.85rem;
            letter-spacing: 1px;
        }
        .btn-outline-luxury:hover {
            background: rgba(212, 175, 55, 0.1);
            color: #FFD700;
            border-color: #FFD700;
        }
        .hero-banner {
            position: relative;
            height: 85vh;
            min-height: 500px;
            background-image: url('IMG/505329.jpg');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }
        .hero-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(to right, rgba(0,0,0,0.95) 10%, rgba(0,0,0,0.4) 100%);
        }
        .luxury-card {
            background: #111;
            border: 1px solid rgba(255, 255, 255, 0.05);
            border-radius: 10px;
            overflow: hidden;
            transition: 0.4s;
        }
        .luxury-card:hover {
            transform: translateY(-5px);
            border-color: rgba(212, 175, 55, 0.3);
        }
        .car-img-wrapper {
            overflow: hidden;
        }
        .car-img-wrapper img {
            transition: transform 0.6s ease;
        }
        .luxury-card:hover .car-img-wrapper img {
            transform: scale(1.05);
        }
        .test-drive-banner {
            background: linear-gradient(rgba(0,0,0,0.8), rgba(0,0,0,0.9)), url('IMG/car_s450.jpg') center/cover fixed;
            padding: 100px 0;
            border-top: 1px solid #333;
        }
        .process-box {
            text-align: center;
            padding: 30px 20px;
            position: relative;
        }
        .step-number {
            font-family: 'Playfair Display', serif;
            font-size: 5rem;
            font-weight: 700;
            color: rgba(212, 175, 55, 0.1);
            position: absolute;
            top: -10px;
            left: 50%;
            transform: translateX(-50%);
            z-index: 0;
            transition: 0.4s;
        }
        .process-content {
            position: relative;
            z-index: 1;
            margin-top: 40px;
        }
        .process-box:hover .step-number {
            color: rgba(212, 175, 55, 0.3);
            transform: translate(-50%, -10px);
        }
        .news-card {
            background: #111;
            border: 1px solid #222;
            border-radius: 8px;
            overflow: hidden;
            transition: 0.3s;
        }
        .news-card:hover {
            border-color: #D4AF37;
            transform: translateY(-5px);
        }
    </style>

    <div id="hero-banner" class="hero-banner d-flex align-items-center" style="transition: opacity 0.1s ease-out;">
        <div class="hero-overlay"></div>
        <div class="container position-relative z-index-1">
            <div class="col-md-8 col-lg-6">
                <span class="badge border border-warning text-warning mb-3 py-2 px-3 bg-transparent">Đẳng cấp khác biệt</span>
                <h1 class="luxury-title mb-4" style="font-size: 3.5rem; line-height: 1.2;">SĂN XE SANG <br> GIÁ CỰC TỐT</h1>
                <p class="text-light mb-5 fs-5" style="line-height: 1.6;">Khám phá bộ sưu tập những siêu phẩm tốc độ và những dòng xe sang trọng bậc nhất thế giới dành riêng cho bạn.</p>
                <a class="btn btn-luxury rounded-pill" href="#showroom" role="button">KHÁM PHÁ SHOWROOM</a>
            </div>
        </div>
    </div>

<div class="container mt-5 pt-5 mb-5" id="showroom">
    <div class="text-center mb-5">
        <h2 class="luxury-title d-inline-block border-bottom border-warning pb-2" style="font-size: 2rem;">BỘ SƯU TẬP MỚI VỀ</h2>
    </div>
    <div class="row g-4">
        <div class="col-md-4">
            <div class="card luxury-card h-100 pb-3">
                <div class="car-img-wrapper"><img src="IMG/OIP (2).webp" class="card-img-top" alt="Mercedes-Benz G63" style="height:250px; object-fit:cover"></div>
                <div class="card-body text-center p-4">
                    <p class="text-secondary small mb-1" style="font-size: 0.8rem;">SUV | 2024</p>
                    <h5 class="card-title text-white fw-bold mb-3">Mercedes-Benz G63</h5>
                    <h5 class="text-gold fw-bold mb-4">11,950,000,000 VNĐ</h5>
                    <%-- Đã sửa link chuẩn MVC và ID = 15 cho G63 --%>
                    <a href="MainController?target=Detail&id=15" class="btn btn-outline-luxury rounded-pill w-75">XEM CHI TIẾT</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card luxury-card h-100 pb-3">
                <div class="car-img-wrapper"><img src="IMG/OIP.webp" class="card-img-top" alt="Audi R8 V10" style="height:250px; object-fit:cover"></div>
                <div class="card-body text-center p-4">
                    <p class="text-secondary small mb-1" style="font-size: 0.8rem;">Sport | 2023</p>
                    <h5 class="card-title text-white fw-bold mb-3">Audi R8 V10</h5>
                    <h5 class="text-gold fw-bold mb-4">4,500,000,000 VNĐ</h5>
                    <%-- Đã sửa link chuẩn MVC và ID = 8 cho Audi R8 --%>
                    <a href="MainController?target=Detail&id=8" class="btn btn-outline-luxury rounded-pill w-75">XEM CHI TIẾT</a>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card luxury-card h-100 pb-3">
                <div class="car-img-wrapper"><img src="IMG/Mec300.webp" class="card-img-top" alt="Mercedes C300" style="height:250px; object-fit:cover"></div>
                <div class="card-body text-center p-4">
                    <p class="text-secondary small mb-1" style="font-size: 0.8rem;">Sedan | 2025</p>
                    <h5 class="card-title text-white fw-bold mb-3">Mercedes C300</h5>
                    <h5 class="text-gold fw-bold mb-4">1,500,000,000 VNĐ</h5>
                    <%-- Đã sửa link chuẩn MVC và ID = 5 cho Mercedes C300 --%>
                    <a href="MainController?target=Detail&id=5" class="btn btn-outline-luxury rounded-pill w-75">XEM CHI TIẾT</a>
                </div>
            </div>
        </div>
        <div class="text-center mt-5 pt-3">
            <a href="MainController?target=Product" class="btn btn-outline-luxury rounded-pill px-5">XEM TOÀN BỘ KHO XE</a>
        </div>
    </div>

    <div class="container my-5 py-5 border-top border-secondary">
        <div class="row align-items-center">
            <div class="col-lg-6 mb-4 mb-lg-0">
                <div class="position-relative" style="border-radius: 6px; overflow: hidden; box-shadow: 0 10px 30px rgba(0,0,0,0.8);">
                    <img src="IMG/Por.jpg" alt="Câu chuyện F-AUTO" class="w-100" style="height: 380px; object-fit: cover;">
                    <div class="position-absolute top-0 start-0 w-100 h-100" style="background: linear-gradient(to right, rgba(0,0,0,0.3), transparent);"></div>
                </div>
            </div>
            <div class="col-lg-6 px-lg-5 text-start">
                <span class="fw-bold mb-2 d-block text-uppercase" style="letter-spacing: 2px; font-size: 0.85rem;"><span class="text-white">CÂU CHUYỆN</span> <span class="text-gold">THƯƠNG HIỆU</span></span>
                <h2 class="luxury-title mb-4" style="font-size: 2.2rem;">ĐỈNH CAO CỦA <br> SỰ HOÀN MỸ</h2>
                <p class="mb-4" style="line-height: 1.8; color: #a0a0a0; font-size: 0.95rem;">F-AUTO không chỉ là nơi mua bán siêu xe, chúng tôi mang đến một phong cách sống thượng lưu. Mỗi chiếc xe tại F-AUTO đều phải trải qua 150 bước kiểm định khắt khe nhất trước khi lăn bánh đến tay chủ nhân.</p>
                <p class="mb-5" style="line-height: 1.8; color: #a0a0a0; font-size: 0.95rem;">Sứ mệnh của chúng tôi là biến ước mơ sở hữu những cỗ máy tốc độ hoàn mĩ nhất thế giới của bạn thành hiện thực một cách dễ dàng và minh bạch nhất.</p>
                <a href="MainController?target=News" class="btn btn-luxury rounded-pill">ĐỌC THÊM VỀ CHÚNG TÔI</a>
            </div>
        </div>
    </div>

    <div class="test-drive-banner text-center">
        <div class="container">
            <h2 class="luxury-title text-white mb-3" style="font-size: 2.5rem;">TRẢI NGHIỆM ĐẲNG CẤP THỰC TẾ</h2>
            <p class="text-light mb-5 fs-5 mx-auto" style="max-width: 700px; line-height: 1.6;">Hãy trực tiếp cầm vô lăng và cảm nhận sức mạnh của những cỗ máy thời gian hoàn hảo nhất.</p>
            <a href="tel:0909123456" class="btn btn-luxury rounded-pill px-5 py-3 fs-6"><i class="fa-solid fa-calendar-check me-2"></i> ĐẶT LỊCH LÁI THỬ NGAY</a>
        </div>
    </div>

<c:if test="${not empty msg}">
    <script>
        Swal.fire({title: '<span style="font-family: Playfair Display; color: #D4AF37;">THÀNH CÔNG!</span>', html: '<span style="color: #e0e0e0;">${msg}</span>', icon: 'success', background: '#121212', border: '1px solid #D4AF37', confirmButtonText: '<span style="color: #000; font-weight: bold;">Tuyệt vời</span>', confirmButtonColor: '#D4AF37'});
    </script>
    <c:remove var="msg" />  
</c:if>

<div class="container my-5 py-5">
    <div class="text-center mb-5 pb-4">
        <h2 class="luxury-title d-inline-block border-bottom border-warning pb-2" style="font-size: 2rem;">QUY TRÌNH MUA XE</h2>
        <p class="text-muted mt-3">Đơn giản hóa trải nghiệm thượng lưu của bạn</p>
    </div>
    <div class="row g-4 position-relative">
        <div class="col-md-4">
            <div class="process-box">
                <div class="step-number">01</div>
                <div class="process-content">
                    <i class="fa-solid fa-magnifying-glass mb-3 text-gold fs-1"></i>
                    <h5 class="text-white fw-bold mb-3">Khám Phá & Lựa Chọn</h5>
                    <p class="text-secondary small">Truy cập bộ sưu tập xe đa dạng của chúng tôi, nhận tư vấn chuyên sâu và chọn ra mẫu xe phản ánh đúng đẳng cấp của bạn.</p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="process-box">
                <div class="step-number">02</div>
                <div class="process-content">
                    <i class="fa-solid fa-file-contract mb-3 text-gold fs-1"></i>
                    <h5 class="text-white fw-bold mb-3">Tài Chính & Pháp Lý</h5>
                    <p class="text-secondary small">Hoàn tất thủ tục thanh toán nhanh chóng với đa dạng phương thức và sự hỗ trợ toàn diện về giấy tờ sang tên, ra biển số.</p>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="process-box">
                <div class="step-number">03</div>
                <div class="process-content">
                    <i class="fa-solid fa-key mb-3 text-gold fs-1"></i>
                    <h5 class="text-white fw-bold mb-3">Bàn Giao Đặc Quyền</h5>
                    <p class="text-secondary small">Nhận chìa khóa xe tận tay tại Showroom hoặc yêu cầu dịch vụ vận chuyển xe chuyên dụng đến tận cửa garage nhà bạn.</p>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container-fluid py-5 border-top border-secondary" style="background-color: #0d0d0d;">
    <div class="container py-4">
        <div class="d-flex justify-content-between align-items-end mb-5">
            <div><h2 class="luxury-title mb-0" style="font-size: 2rem;">TIN TỨC & SỰ KIỆN</h2></div>
            <a href="MainController?target=News" class="btn btn-outline-luxury rounded-pill d-none d-md-inline-block">XEM TẤT CẢ</a>
        </div>

        <div class="row g-4">
            <div class="col-md-4">
                <div class="news-card h-100 pb-3">
                    <div class="car-img-wrapper"><img src="IMG/Por.jpg" class="card-img-top" style="height:220px; object-fit:cover"></div>
                    <div class="card-body p-4 text-start">
                        <p class="text-gold small mb-2 fw-bold"><i class="fa-regular fa-calendar me-1"></i> 10/11/2026</p>
                        <h5 class="card-title text-white fw-bold mb-3" style="font-size: 1.1rem;">Porsche 911 thế hệ mới chính thức cập bến F-AUTO</h5>
                        <p class="text-secondary small mb-4" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">Tuyệt tác thể thao đến từ Đức đã sẵn sàng để khách hàng chiêm ngưỡng và lái thử với nhiều nâng cấp đáng giá về động cơ.</p>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="news-card h-100 pb-3">
                    <div class="car-img-wrapper"><img src="IMG/lambo.jpg" class="card-img-top" style="height:220px; object-fit:cover"></div>
                    <div class="card-body p-4 text-start">
                        <p class="text-gold small mb-2 fw-bold"><i class="fa-regular fa-calendar me-1"></i> 05/11/2026</p>
                        <h5 class="card-title text-white fw-bold mb-3" style="font-size: 1.1rem;">Mercedes S-Class 2026: Định nghĩa lại sự xa xỉ</h5>
                        <p class="text-secondary small mb-4" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">Cùng khám phá khoang nội thất thương gia hạng nhất và các công nghệ an toàn dẫn đầu thế giới trên mẫu xe sedan đầu bảng.</p>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="news-card h-100 pb-3">
                    <div class="car-img-wrapper"><img src="IMG/505329.jpg" class="card-img-top" style="height:220px; object-fit:cover"></div>
                    <div class="card-body p-4 text-start">
                        <p class="text-gold small mb-2 fw-bold"><i class="fa-regular fa-calendar me-1"></i> 01/11/2026</p>
                        <h5 class="card-title text-white fw-bold mb-3" style="font-size: 1.1rem;">Triển lãm Siêu Xe F-AUTO Motor Show 2026</h5>
                        <p class="text-secondary small mb-4" style="display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden;">Sự kiện quy tụ hàng chục mẫu siêu xe hiếm nhất thế giới sẽ diễn ra vào cuối tháng này dành riêng cho khách hàng VIP.</p>
                    </div>
                </div>
            </div>
        </div>
        <div class="text-center mt-4 d-md-none"><a href="MainController?target=News" class="btn btn-outline-luxury rounded-pill px-5">XEM TẤT CẢ</a></div>
    </div>
</div>

<script>
    window.addEventListener('scroll', function () {
        var banner = document.getElementById('hero-banner');
        if (banner) {
            var scrollPos = window.scrollY;
            var opacityValue = 1 - (scrollPos / 600);
            if (opacityValue < 0)
                opacityValue = 0;
            banner.style.opacity = opacityValue;
        }
    });
</script>

<jsp:include page="includes/footer.jsp"></jsp:include>