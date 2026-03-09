<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="includes/header.jsp"></jsp:include>

<style>
    /* Hiệu ứng nổi lên khi di chuột vào xe */
    .product-card {
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        border: none;
        border-radius: 15px;
        overflow: hidden;
    }
    .product-card:hover {
        transform: translateY(-10px);
        box-shadow: 0 15px 30px rgba(0,0,0,0.15);
    }
    .product-img-wrapper {
        height: 220px;
        overflow: hidden;
        background-color: #f8f9fa;
        display: flex;
        align-items: center;
        justify-content: center;
        position: relative; /* Thêm để gắn nhãn Đã ẩn */
    }
    .product-img {
        max-width: 100%;
        max-height: 100%;
        object-fit: cover;
    }
    .car-price {
        color: #d4af37; /* Màu vàng sang trọng */
        font-weight: 900;
        font-size: 1.25rem;
    }
    .page-title-bg {
        background: linear-gradient(rgba(0,0,0,0.7), rgba(0,0,0,0.7)), url('IMG/banner-cars.jpg') center/cover;
        color: white;
        padding: 60px 0;
        margin-bottom: 40px;
    }
    .line-clamp-2 {
        display: -webkit-box;
        -webkit-line-clamp: 2;
        -webkit-box-orient: vertical;  
        overflow: hidden;
    }
</style>

<div class="page-title-bg text-center">
    <h1 class="fw-bold display-4 text-warning luxury-logo">BỘ SƯU TẬP XE</h1>
    <p class="lead">Khám phá những mẫu xe đỉnh cao nhất tại F-AUTO</p>
</div>

<div class="container mb-5">
    <div class="row g-4">
        
        <%-- LẶP QUA DANH SÁCH SẢN PHẨM --%>
        <c:forEach items="${listP}" var="p">
            <div class="col-md-4 col-lg-3">
                <%-- Nếu xe bị ẩn, làm mờ đi một chút (opacity-75) --%>
                <div class="card h-100 product-card shadow-sm ${!p.status ? 'bg-light opacity-75' : ''}">
                    
                    <div class="product-img-wrapper">
                        <img src="${p.imageURL}" class="product-img" alt="${p.productName}" 
                             onerror="this.src='https://via.placeholder.com/300x200?text=No+Image'">
                        
                        <%-- Hiển thị nhãn "Đã Ẩn" góc phải trên cùng cho Admin dễ nhìn --%>
                        <c:if test="${!p.status && sessionScope.user != null && sessionScope.user.role == 1}">
                            <span class="badge bg-secondary position-absolute top-0 end-0 m-2 px-2 py-1">ĐÃ ẨN</span>
                        </c:if>
                    </div>
                    
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title fw-bold text-dark mb-1">${p.productName}</h5>
                        <p class="text-muted small mb-2 line-clamp-2">${p.description}</p>
                        
                        <div class="mt-auto">
                            <h4 class="car-price mb-3">
                                <fmt:formatNumber value="${p.price}" type="currency" currencySymbol="VNĐ" maxFractionDigits="0"/>
                            </h4>
                            
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <span class="badge bg-secondary"><i class="fa-solid fa-layer-group"></i> Kho: ${p.stockQuantity}</span>
                            </div>
                            
                            <div class="d-grid gap-2">
                                <a href="DetailController?pid=${p.productID}" class="btn btn-outline-dark fw-bold">Xem chi tiết</a>
                                
                                <c:choose>
                                    <%-- NẾU LÀ ADMIN --%>
                                    <c:when test="${sessionScope.user != null && sessionScope.user.role == 1}">
                                        <div class="d-flex gap-2 mt-1">
                                            <a href="ProductController?action=edit&id=${p.productID}" class="btn btn-primary flex-fill fw-bold"><i class="fa-solid fa-pen"></i> Sửa</a>
                                            <c:choose>
                                                <c:when test="${p.status}">
                                                    <a href="ProductController?action=delete&id=${p.productID}" class="btn btn-danger flex-fill fw-bold" onclick="return confirm('Bạn muốn ẩn chiếc xe này khỏi Showroom?');"><i class="fa-solid fa-eye-slash"></i> Ẩn</a>
                                                </c:when>
                                                <c:otherwise>
                                                    <button class="btn btn-secondary flex-fill fw-bold" disabled>Đã bị ẩn</button>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </c:when>
                                    
                                    <%-- NẾU LÀ KHÁCH HÀNG / CHƯA ĐĂNG NHẬP --%>
                                    <c:otherwise>
                                        <a href="CartController?action=add&pid=${p.productID}" class="btn btn-warning fw-bold text-dark">
                                            <i class="fa-solid fa-cart-plus"></i> Thêm giỏ hàng
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
        
        <%-- KHUNG THÊM MỚI (CHỈ HIỆN VỚI ADMIN) NẰM Ở CUỐI CÙNG --%>
        <c:if test="${sessionScope.user != null && sessionScope.user.role == 1}">
            <div class="col-md-4 col-lg-3">
                <a href="admin-product-form.jsp" class="card h-100 shadow-sm d-flex flex-column align-items-center justify-content-center text-decoration-none product-card" 
                   style="border: 3px dashed #198754; min-height: 380px; border-radius: 15px; background-color: rgba(25, 135, 84, 0.05);">
                    <i class="fa-solid fa-circle-plus fa-3x text-success mb-3"></i>
                    <h4 class="fw-bold text-success">Thêm Xe Mới</h4>
                </a>
            </div>
        </c:if>

        <c:if test="${empty listP}">
            <div class="col-12 text-center my-5">
                <h3 class="text-muted"><i class="fa-solid fa-car-burst"></i> Hiện tại chưa có xe nào trong Showroom!</h3>
            </div>
        </c:if>

    </div>
</div>

<jsp:include page="includes/footer.jsp"></jsp:include>