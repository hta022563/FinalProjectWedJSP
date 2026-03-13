<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="includes/header.jsp"></jsp:include>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<%
    String[] catNames = {"TẤT CẢ", "SEDAN", "SPORT", "SUV & CUV", "BÁN TẢI", "MPV", "PHỤ TÙNG / ĐỒ CHƠI"};
    request.setAttribute("catNames", catNames);
%>

<style>
    /* -- CSS CHUẨN DARK MODE LUXURY -- */
    body { background-color: #0a0a0a; color: #f8f9fa; }
    .page-title-bg { background: linear-gradient(rgba(0,0,0,0.8), rgba(0,0,0,0.8)), url('IMG/banner-cars.jpg') center/cover; color: white; padding: 80px 0; margin-bottom: 50px; border-bottom: 2px solid #d4af37; }
    .f-auto-tabs { border-bottom: 1px solid #333; margin-bottom: 40px; gap: 15px; }
    .f-auto-tabs .nav-link { color: #6c757d; font-weight: 700; font-size: 1.05rem; text-transform: uppercase; letter-spacing: 1.5px; border: none; padding: 12px 25px; transition: all 0.3s ease; background: transparent; }
    .f-auto-tabs .nav-link:hover { color: #f8f9fa; transform: translateY(-2px); }
    .f-auto-tabs .nav-link.active { background-color: transparent !important; color: #d4af37 !important; border-bottom: 3px solid #d4af37; text-shadow: 0 0 10px rgba(212, 175, 55, 0.3); }

    .product-card { background-color: #141414; border: 1px solid #2a2a2a; transition: transform 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275), box-shadow 0.4s ease, border-color 0.4s ease; border-radius: 12px; overflow: hidden; }
    .product-card:hover { transform: translateY(-10px); border-color: #d4af37; box-shadow: 0 15px 35px rgba(212, 175, 55, 0.15); z-index: 10; }
    .product-img-wrapper { height: 220px; overflow: hidden; background-color: #000; display: flex; align-items: center; justify-content: center; position: relative; }
    .product-img { max-width: 90%; max-height: 90%; object-fit: contain; transition: transform 0.5s ease; }
    .product-card:hover .product-img { transform: scale(1.08); }
    .car-price { color: #d4af37; font-weight: 900; font-size: 1.35rem; text-shadow: 0 2px 4px rgba(0,0,0,0.5); }
    .line-clamp-2 { display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; color: #a0a0a0; }
    
    .btn-outline-light { border-color: #555; color: #ddd; }
    .btn-outline-light:hover { background-color: #fff; color: #000; border-color: #fff; }

    /* CSS THANH TÌM KIẾM */
    .search-glass-wrapper { background: rgba(20, 20, 20, 0.85); backdrop-filter: blur(15px); -webkit-backdrop-filter: blur(15px); border: 1px solid rgba(212, 175, 55, 0.2); border-radius: 20px; box-shadow: 0 10px 25px rgba(0, 0, 0, 0.5), 0 0 15px rgba(212, 175, 55, 0.05); transition: all 0.4s ease; }
    .search-glass-wrapper:hover { border-color: rgba(212, 175, 55, 0.5); box-shadow: 0 10px 30px rgba(0, 0, 0, 0.7), 0 0 20px rgba(212, 175, 55, 0.15); }
    .seamless-search-box { background: #0a0a0a; border: 1px solid rgba(255, 255, 255, 0.1); border-radius: 50px; padding: 4px 4px 4px 18px; display: flex; align-items: center; transition: 0.3s; }
    .seamless-search-box:focus-within { border-color: #D4AF37; background: #111; box-shadow: 0 0 15px rgba(212, 175, 55, 0.2); }
    .seamless-search-box input { background: transparent; border: none; color: #fff; box-shadow: none !important; font-size: 0.95rem; }
    .btn-search-glow { background: linear-gradient(135deg, #D4AF37, #FFD700); color: #000 !important; border-radius: 50px; font-weight: 700; padding: 8px 24px; font-size: 0.85rem; border: none; transition: 0.4s; text-transform: uppercase; letter-spacing: 0.5px; }
    .btn-search-glow:hover { transform: scale(1.03); box-shadow: 0 0 15px rgba(212, 175, 55, 0.5); }
    .trending-pill { background: rgba(255, 255, 255, 0.03); border: 1px solid rgba(255, 255, 255, 0.1); color: #aaa; border-radius: 50px; padding: 5px 14px; font-size: 0.75rem; text-decoration: none; transition: all 0.3s ease; display: inline-flex; align-items: center; }
    .trending-pill:hover { background: rgba(212, 175, 55, 0.1); border-color: #D4AF37; color: #D4AF37; transform: translateY(-2px); }
    .trending-count { font-size: 0.65rem; opacity: 0.5; margin-left: 4px; }
</style>

<%-- THÔNG BÁO TỪ SESSION --%>
<c:if test="${not empty sessionScope.msg}">
    <script>
        Swal.fire({ 
            title: 'TUYỆT VỜI!', text: '${sessionScope.msg}', icon: 'success', 
            background: '#141414', color: '#D4AF37', confirmButtonColor: '#D4AF37',
            timer: 2500, showConfirmButton: false
        });
    </script>
    <c:remove var="msg" scope="session" />
</c:if>
<c:if test="${not empty sessionScope.msgError}">
    <script>
        Swal.fire({ title: 'LỖI HỆ THỐNG!', text: '${sessionScope.msgError}', icon: 'error', background: '#141414', color: '#ff4d4d', confirmButtonColor: '#555' });
    </script>
    <c:remove var="msgError" scope="session" />
</c:if>

<div class="page-title-bg text-center">
    <h1 class="fw-bold display-4 text-warning luxury-logo" style="letter-spacing: 2px;">BỘ SƯU TẬP XE</h1>
    <p class="lead text-light">Khám phá những mẫu xe đỉnh cao nhất tại F-AUTO</p>
</div>

<div class="container" style="margin-top: -45px; position: relative; z-index: 10;">
    <div class="row justify-content-center">
        <div class="col-lg-7 col-md-9">
            <div class="search-glass-wrapper p-3 p-md-4">
                <form action="ProductController" method="GET" class="mb-3">
                    <div class="seamless-search-box">
                        <i class="fa-solid fa-magnifying-glass text-warning small"></i>
                        <input type="text" name="keyword" value="${currentKeyword}" class="form-control ms-2" placeholder="Tìm siêu xe (vd: G63, Porsche...)" autocomplete="off" required>
                        <button type="submit" class="btn-search-glow">TÌM</button>
                    </div>
                </form>
                <div class="d-flex flex-wrap align-items-center justify-content-center gap-2">
                    <span class="text-uppercase text-white-50 fw-bold me-1" style="font-size: 0.7rem; letter-spacing: 0.5px;">
                        <i class="fa-solid fa-fire text-danger mb-1"></i> Hot:
                    </span>
                    <c:forEach items="${topSearches}" var="ts">
                        <a href="ProductController?keyword=${ts.keyword}" class="trending-pill">${ts.keyword} <span class="trending-count">(${ts.searchCount})</span></a>
                    </c:forEach>
                    <c:if test="${empty topSearches}">
                        <a href="ProductController?keyword=Mercedes" class="trending-pill">Mercedes</a>
                        <a href="ProductController?keyword=Porsche" class="trending-pill">Porsche 911</a>
                        <a href="ProductController?keyword=Audi" class="trending-pill">Audi R8</a>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container mb-5 mt-5">
    <ul class="nav nav-tabs justify-content-center f-auto-tabs" id="categoryTabs" role="tablist">
        <c:forEach begin="0" end="6" var="i">
            <li class="nav-item" role="presentation">
                <button class="nav-link ${i == 0 ? 'active' : ''}" id="tab-${i}-btn" data-bs-toggle="tab" data-bs-target="#tab-${i}" type="button" role="tab">${catNames[i]}</button>
            </li>
        </c:forEach>
    </ul>

    <div class="tab-content" id="categoryTabsContent">
        <c:forEach begin="0" end="6" var="catId">
            <div class="tab-pane fade ${catId == 0 ? 'show active' : ''}" id="tab-${catId}" role="tabpanel">
                <div class="row g-4">
                    <c:set var="countProduct" value="0" />
                    <c:forEach items="${listP}" var="p">
                        <c:if test="${catId == 0 || p.categoryID == catId}">
                            <c:set var="countProduct" value="${countProduct + 1}" />
                            <div class="col-md-4 col-lg-3">
                                <div class="card h-100 product-card shadow-sm ${!p.status ? 'opacity-50' : ''}">
                                    <div class="product-img-wrapper">
                                        <img src="${p.imageURL}" class="product-img" alt="${p.productName}" onerror="this.src='https://via.placeholder.com/300x200/111/d4af37?text=F-AUTO'">
                                        <c:if test="${!p.status && sessionScope.user != null && sessionScope.user.role == 1}">
                                            <span class="badge bg-danger position-absolute top-0 end-0 m-2 px-2 py-1 shadow">ĐÃ ẨN</span>
                                        </c:if>
                                    </div>
                                    <div class="card-body d-flex flex-column">
                                        <h5 class="card-title fw-bold text-white mb-2">${p.productName}</h5>
                                        <p class="small mb-3 line-clamp-2">${p.description}</p>
                                        <div class="mt-auto">
                                            <h4 class="car-price mb-3"><fmt:formatNumber value="${p.price}" type="currency" currencySymbol="VNĐ" maxFractionDigits="0"/></h4>
                                            <div class="d-flex justify-content-between align-items-center mb-3">
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
                                                        <%-- NÚT THÊM GIỎ HÀNG CHUẨN: Gọi đến Controller kèm returnUrl --%>
                                                        <a href="CartController?action=addToCart&productId=${p.productID}&returnUrl=ProductController" class="btn btn-warning fw-bold text-dark text-uppercase" style="letter-spacing: 1px;">
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
                            <h4 class="text-secondary"><i class="fa-solid fa-box-open me-2"></i>Không tìm thấy sản phẩm nào.</h4>
                        </div>
                    </c:if>
                    <c:if test="${sessionScope.user != null && sessionScope.user.role == 1}">
                        <div class="col-md-4 col-lg-3">
                            <a href="admin-product-form.jsp" class="card h-100 shadow-sm d-flex flex-column align-items-center justify-content-center text-decoration-none product-card" style="border: 2px dashed #d4af37; min-height: 380px; background-color: rgba(212, 175, 55, 0.03);">
                                <i class="fa-solid fa-circle-plus fa-3x mb-3" style="color: #d4af37;"></i>
                                <h5 class="fw-bold text-center text-uppercase" style="color: #d4af37; letter-spacing: 1px;">
                                    <c:choose>
                                        <c:when test="${catId == 0}">THÊM MỚI SẢN PHẨM</c:when>
                                        <c:otherwise>THÊM ${catNames[catId]}</c:otherwise>
                                    </c:choose>
                                </h5>
                            </a>
                        </div>
                    </c:if>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<jsp:include page="includes/footer.jsp"></jsp:include>