<%-- 
    Document   : detail
    Created on : Jan 16, 2026, 10:42:38 AM
    Author     : AngDeng
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
    <c:when test="${param.id == '2'}">
        <c:set var="carName" value="Audi R8 V10" /><c:set var="carCode" value="#AUDI-R8-002" />
        <c:set var="carPrice" value="4,500,000,000" /><c:set var="carImg" value="IMG/OIP.webp" />
        <c:set var="carDesc" value="Siêu xe thể thao mang động cơ V10 mạnh mẽ, thiết kế khí động học hoàn hảo." />
        <c:set var="carId" value="2" />
    </c:when>
    <c:when test="${param.id == '3'}">
        <c:set var="carName" value="Mercedes C300" /><c:set var="carCode" value="#MER-C300-003" />
        <c:set var="carPrice" value="1,500,000,000" /><c:set var="carImg" value="IMG/Mec300.webp" />
        <c:set var="carDesc" value="Mẫu Sedan hạng sang cỡ nhỏ, thiết kế thanh lịch, nội thất hiện đại." />
        <c:set var="carId" value="3" />
    </c:when>
    <c:otherwise>
        <c:set var="carName" value="Mercedes-Benz G63 AMG" /><c:set var="carCode" value="#MER-G63-001" />
        <c:set var="carPrice" value="5,000,000,000" /><c:set var="carImg" value="IMG/OIP (2).webp" />
        <c:set var="carDesc" value="Chiếc SUV địa hình mang tính biểu tượng, kết hợp giữa sức mạnh vượt trội và sự sang trọng." />
        <c:set var="carId" value="1" />
    </c:otherwise>
</c:choose>

<jsp:include page="includes/header.jsp"></jsp:include>

<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,600;1,700&family=Montserrat:wght@300;400;600&display=swap" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
    body { background-color: #0a0a0a; color: #e0e0e0; font-family: 'Montserrat', sans-serif; }
    
    .luxury-container {
        background: linear-gradient(145deg, #1a1a1a, #121212);
        border: 1px solid rgba(212, 175, 55, 0.3);
        border-radius: 20px;
        box-shadow: 0 10px 40px rgba(0, 0, 0, 0.8), 0 0 20px rgba(212, 175, 55, 0.1);
        padding: 40px; margin-top: 40px; margin-bottom: 50px;
    }

    .breadcrumb-item a { color: #D4AF37 !important; }
    .breadcrumb-item.active { color: #aaa; }
    
    /* Màu chữ xám sáng dễ đọc trên nền đen */
    .text-light-grey { color: #cccccc !important; }

    .luxury-title {
        font-family: 'Playfair Display', serif;
        color: #D4AF37; text-transform: uppercase; letter-spacing: 2px;
        text-shadow: 0 2px 10px rgba(212, 175, 55, 0.4);
    }

    .car-image-wrapper {
        border-radius: 15px; overflow: hidden;
        box-shadow: 0 10px 30px rgba(0,0,0,0.9);
    }
    .car-image-wrapper img { transition: transform 0.6s ease; }
    .car-image-wrapper:hover img { transform: scale(1.05); }

    .btn-luxury {
        background: linear-gradient(45deg, #B8860B, #FFD700, #B8860B);
        background-size: 200% auto;
        color: #000 !important; font-weight: 700; text-transform: uppercase;
        border: none; border-radius: 50px; padding: 15px 30px;
        transition: 0.5s;
        box-shadow: 0 0 20px rgba(212, 175, 55, 0.5);
    }
    .btn-luxury:hover {
        background-position: right center;
        transform: translateY(-3px);
        box-shadow: 0 0 30px rgba(212, 175, 55, 0.8);
    }

    .spec-box {
        background: rgba(255, 255, 255, 0.03);
        border-left: 3px solid #D4AF37;
        padding: 15px; margin-bottom: 15px; border-radius: 0 10px 10px 0;
        transition: 0.3s;
    }
    .spec-box:hover { background: rgba(212, 175, 55, 0.1); }
    .spec-title { font-size: 0.85rem; color: #cccccc; text-transform: uppercase; letter-spacing: 1px; }
    .spec-value { font-size: 1.2rem; font-weight: 600; color: #fff; }
    
    /* Nút số lượng Luxury */
    .btn-qty { background: transparent; border: none; color: #D4AF37; font-weight: bold; }
    .btn-qty:hover { background: #D4AF37; color: #000; }
    .input-qty { color: #ffffff !important; background-color: transparent !important; }
</style>

<div class="container">
    <div class="luxury-container">
        <nav aria-label="breadcrumb" class="mb-4">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="home.jsp" class="text-decoration-none">Trang chủ</a></li>
                <li class="breadcrumb-item active" aria-current="page">${carName}</li>
            </ol>
        </nav>

        <div class="row align-items-center">
            <div class="col-lg-7 mb-4 mb-lg-0">
                <div class="car-image-wrapper">
                    <img src="${carImg}" class="img-fluid rounded" alt="${carName}" style="height: 450px; object-fit: cover; width: 100%;">
                </div>
            </div>

            <div class="col-lg-5 ps-lg-5">
                <span class="badge bg-dark border border-warning text-warning mb-3 py-2 px-3">Mã xe: ${carCode}</span>
                
                <h1 class="luxury-title mb-3">${carName}</h1>
                <h2 class="text-white fw-bold mb-4">${carPrice} VNĐ</h2>
                
                <p class="text-light-grey mb-4" style="line-height: 1.8;">${carDesc}</p>

                <div class="row mb-4">
                    <div class="col-6">
                        <div class="spec-box">
                            <div class="spec-title">Tình trạng</div>
                            <div class="spec-value text-success"><i class="fa-solid fa-check me-2"></i>Còn hàng</div>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="spec-box">
                            <div class="spec-title">ODO</div>
                            <div class="spec-value"><i class="fa-solid fa-car me-2"></i>0 km</div>
                        </div>
                    </div>
                </div>
                
                <hr class="border-secondary my-4">

                <form id="addToCartForm" action="CartController" method="POST" class="mt-4">
                    <input type="hidden" name="action" value="addToCart">
                    <input type="hidden" name="productId" value="${carId}">
                    <input type="hidden" name="returnUrl" value="detail.jsp?id=${carId}">
                    
                    <div class="d-flex align-items-center gap-3">
                        <div class="input-group" style="width: 140px; border: 1px solid #D4AF37; border-radius: 50px; overflow: hidden;">
                            <button class="btn btn-qty fs-5 px-3" type="button" onclick="let q=document.getElementById('qty'); if(q.value>1) q.value--;">-</button>
                            <input type="text" id="qty" name="quantity" class="form-control text-center border-0 fs-5 input-qty" value="1" readonly>
                            <button class="btn btn-qty fs-5 px-3" type="button" onclick="let q=document.getElementById('qty'); q.value++;">+</button>
                        </div>
                        
                        <button type="button" class="btn btn-luxury flex-grow-1" onclick="xacNhanThemVaoGio()">
                            <i class="fa-solid fa-cart-plus me-2"></i> Đặt cọc ngay
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    function xacNhanThemVaoGio() {
        Swal.fire({
            title: '<span style="font-family: Playfair Display; color: #D4AF37;">XÁC NHẬN ĐẶT CỌC</span>',
            html: '<p style="color: #cccccc;">Bạn có muốn thêm siêu phẩm <b>${carName}</b> vào giỏ hàng?</p>',
            imageUrl: '${carImg}',
            imageWidth: 400,
            imageHeight: 220,
            imageAlt: '${carName}',
            background: '#121212',
            border: '1px solid #D4AF37',
            showCancelButton: true,
            confirmButtonColor: '#D4AF37',
            cancelButtonColor: '#444',
            confirmButtonText: '<span style="color: #000; font-weight: bold;">Chốt đơn!</span>',
            cancelButtonText: '<span style="color: #fff;">Suy nghĩ thêm</span>'
        }).then((result) => {
            if (result.isConfirmed) {
                Swal.fire({
                    title: 'Thành công!',
                    text: 'Đã thêm ${carName} vào giỏ hàng.',
                    icon: 'success',
                    background: '#121212',
                    color: '#D4AF37',
                    showConfirmButton: false,
                    timer: 1500
                }).then(() => {
                    document.getElementById('addToCartForm').submit();
                });
            }
        })
    }
</script>

<jsp:include page="includes/footer.jsp"></jsp:include>