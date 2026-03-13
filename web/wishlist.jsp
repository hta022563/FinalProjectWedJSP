<%-- 
    Document   : wishlist
    Created on : Mar 13, 2026, 6:52:21 PM
    Author     : AngDeng
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="includes/header.jsp"></jsp:include>

<style>
    body { background-color: #0a0a0a; color: #e0e0e0; font-family: 'Montserrat', sans-serif; }
    .page-title { font-family: 'Playfair Display', serif; color: #D4AF37; text-transform: uppercase; letter-spacing: 2px; }
    
    .wishlist-card { background: #111; border: 1px solid rgba(212, 175, 55, 0.2); border-radius: 12px; overflow: hidden; transition: 0.3s; position: relative; }
    .wishlist-card:hover { transform: translateY(-5px); border-color: #D4AF37; box-shadow: 0 10px 25px rgba(212, 175, 55, 0.15); }
    
    .img-box { width: 100%; height: 220px; background: #000; display: flex; align-items: center; justify-content: center; overflow: hidden; }
    .img-box img { max-width: 90%; max-height: 90%; object-fit: contain; transition: transform 0.5s; }
    .wishlist-card:hover .img-box img { transform: scale(1.1); }
    
    .btn-remove-wishlist { position: absolute; top: 15px; right: 15px; width: 35px; height: 35px; border-radius: 50%; background: rgba(0,0,0,0.6); color: #ff4d4d; border: 1px solid #ff4d4d; display: flex; align-items: center; justify-content: center; text-decoration: none; transition: 0.3s; z-index: 10; }
    .btn-remove-wishlist:hover { background: #ff4d4d; color: #fff; }
</style>

<div class="container my-5" style="min-height: 50vh;">
    
    <div class="text-center mb-5 border-bottom border-secondary pb-3">
        <h2 class="page-title"><i class="fa-solid fa-heart text-danger me-2"></i> BỘ SƯU TẬP YÊU THÍCH</h2>
        <p class="text-muted">Nơi lưu giữ những siêu phẩm trong mơ của bạn</p>
    </div>

    <c:if test="${not empty sessionScope.msg}">
        <div class="alert alert-success bg-dark text-warning border-warning text-center fw-bold mb-4">
            <i class="fa-solid fa-check-circle me-2"></i> ${sessionScope.msg}
        </div>
        <c:remove var="msg" scope="session" />
    </c:if>

    <div class="row g-4">
        <c:choose>
            <c:when test="${empty listWishlistCars}">
                <div class="col-12 text-center py-5">
                    <i class="fa-regular fa-heart fa-4x text-secondary mb-3 opacity-25"></i>
                    <h5 class="text-secondary fw-bold">Danh sách yêu thích của bạn đang trống!</h5>
                    <p class="text-muted mb-4">Hãy dạo quanh Showroom và thả tim những siêu phẩm bạn thích nhé.</p>
                    <a href="MainController?target=Product" class="btn btn-outline-warning rounded-pill px-5 fw-bold">KHÁM PHÁ KHO XE</a>
                </div>
            </c:when>
            
            <c:otherwise>
                <c:forEach items="${listWishlistCars}" var="p">
                    <div class="col-md-4 col-lg-3">
                        <div class="wishlist-card h-100 d-flex flex-column">
                            
                            <a href="MainController?target=Wishlist&action=remove&productId=${p.productID}" class="btn-remove-wishlist" title="Bỏ yêu thích">
                                <i class="fa-solid fa-xmark"></i>
                            </a>

                            <div class="img-box">
                                <img src="${p.imageURL}" onerror="this.src='IMG/logo.jpg'" alt="${p.productName}">
                            </div>
                            
                            <div class="card-body p-4 d-flex flex-column">
                                <h5 class="fw-bold text-white mb-2" style="font-size: 1.1rem;">${p.productName}</h5>
                                <h4 class="text-warning fw-bold mb-3"><fmt:formatNumber value="${p.price}" type="number" pattern="#,###"/> đ</h4>
                                
                                <div class="mt-auto d-grid gap-2">
                                    <a href="MainController?target=Detail&pid=${p.productID}" class="btn btn-outline-light btn-sm fw-bold">XEM CHI TIẾT</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="includes/footer.jsp"></jsp:include>