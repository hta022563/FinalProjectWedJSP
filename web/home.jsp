<%-- File: web/home.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="includes/header.jsp"></jsp:include>

<style>
    /* Bảng màu Luxury */
    :root {
        --lux-dark: #0f172a;
        --lux-gold: #fbbf24;
        --lux-gold-dim: rgba(251, 191, 36, 0.2);
        --lux-glass: rgba(15, 23, 42, 0.75);
    }

    body {
        background-color: var(--lux-dark);
        color: #f8fafc;
        font-family: 'Inter', sans-serif;
    }

    /* Hiệu ứng Hero Banner Kính Mờ */
    .hero-glass-panel {
        background: rgba(0, 0, 0, 0.65);
        backdrop-filter: blur(12px);
        -webkit-backdrop-filter: blur(12px);
        border: 1px solid rgba(251, 191, 36, 0.3);
        box-shadow: 0 0 40px rgba(0,0,0,0.8);
    }

    /* Card Sản Phẩm Luxury */
    .lux-card {
        background: rgba(255, 255, 255, 0.03);
        border: 1px solid rgba(255, 255, 255, 0.05);
        backdrop-filter: blur(10px);
        border-radius: 1.5rem;
        transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
    }

    .lux-card:hover {
        transform: translateY(-8px);
        border-color: var(--lux-gold);
        box-shadow: 0 15px 35px var(--lux-gold-dim);
    }

    /* Gradient Chữ Vàng */
    .text-gold-gradient {
        background: linear-gradient(to right, #fbbf24, #f59e0b);
        -webkit-background-clip: text;
        -webkit-text-fill-color: transparent;
    }

    /* Nút bấm Custom */
    .btn-lux-gold {
            padding: 15px;
        background: linear-gradient(45deg, #f59e0b, #fbbf24);
        color: #0f172a !important;
        border: none;
        transition: 0.3s;
    }
    .btn-lux-gold:hover {
        box-shadow: 0 0 20px rgba(251, 191, 36, 0.5);
        transform: scale(1.02);
    }
    
    .btn-lux-outline {
        border: 1px solid var(--lux-gold);
        color: var(--lux-gold);
        background: transparent;
        transition: 0.3s;
    }
    .btn-lux-outline:hover {
        background: var(--lux-gold);
        color: #0f172a;
    }

    /* Thanh Tìm Kiếm */
    .search-bar-glass {
        background: rgba(255, 255, 255, 0.05) !important;
        border: 1px solid rgba(255, 255, 255, 0.1) !important;
        color: white !important;
    }
    .search-bar-glass::placeholder {
        color: rgba(255, 255, 255, 0.4);
    }
    .search-select-glass {
        background-color: rgba(0,0,0,0.5) !important;
        color: var(--lux-gold) !important;
        border-left: 1px solid rgba(255,255,255,0.1) !important;
    }
</style>

<div class="position-relative text-center d-flex align-items-center justify-content-center" style="background-image: url('IMG/505329.jpg'); height: 75vh; background-size: cover; background-position: center; background-attachment: fixed;">
    <div class="position-absolute top-0 start-0 w-100 h-100" style="background: linear-gradient(to bottom, rgba(15,23,42,0.3), var(--lux-dark));"></div>
    
    <div class="position-relative z-index-2 w-100 px-3">
        <div class="hero-glass-panel mx-auto p-5 rounded-4" style="max-width: 800px;">
            <p class="text-uppercase tracking-widest mb-2" style="color: var(--lux-gold); letter-spacing: 4px; font-size: 0.9rem;"><i class="fa-solid fa-crown me-2"></i>Độc bản & Thượng lưu</p>
            <h1 class="display-3 fw-bold mb-4 text-white" style="letter-spacing: 2px;">F-AUTO <span class="text-gold-gradient">PRESTIGE</span></h1>
            <p class="fs-5 text-light opacity-75 mb-5 px-md-5">Nơi hội tụ những kiệt tác cơ khí đỉnh cao. Trải nghiệm cảm giác lái đẳng cấp cùng bộ sưu tập siêu xe giới hạn.</p>
            <a class="btn btn-lux-gold btn-lg rounded-pill px-5 py-3 fw-bold text-uppercase" href="#showroom" role="button" style="letter-spacing: 1px;">
                <i class="fa-solid fa-key me-2"></i> Khám phá kho xe
            </a>
        </div>
    </div>
</div>

<div class="container mt-5 pt-4" id="showroom">
    <div class="row justify-content-center mb-5">
        <div class="col-md-9">
            <form action="HomeController" method="GET" class="d-flex p-2 rounded-pill shadow-lg" style="background: rgba(255,255,255,0.03); border: 1px solid rgba(255,255,255,0.1);">
                <input type="hidden" name="action" value="search">
                <input type="text" name="keyword" class="form-control search-bar-glass border-0 rounded-pill px-4" placeholder="Nhập tên siêu xe (VD: Porsche, Mercedes...)" value="${param.keyword}">
                <select name="category" class="form-select border-0 w-auto search-select-glass ms-2 rounded-pill">
                    <option value="0">Tất cả phân khúc</option>
                    <option value="1">SUV Luxury</option>
                    <option value="2">Sport Car</option>
                </select>
                <button type="submit" class="btn btn-lux-gold rounded-pill px-5 ms-2 fw-bold"> Quét</button>
            </form>
        </div>
    </div>

    <div class="text-center mb-5 pb-3">
        <h2 class="fw-bold text-uppercase d-inline-block position-relative pb-3 text-white" style="letter-spacing: 3px;">
            <i class="fa-solid fa-gem text-gold-gradient me-3"></i>Bộ Sưu Tập Giới Hạn
            <span class="position-absolute bottom-0 start-50 translate-middle-x" style="width: 80px; height: 2px; background: var(--lux-gold);"></span>
        </h2>
    </div>

    <div class="row g-4 mb-5">
        <c:choose>
            <c:when test="${not empty listCars}">
                <c:forEach items="${listCars}" var="car">
                    <div class="col-md-6 col-lg-4">
                        <div class="card lux-card h-100 overflow-hidden">
                            
                            <div class="position-relative overflow-hidden">
                                <img src="${car.imageURL}" class="card-img-top w-100" alt="${car.productName}" style="height:260px; object-fit:cover; transition: transform 0.7s ease;" onmouseover="this.style.transform='scale(1.1)'" onmouseout="this.style.transform='scale(1)'">
                                <div class="position-absolute top-0 start-0 w-100 h-100" style="background: linear-gradient(to top, rgba(15,23,42,0.9) 0%, transparent 50%); pointer-events: none;"></div>
                                
                                <c:if test="${car.stockQuantity <= 0}">
                                    <span class="position-absolute top-0 end-0 bg-danger text-white fw-bold px-4 py-2 m-3 rounded-pill small shadow-lg" style="letter-spacing: 1px;">SOLD OUT</span>
                                </c:if>
                                <c:if test="${car.stockQuantity > 0}">
                                    <span class="position-absolute top-0 end-0 bg-dark text-white border border-secondary px-3 py-1 m-3 rounded-pill small" style="backdrop-filter: blur(5px);">
                                        <i class="fa-solid fa-cubes text-info me-1"></i> Kho: ${car.stockQuantity}
                                    </span>
                                </c:if>
                            </div>

                            <div class="card-body position-relative z-index-2 mt-n4">
                                <span class="badge mb-3" style="background: var(--lux-gold-dim); color: var(--lux-gold); border: 1px solid var(--lux-gold);">${car.categoryName}</span>
                                <h4 class="card-title fw-bold text-white mb-2 text-truncate" title="${car.productName}">${car.productName}</h4>
                                <p class="text-muted small mb-4 line-clamp-2" style="height: 40px;">${car.description != null ? car.description : 'Trải nghiệm đỉnh cao của cơ khí hiện đại.'}</p>
                                
                                <h3 class="fw-bold mb-0 text-gold-gradient">
                                    <fmt:formatNumber value="${car.price}" type="number" pattern="#,###"/> <span class="fs-6 text-muted">VNĐ</span>
                                </h3>
                            </div>

                            <div class="card-footer bg-transparent border-top border-secondary p-4 d-flex gap-3">
                                <a href="DetailController?id=${car.productID}" class="btn btn-lux-outline w-50 fw-bold rounded-pill">
                                    <i class="fa-solid fa-eye me-1"></i> Chi tiết
                                </a>
                                
                                <form action="CartController" method="POST" class="w-50">
                                    <input type="hidden" name="action" value="add">
                                    <input type="hidden" name="productId" value="${car.productID}">
                                    <button type="submit" class="btn btn-lux-gold w-100 fw-bold rounded-pill" ${car.stockQuantity <= 0 ? 'disabled' : ''}>
                                        <i class="fa-solid fa-cart-shopping me-1"></i> Chốt đơn
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            
            <%-- Cảnh báo không tìm thấy --%>
            <c:otherwise>
                <div class="col-12 text-center py-5 my-5 lux-card">
                    <i class="fa-solid fa-radar text-muted mb-4" style="font-size: 5rem;"></i>
                    <h3 class="text-white fw-bold mb-3">Không tìm thấy dữ liệu</h3>
                    <p class="text-muted mb-4">Mẫu siêu xe bạn tìm kiếm hiện không có trong kho lưu trữ của F-Auto.</p>
                    <a href="HomeController" class="btn btn-lux-outline rounded-pill px-5 py-2">Quét lại toàn bộ kho</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <%-- Disclaimer --%>
    <div class="text-center py-4 border-top border-secondary opacity-50">
        <small class="text-white fst-italic">
            <i class="fa-solid fa-circle-info text-warning me-1"></i> Disclaimer: Sản phẩm này là một dự án cá nh được thực hiện hoàn toàn với mục đích nghiên cứu, học tập và phát triển kỹ năng chuyên môn. Mọi hình ảnh, nội dung và tư liệu được sử dụng trong dự án này đều không phục vụ cho bất kỳ mục đích thương mại hay lợi nhuận nào. Chúng tôi tôn trọng quyền sở hữu trí tuệ và các giá trị sáng tạo của các bên liên quan.
        </small>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<c:if test="${not empty msg}">
    <script>
        document.addEventListener("DOMContentLoaded", function() {
            Swal.fire({ 
                title: 'Thành công', 
                text: '${msg}', 
                icon: 'success', 
                background: '#0f172a',
                color: '#f8fafc',
                confirmButtonText: 'Xác nhận', 
                confirmButtonColor: '#fbbf24',
                iconColor: '#fbbf24'
            });
        });
    </script>
</c:if>

<jsp:include page="includes/footer.jsp"></jsp:include>