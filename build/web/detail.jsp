<%-- 
    Document   : detail
    Created on : Jan 16, 2026, 10:42:38 AM
    Author     : AngDeng
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="includes/header.jsp"></jsp:include>

<div class="container my-5">
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="home.jsp">Trang chủ</a></li>
            <li class="breadcrumb-item active" aria-current="page">Mercedes-Benz G63</li>
        </ol>
    </nav>

    <div class="row">
        <div class="col-md-7">
            <div class="card shadow-sm border-0">
                <img src="https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?auto=format&fit=crop&w=1000&q=80" class="img-fluid rounded" alt="Car Detail">
            </div>
            <div class="row mt-3">
                <div class="col-3"><img src="https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?auto=format&fit=crop&w=200&q=60" class="img-thumbnail"></div>
                <div class="col-3"><img src="https://images.unsplash.com/photo-1542282088-fe8426682b8f?auto=format&fit=crop&w=200&q=60" class="img-thumbnail"></div>
            </div>
        </div>

        <div class="col-md-5">
            <h2 class="fw-bold">Mercedes-Benz G63 AMG</h2>
            <p class="text-muted">Mã xe: #MER-G63-001</p>
            <h1 class="text-danger fw-bold mb-4">$200,000</h1>
            
            <div class="p-3 bg-light rounded mb-4">
                <p><strong><i class="fa-solid fa-check text-success"></i> Tình trạng:</strong> Còn hàng</p>
                <p><strong><i class="fa-solid fa-car"></i> ODO:</strong> 0 km (Mới 100%)</p>
                <p><strong><i class="fa-solid fa-calendar-days"></i> Năm SX:</strong> 2024</p>
            </div>
            
            <p>Mô tả: Chiếc SUV địa hình mang tính biểu tượng, kết hợp giữa sức mạnh vượt trội và sự sang trọng tuyệt đối của nội thất da cao cấp.</p>
            
            <hr>
            <div class="d-grid gap-2">
                <button class="btn btn-danger btn-lg"><i class="fa-solid fa-cart-shopping"></i> Đặt cọc ngay</button>
                <button class="btn btn-outline-secondary"><i class="fa-solid fa-phone"></i> Liên hệ tư vấn</button>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp"></jsp:include>