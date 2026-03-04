<%-- 
    Document   : detail
    Created on : Jan 16, 2026, 10:42:38 AM
    Author     : AngDeng
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%-- 1. KÉO LOGIC LÊN ĐẦU TIÊN ĐỂ NẠP DỮ LIỆU XE --%>
<c:choose>
    <c:when test="${param.id == 2}">
        <c:set var="carName" value="Audi R8 V10" />
        <c:set var="carCode" value="#AUDI-R8-002" />
        <c:set var="carPrice" value="$180,000" />
        <c:set var="carImg" value="IMG/OIP.webp" />
        <c:set var="carDesc" value="Siêu xe thể thao mang động cơ V10 mạnh mẽ, thiết kế khí động học hoàn hảo cho tốc độ đỉnh cao." />
        <c:set var="carId" value="2" />
    </c:when>
    <c:when test="${param.id == 3}">
        <c:set var="carName" value="Mercedes C300" />
        <c:set var="carCode" value="#MER-C300-003" />
        <c:set var="carPrice" value="$65,000" />
        <c:set var="carImg" value="IMG/Mec300.webp" />
        <c:set var="carDesc" value="Mẫu Sedan hạng sang cỡ nhỏ, thiết kế thanh lịch, nội thất hiện đại ngập tràn công nghệ." />
        <c:set var="carId" value="3" />
    </c:when>
    <c:otherwise>
        <%-- Mặc định là G63 (id=1) --%>
        <c:set var="carName" value="Mercedes-Benz G63 AMG" />
        <c:set var="carCode" value="#MER-G63-001" />
        <c:set var="carPrice" value="$200,000" />
        <c:set var="carImg" value="IMG/OIP (2).webp" />
        <c:set var="carDesc" value="Chiếc SUV địa hình mang tính biểu tượng, kết hợp giữa sức mạnh vượt trội và sự sang trọng tuyệt đối." />
        <c:set var="carId" value="1" />
    </c:otherwise>
</c:choose>

<jsp:include page="includes/header.jsp"></jsp:include>

<div class="container my-5">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="home.jsp">Trang chủ</a></li>
            <li class="breadcrumb-item active" aria-current="page">${carName}</li>
        </ol>
    </nav>

    <%-- Thêm div.row để 2 cột col-md-7 và col-md-5 nằm ngang nhau --%>
    <div class="row">
        <div class="col-md-7">
            <div class="card shadow-sm border-0">
                <img src="${carImg}" class="img-fluid rounded" alt="${carName}" style="height: 400px; object-fit: cover;">
            </div>
        </div>

        <div class="col-md-5">
            <h2 class="fw-bold">${carName}</h2>
            <p class="text-muted">Mã xe: ${carCode}</p>
            <h1 class="text-danger fw-bold mb-4">${carPrice}</h1>
            
            <div class="p-3 bg-light rounded mb-4">
                <p><strong><i class="fa-solid fa-check text-success"></i> Tình trạng:</strong> Còn hàng</p>
                <p><strong><i class="fa-solid fa-car"></i> ODO:</strong> 0 km (Mới 100%)</p>
                <p><strong><i class="fa-solid fa-calendar-days"></i> Năm SX:</strong> 2024</p>
            </div>
            
            <p>Mô tả: ${carDesc}</p>
            
            <hr>
            <div class="d-grid gap-2">
                <a href="CartController?action=addToCart&productId=${carId}&quantity=1&returnUrl=detail.jsp?id=${carId}" class="btn btn-danger btn-lg">
                    <i class="fa-solid fa-cart-plus"></i> Đặt cọc ngay (Thêm vào giỏ)
                </a>
                <button class="btn btn-outline-secondary"><i class="fa-solid fa-phone"></i> Liên hệ tư vấn</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<c:if test="${not empty msg}">
    <script>
        Swal.fire({
            title: 'Chốt đơn!',
            text: '${msg}',
            icon: 'success',
            confirmButtonText: 'Hoàn Thành',
            confirmButtonColor: '#dc3545'
        });
    </script>
</c:if>

<jsp:include page="includes/footer.jsp"></jsp:include>