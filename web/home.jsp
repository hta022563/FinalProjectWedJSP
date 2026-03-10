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

    /* Showroom Cards */
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
</style>

<div class="hero-banner d-flex align-items-center">
    <div class="hero-overlay"></div>
    <div class="container position-relative z-index-1">
        <div class="col-md-8 col-lg-6">
            <span class="badge bg-dark border border-warning text-warning mb-3 py-2 px-3">Đẳng cấp khác biệt</span>
            <h1 class="luxury-title mb-4" style="font-size: 3rem;">SĂN XE SANG <br> GIÁ CỰC TỐT</h1>
            <p class="text-light mb-4 fs-5" style="line-height: 1.6;">Khám phá bộ sưu tập những siêu phẩm tốc độ và những dòng xe sang trọng bậc nhất thế giới dành riêng cho bạn.</p>
            <a class="btn btn-luxury" href="#showroom" role="button">Khám Phá Showroom</a>
        </div>
    </div>
</div>

<div class="container mt-5 mb-5 pt-4" id="showroom">
    <div class="text-center mb-5">
        <h2 class="luxury-title d-inline-block border-bottom border-warning pb-2">BỘ SƯU TẬP MỚI VỀ</h2>
    </div>

    <div class="row g-4">
        <div class="col-md-4">
            <div class="card luxury-card h-100">
                <div class="car-img-wrapper">
                    <img src="IMG/OIP (2).webp" class="card-img-top" alt="Mercedes-Benz G63" style="height:250px; object-fit:cover">
                </div>
                <div class="card-body text-center p-4">
                    <p class="text-muted small mb-1">SUV | 2024</p>
                    <h4 class="card-title text-white fw-bold mb-3">Mercedes-Benz G63</h4>
                    <h5 class="text-gold fw-bold">5,000,000,000 VNĐ</h5>
                </div>
                <div class="card-footer bg-transparent border-0 text-center pb-4 pt-0">
                    <a href="detail.jsp?id=1" class="btn btn-outline-luxury w-100">Xem Chi Tiết</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card luxury-card h-100">
                <div class="car-img-wrapper">
                    <img src="IMG/OIP.webp" class="card-img-top" alt="Audi R8 V10" style="height:250px; object-fit:cover">
                </div>
                <div class="card-body text-center p-4">
                    <p class="text-muted small mb-1">Sport | 2023</p>
                    <h4 class="card-title text-white fw-bold mb-3">Audi R8 V10</h4>
                    <h5 class="text-gold fw-bold">4,500,000,000 VNĐ</h5>
                </div>
                <div class="card-footer bg-transparent border-0 text-center pb-4 pt-0">
                    <a href="detail.jsp?id=2" class="btn btn-outline-luxury w-100">Xem Chi Tiết</a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card luxury-card h-100">
                <div class="car-img-wrapper">
                    <img src="IMG/Mec300.webp" class="card-img-top" alt="Mercedes C300" style="height:250px; object-fit:cover">
                </div>
                <div class="card-body text-center p-4">
                    <p class="text-muted small mb-1">Sedan | 2025</p>
                    <h4 class="card-title text-white fw-bold mb-3">Mercedes C300</h4>
                    <h5 class="text-gold fw-bold">1,500,000,000 VNĐ</h5>
                </div>
                <div class="card-footer bg-transparent border-0 text-center pb-4 pt-0">
                    <a href="detail.jsp?id=3" class="btn btn-outline-luxury w-100">Xem Chi Tiết</a>
                </div>
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