<%-- File: web/home.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="includes/header.jsp"></jsp:include>

<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,600;1,700&family=Montserrat:wght@300;400;600&display=swap" rel="stylesheet">
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
        text-shadow: 0 2px 10px rgba(212, 175, 55, 0.4);
    }
    
    .text-gold { color: #D4AF37 !important; }
    .btn-luxury {
        background: linear-gradient(45deg, #B8860B, #FFD700, #B8860B);
        background-size: 200% auto;
        color: #000 !important;
        font-weight: 700;
        text-transform: uppercase;
        border: none;
        border-radius: 50px;
        padding: 12px 30px;
        transition: 0.5s;
        box-shadow: 0 0 20px rgba(212, 175, 55, 0.4);
    }
    .btn-luxury:hover {
        background-position: right center;
        transform: translateY(-3px);
        box-shadow: 0 0 30px rgba(212, 175, 55, 0.8);
    }
    .btn-outline-luxury {
        color: #D4AF37;
        border: 1px solid #D4AF37;
        border-radius: 50px;
        text-transform: uppercase;
        font-weight: 600;
        transition: 0.4s;
        background: transparent;
    }
    .btn-outline-luxury:hover {
        background: #D4AF37;
        color: #000;
        box-shadow: 0 0 15px rgba(212, 175, 55, 0.5);
    }

    /* Hero Banner */
    .hero-banner {
        position: relative;
        height: 500px;
        background-image: url('IMG/505329.jpg');
        background-size: cover;
        background-position: center;
        background-attachment: fixed;
    }
    .hero-overlay {
        position: absolute;
        top: 0; left: 0; right: 0; bottom: 0;
        background: linear-gradient(to right, rgba(0,0,0,0.9), rgba(0,0,0,0.4));
    }


    .luxury-card {
        background: linear-gradient(145deg, #1a1a1a, #121212);
        border: 1px solid rgba(212, 175, 55, 0.1);
        border-radius: 15px;
        overflow: hidden;
        transition: 0.4s;
    }
    .luxury-card:hover {
        transform: translateY(-10px);
        border-color: rgba(212, 175, 55, 0.5);
        box-shadow: 0 15px 40px rgba(0, 0, 0, 0.9), 0 0 20px rgba(212, 175, 55, 0.2);
    }
    
    .car-img-wrapper {
        overflow: hidden;
    }
    .car-img-wrapper img {
        transition: transform 0.6s ease;
    }
    .luxury-card:hover .car-img-wrapper img {
        transform: scale(1.1);
    }
    /* Bảng điều khiển kính mờ (Glassmorphism) */
    .search-glass-wrapper {
        background: rgba(20, 20, 20, 0.85);
        backdrop-filter: blur(15px);
        -webkit-backdrop-filter: blur(15px);
        border: 1px solid rgba(212, 175, 55, 0.2);
        border-radius: 24px;
        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.6), 0 0 20px rgba(212, 175, 55, 0.05);
        transition: all 0.4s ease;
    }
    .search-glass-wrapper:hover {
        border-color: rgba(212, 175, 55, 0.5);
        box-shadow: 0 15px 35px rgba(0, 0, 0, 0.8), 0 0 30px rgba(212, 175, 55, 0.15);
    }

    /* Khung nhập liệu liền mạch */
    .seamless-search-box {
        background: #0a0a0a;
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 50px;
        padding: 6px 6px 6px 25px;
        display: flex;
        align-items: center;
        transition: 0.3s;
    }
    .seamless-search-box:focus-within {
        border-color: #D4AF37;
        background: #111;
        box-shadow: 0 0 15px rgba(212, 175, 55, 0.2);
    }
    
    /* Ô input tàng hình */
    .seamless-search-box input {
        background: transparent;
        border: none;
        color: #fff;
        box-shadow: none !important;
    }
    .seamless-search-box input::placeholder {
        color: rgba(255, 255, 255, 0.3);
        font-weight: 300;
    }
    
    /* Bảng điều khiển kính mờ (Glassmorphism) */
    .search-glass-wrapper {
        background: rgba(20, 20, 20, 0.85);
        backdrop-filter: blur(15px);
        -webkit-backdrop-filter: blur(15px);
        border: 1px solid rgba(212, 175, 55, 0.2);
        border-radius: 20px; /* Thu gọn bo góc */
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.5), 0 0 15px rgba(212, 175, 55, 0.05);
        transition: all 0.4s ease;
    }
    .search-glass-wrapper:hover {
        border-color: rgba(212, 175, 55, 0.5);
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.7), 0 0 20px rgba(212, 175, 55, 0.15);
    }

    /* Khung nhập liệu liền mạch - Đã bóp nhỏ chiều cao */
    .seamless-search-box {
        background: #0a0a0a;
        border: 1px solid rgba(255, 255, 255, 0.1);
        border-radius: 50px;
        padding: 4px 4px 4px 18px; /* Ép mỏng lại */
        display: flex;
        align-items: center;
        transition: 0.3s;
    }
    .seamless-search-box:focus-within {
        border-color: #D4AF37;
        background: #111;
        box-shadow: 0 0 15px rgba(212, 175, 55, 0.2);
    }
    
    .seamless-search-box input {
        background: transparent;
        border: none;
        color: #fff;
        box-shadow: none !important;
        font-size: 0.95rem; /* Giảm size chữ */
    }
    .seamless-search-box input::placeholder {
        color: rgba(255, 255, 255, 0.4);
        font-size: 0.9rem;
    }
    
    /* Nút tìm kiếm - Thu nhỏ lại */
    .btn-search-glow {
        background: linear-gradient(135deg, #D4AF37, #FFD700);
        color: #000 !important;
        border-radius: 50px;
        font-weight: 700;
        padding: 8px 24px; /* Bóp nhỏ nút */
        font-size: 0.85rem; /* Chữ nhỏ gọn */
        border: none;
        transition: 0.4s;
        text-transform: uppercase;
        letter-spacing: 0.5px;
    }
    .btn-search-glow:hover {
        transform: scale(1.03);
        box-shadow: 0 0 15px rgba(212, 175, 55, 0.5);
    }

    /* Thẻ xu hướng - Xinh xắn hơn */
    .trending-pill {
        background: rgba(255, 255, 255, 0.03);
        border: 1px solid rgba(255, 255, 255, 0.1);
        color: #aaa;
        border-radius: 50px;
        padding: 5px 14px; /* Nhỏ lại */
        font-size: 0.75rem; /* Chữ bé đi */
        text-decoration: none;
        transition: all 0.3s ease;
        display: inline-flex;
        align-items: center;
    }
    .trending-pill:hover {
        background: rgba(212, 175, 55, 0.1);
        border-color: #D4AF37;
        color: #D4AF37;
        transform: translateY(-2px);
    }
    .trending-count {
        font-size: 0.65rem;
        opacity: 0.5;
        margin-left: 4px;
    }
</style>

<div class="hero-banner d-flex align-items-center">
    <div class="hero-overlay"></div>
    <div class="container position-relative z-index-1">
        <div class="col-md-8 col-lg-6">
            <span class="badge bg-dark border border-warning text-warning mb-3 py-2 px-3">Đẳng cấp khác biệt</span>
            <h1 class="luxury-title mb-4" style="font-size: 3rem;">SĂN XE SANG <br> GIÁ CỰC TỐT</h1>
            <p class="text-light mb-4 fs-5" style="line-height: 1.6;">Khám phá bộ sưu tập những siêu phẩm tốc độ và những dòng xe sang trọng bậc nhất thế giới dành riêng cho bạn.</p>
            <a class="btn btn-luxury" href="#showroom" role="button">Khám Phá Showroom</a> </div>
    </div>
</div>

<div class="container" style="margin-top: -45px; position: relative; z-index: 10;">
    <div class="row justify-content-center">
        <div class="col-lg-7 col-md-9">
            <div class="search-glass-wrapper p-3 p-md-4">
                
                <form action="SearchController" method="GET" class="mb-3">
                    <div class="seamless-search-box">
                        <i class="fa-solid fa-magnifying-glass text-warning small"></i>
                        <input type="text" name="keyword" value="${currentKeyword}" class="form-control ms-2" placeholder="Tìm siêu xe (vd: G63, Porsche...)" autocomplete="off" required>
                        <button type="submit" class="btn btn-search-glow">
                            TÌM
                        </button>
                    </div>
                </form>
                
                <div class="d-flex flex-wrap align-items-center justify-content-center gap-2">
                    <span class="text-uppercase text-white-50 fw-bold me-1" style="font-size: 0.7rem; letter-spacing: 0.5px;">
                        <i class="fa-solid fa-fire text-danger mb-1"></i> Hot:
                    </span>
                    
                    <c:forEach items="${topSearches}" var="ts">
                        <a href="SearchController?keyword=${ts.keyword}" class="trending-pill">
                            ${ts.keyword} <span class="trending-count">(${ts.searchCount})</span>
                        </a>
                    </c:forEach>
                    
                    <%-- Giả định khi Database rỗng --%>
                    <c:if test="${empty topSearches}">
                        <a href="SearchController?keyword=Mercedes" class="trending-pill">Mercedes</a>
                        <a href="SearchController?keyword=Porsche" class="trending-pill">Porsche 911</a>
                        <a href="SearchController?keyword=Audi" class="trending-pill">Audi R8</a>
                    </c:if>
                </div>
                
            </div>
        </div>
    </div>
</div>

<div class="container mt-5 mb-5 pt-4" id="showroom">
    <div class="text-center mb-5">
        <h2 class="luxury-title d-inline-block border-bottom border-warning pb-2">BỘ SƯU TẬP MỚI VỀ</h2> </div>

    <div class="row g-4">
        <div class="col-md-4">
            <div class="card luxury-card h-100">
                <div class="car-img-wrapper">
                    <img src="IMG/OIP (2).webp" class="card-img-top" alt="Mercedes-Benz G63" style="height:250px; object-fit:cover"> </div>
                <div class="card-body text-center p-4">
                    <p class="text-muted small mb-1">SUV | 2024</p>
                    <h4 class="card-title text-white fw-bold mb-3">Mercedes-Benz G63</h4>
                    <h5 class="text-gold fw-bold">5,000,000,000 VNĐ</h5>
                </div>
                <div class="card-footer bg-transparent border-0 text-center pb-4 pt-0">
                    <a href="detail.jsp?id=1" class="btn btn-outline-luxury w-100">Xem Chi Tiết</a> </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card luxury-card h-100"> <div class="car-img-wrapper">
                    <img src="IMG/OIP.webp" class="card-img-top" alt="Audi R8 V10" style="height:250px; object-fit:cover"> </div>
                <div class="card-body text-center p-4">
                    <p class="text-muted small mb-1">Sport | 2023</p>
                    <h4 class="card-title text-white fw-bold mb-3">Audi R8 V10</h4>
                    <h5 class="text-gold fw-bold">4,500,000,000 VNĐ</h5>
                </div>
                <div class="card-footer bg-transparent border-0 text-center pb-4 pt-0">
                    <a href="detail.jsp?id=2" class="btn btn-outline-luxury w-100">Xem Chi Tiết</a> </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card luxury-card h-100"> <div class="car-img-wrapper">
                    <img src="IMG/Mec300.webp" class="card-img-top" alt="Mercedes C300" style="height:250px; object-fit:cover"> </div>
                <div class="card-body text-center p-4">
                    <p class="text-muted small mb-1">Sedan | 2025</p>
                    <h4 class="card-title text-white fw-bold mb-3">Mercedes C300</h4>
                    <h5 class="text-gold fw-bold">1,500,000,000 VNĐ</h5>
                </div>
                <div class="card-footer bg-transparent border-0 text-center pb-4 pt-0">
                    <a href="detail.jsp?id=3" class="btn btn-outline-luxury w-100">Xem Chi Tiết</a> </div>
            </div>
        </div>
    </div>
</div>

<c:if test="${not empty msg}">
    <script>
        Swal.fire({ 
            title: '<span style="font-family: Playfair Display; color: #D4AF37;">THÀNH CÔNG!</span>', 
            html: '<span style="color: #e0e0e0;">${msg}</span>', 
            icon: 'success', 
            background: '#121212',
            border: '1px solid #D4AF37',
            confirmButtonText: '<span style="color: #000; font-weight: bold;">Tuyệt vời</span>', 
            confirmButtonColor: '#D4AF37'
        });
    </script>
</c:if>

<jsp:include page="includes/footer.jsp"></jsp:include>