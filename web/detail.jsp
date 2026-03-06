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

<div class="container my-5">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="home.jsp" class="text-decoration-none text-danger fw-bold">Trang chủ</a></li>
            <li class="breadcrumb-item active" aria-current="page">${carName}</li>
        </ol>
    </nav>

    <div class="row mt-4">
        <div class="col-md-7 mb-4">
            <div class="card shadow-sm border-0 mb-3">
                <img src="${carImg}" class="img-fluid rounded" alt="${carName}" style="height: 450px; object-fit: cover; width: 100%;">
            </div>
        </div>

        <div class="col-md-5 ps-md-4">
            <h2 class="fw-bold mb-1">${carName}</h2>
            <p class="text-muted mb-3">Mã xe: ${carCode}</p>
            <h1 class="text-danger fw-bold mb-4">${carPrice} VNĐ</h1>
            
            <div class="p-4 bg-light rounded shadow-sm mb-4 border-start border-danger border-4">
                <p class="mb-2 fs-5"><strong><i class="fa-solid fa-check text-success me-2"></i> Tình trạng:</strong> Còn hàng</p>
                <p class="mb-2 fs-5"><strong><i class="fa-solid fa-car me-2"></i> ODO:</strong> 0 km (Mới 100%)</p>
            </div>
            
            <p class="fs-6 lh-lg text-secondary"><strong>Mô tả:</strong> ${carDesc}</p>
            <hr class="my-4">
            
            <form action="CartController" method="POST" class="d-grid gap-3">
                <input type="hidden" name="action" value="addToCart">
                <input type="hidden" name="productId" value="${carId}">
                <input type="hidden" name="quantity" value="1">
                <input type="hidden" name="returnUrl" value="detail.jsp?id=${carId}">
                
                <button type="submit" class="btn btn-danger btn-lg py-3 fw-bold shadow-sm">
                    <i class="fa-solid fa-cart-plus me-2"></i> Đặt cọc ngay (Thêm vào giỏ)
                </button>
            </form>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp"></jsp:include>