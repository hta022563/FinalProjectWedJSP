<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="includes/header.jsp"></jsp:include>

<%-- Khai báo mảng tên Danh mục để lặp ra các Tab cho gọn --%>
<%
    String[] catNames = {"", "SEDAN", "SPORT", "SUV & CUV", "BÁN TẢI", "MPV", "PHỤ TÙNG / ĐỒ CHƠI"};
    request.setAttribute("catNames", catNames);
%>

<style>
    /* -- CSS CHUẨN DARK MODE LUSURY -- */
    body {
        background-color: #0a0a0a; /* Nền tổng thể đen tuyền */
        color: #f8f9fa;
    }
    
    .page-title-bg {
        background: linear-gradient(rgba(0,0,0,0.8), rgba(0,0,0,0.8)), url('IMG/banner-cars.jpg') center/cover;
        color: white;
        padding: 80px 0;
        margin-bottom: 50px;
        border-bottom: 2px solid #d4af37; /* Đường viền vàng làm điểm nhấn */
    }

    /* -- CSS CHO THANH TAB -- */
    .f-auto-tabs {
        border-bottom: 1px solid #333;
        margin-bottom: 40px;
        gap: 15px;
    }
    .f-auto-tabs .nav-link {
        color: #6c757d;
        font-weight: 700;
        font-size: 1.05rem;
        text-transform: uppercase;
        letter-spacing: 1.5px;
        border: none;
        padding: 12px 25px;
        transition: all 0.3s ease;
        background: transparent;
    }
    .f-auto-tabs .nav-link:hover {
        color: #f8f9fa;
        transform: translateY(-2px);
    }
    .f-auto-tabs .nav-link.active {
        background-color: transparent !important;
        color: #d4af37 !important;
        border-bottom: 3px solid #d4af37;
        text-shadow: 0 0 10px rgba(212, 175, 55, 0.3);
    }

    /* -- CSS CHO CARD SẢN PHẨM -- */
    .product-card {
        background-color: #141414; /* Nền card xám đen rất tối */
        border: 1px solid #2a2a2a;
        transition: transform 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275), box-shadow 0.4s ease, border-color 0.4s ease;
        border-radius: 12px;
        overflow: hidden;
    }
    .product-card:hover {
        transform: translateY(-10px);
        border-color: #d4af37;
        box-shadow: 0 15px 35px rgba(212, 175, 55, 0.15); /* Ánh sáng vàng toả ra */
        z-index: 10;
    }
    .product-img-wrapper {
        height: 220px;
        overflow: hidden;
        background-color: #000; /* Nền ảnh đen để tôn chiếc xe */
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative; 
    }
    .product-img {
        max-width: 90%; /* Thu nhỏ ảnh một chút để có viền lề đẹp */
        max-height: 90%;
        object-fit: contain; /* Giữ nguyên tỷ lệ xe không bị cắt */
        transition: transform 0.5s ease;
    }
    .product-card:hover .product-img {
        transform: scale(1.08); /* Xe hơi phóng to khi hover */
    }
    .car-price {
        color: #d4af37; 
        font-weight: 900;
        font-size: 1.35rem;
        text-shadow: 0 2px 4px rgba(0,0,0,0.5);
    }
    .line-clamp-2 {
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;  
        overflow: hidden;
        color: #a0a0a0; /* Chữ xám sáng dễ đọc trên nền tối */
    }
    
    /* Làm mượt các nút bấm */
    .btn-outline-light {
        border-color: #555;
        color: #ddd;
    }
    .btn-outline-light:hover {
        background-color: #fff;
        color: #000;
        border-color: #fff;
    }
</style>

<div class="page-title-bg text-center">
    <h1 class="fw-bold display-4 text-warning luxury-logo" style="letter-spacing: 2px;">BỘ SƯU TẬP XE</h1>
    <p class="lead text-light">Khám phá những mẫu xe đỉnh cao nhất tại F-AUTO</p>
</div>

<div class="container mb-5">
    
    <%-- 1. THANH MENU TABS --%>
    <ul class="nav nav-tabs justify-content-center f-auto-tabs" id="categoryTabs" role="tablist">
        <c:forEach begin="1" end="6" var="i">
            <li class="nav-item" role="presentation">
                <button class="nav-link ${i == 1 ? 'active' : ''}" id="tab-${i}-btn" data-bs-toggle="tab" data-bs-target="#tab-${i}" type="button" role="tab">
                    ${catNames[i]}
                </button>
            </li>
        </c:forEach>
    </ul>

    <%-- 2. NỘI DUNG TỪNG TAB --%>
    <div class="tab-content" id="categoryTabsContent">
        
        <c:forEach begin="1" end="6" var="catId">
            <div class="tab-pane fade ${catId == 1 ? 'show active' : ''}" id="tab-${catId}" role="tabpanel">
                <div class="row g-4">
                    
                    <c:set var="countProduct" value="0" />
                    <c:forEach items="${listP}" var="p">
                        <c:if test="${p.categoryID == catId}">
                            <c:set var="countProduct" value="${countProduct + 1}" />
                            
                            <div class="col-md-4 col-lg-3">
                                <%-- Đổi bg-light thành bg-dark cho xe bị ẩn --%>
                                <div class="card h-100 product-card shadow-sm ${!p.status ? 'opacity-50' : ''}">
                                    
                                    <div class="product-img-wrapper">
                                        <img src="${p.imageURL}" class="product-img" alt="${p.productName}" 
                                             onerror="this.src='https://via.placeholder.com/300x200/111/d4af37?text=F-AUTO'">

                                        <c:if test="${!p.status && sessionScope.user != null && sessionScope.user.role == 1}">
                                            <span class="badge bg-danger position-absolute top-0 end-0 m-2 px-2 py-1 shadow">ĐÃ ẨN</span>
                                        </c:if>
                                    </div>
                                    
                                    <div class="card-body d-flex flex-column">
                                        <%-- Tiêu đề xe màu trắng --%>
                                        <h5 class="card-title fw-bold text-white mb-2">${p.productName}</h5>
                                        <p class="small mb-3 line-clamp-2">${p.description}</p>
                                        
                                        <div class="mt-auto">
                                            <h4 class="car-price mb-3">
                                                <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="VNĐ" maxFractionDigits="0"/>
                                            </h4>
                                            
                                            <div class="d-flex justify-content-between align-items-center mb-3">
                                                <%-- Nền kho màu xám đậm --%>
                                                <span class="badge" style="background-color: #333; border: 1px solid #444;"><i class="fa-solid fa-layer-group text-warning"></i> Kho: ${p.stockQuantity}</span>
                                            </div>
                                            
                                            <div class="d-grid gap-2">
                                                <a href="DetailController?pid=${p.productID}" class="btn btn-outline-light fw-bold text-uppercase" style="letter-spacing: 1px;">Xem chi tiết</a>
                                                
                                                <c:choose>
                                                    <c:when test="${sessionScope.user != null && sessionScope.user.role == 1}">
                                                        <div class="d-flex gap-2 mt-1">
                                                            <a href="ProductController?action=edit&id=${p.productID}" class="btn btn-primary flex-fill fw-bold border-0" style="background-color: #0d6efd;"><i class="fa-solid fa-pen"></i> Sửa</a>
                                                            <c:choose>
                                                                <c:when test="${p.status}">
                                                                    <a href="ProductController?action=delete&id=${p.productID}" class="btn btn-danger flex-fill fw-bold border-0" onclick="return confirm('Bạn muốn ẩn chiếc xe này khỏi Showroom?');"><i class="fa-solid fa-eye-slash"></i> Ẩn</a>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <button class="btn btn-secondary flex-fill fw-bold border-0" disabled>Đã bị ẩn</button>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </c:when>
                                                    
                                                    <c:otherwise>
                                                        <a href="CartController?action=add&pid=${p.productID}" class="btn btn-warning fw-bold text-dark text-uppercase" style="letter-spacing: 1px;">
                                                            <i class="fa-solid fa-cart-shopping me-1"></i> Thêm giỏ hàng
                                                        </a>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                            
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </c:forEach>
                    
                    <c:if test="${countProduct == 0}">
                        <div class="col-12 text-center py-5">
                            <h4 class="text-secondary"><i class="fa-solid fa-box-open me-2"></i>Hiện tại phân khúc này chưa có sản phẩm nào.</h4>
                        </div>
                    </c:if>

                    <%-- KHUNG THÊM MỚI (CHO ADMIN) ĐƯỢC LÀM LẠI CHO HỢP DARK MODE --%>
                    <c:if test="${sessionScope.user != null && sessionScope.user.role == 1}">
                        <div class="col-md-4 col-lg-3">
                            <a href="admin-product-form.jsp" class="card h-100 shadow-sm d-flex flex-column align-items-center justify-content-center text-decoration-none product-card" 
                               style="border: 2px dashed #d4af37; min-height: 380px; background-color: rgba(212, 175, 55, 0.03);">
                                <i class="fa-solid fa-circle-plus fa-3x mb-3" style="color: #d4af37;"></i>
                                <h5 class="fw-bold text-center text-uppercase" style="color: #d4af37; letter-spacing: 1px;">Thêm<br>${catNames[catId]}</h5>
                            </a>
                        </div>
                    </c:if>

                </div>
            </div>
        </c:forEach>

    </div>
</div>

<jsp:include page="includes/footer.jsp"></jsp:include>