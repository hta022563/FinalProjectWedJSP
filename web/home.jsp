<%-- 
    Document   : home
    Created on : Jan 16, 2026, 10:17:41 AM
    Author     : AngDeng
--%>

<%-- File: web/home.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="includes/header.jsp"></jsp:include>

<div class="p-5 text-center bg-image" style="
     background-image: url('IMG/505329.jpg');
     height: 400px; background-size: cover; background-position: center;">
    <div class="d-flex justify-content-center align-items-center h-100">
        <div class="text-white bg-dark bg-opacity-50 p-4 rounded">
            <h1 class="mb-3 fw-bold">SĂN XE SANG - GIÁ CỰC TỐT</h1>
            <a class="btn btn-danger btn-lg" href="#showroom" role="button">Xem ngay</a>
        </div>
    </div>
</div>

<div class="container mt-4">
    <div class="card p-3 shadow-sm border-0">
        <form class="row g-2">
            <div class="col-md-5">
                <input type="text" class="form-control" placeholder="Tìm tên xe...">
            </div>
            <div class="col-md-3">
                <select class="form-select"><option>Tất cả hãng</option><option>BMW</option></select>
            </div>
            <div class="col-md-2">
                <select class="form-select"><option>Giá</option><option>Dưới 1 tỷ</option></select>
            </div>
            <div class="col-md-2">
                <button type="button" class="btn btn-primary w-100">Tìm kiếm</button>
            </div>
        </form>
    </div>
</div>

<div class="container mt-5 mb-5" id="showroom">
    <h3 class="text-center mb-4 text-uppercase border-bottom pb-2 border-danger d-inline-block">Xe Mới Về</h3>
    <div class="row">
        <div class="col-md-4 mb-4">
            <div class="card h-100 border-0 shadow-sm hover-shadow">
                <img src="IMG/OIP (2).webp" class="card-img-top" style="height:200px; object-fit:cover">
                <div class="card-body">
                    <h5 class="card-title">Mercedes-Benz G63</h5>
                    <p class="text-muted small">SUV | 2024</p>
                    <h5 class="text-danger fw-bold">$200,000</h5>
                </div>
                <div class="card-footer bg-white border-0 text-center pb-3">
                    <a href="detail.jsp" class="btn btn-outline-dark w-100">Xem chi tiết</a>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-4">
            <div class="card h-100 border-0 shadow-sm hover-shadow">
                <img src="IMG/OIP.webp" class="card-img-top" style="height:200px; object-fit:cover">
                <div class="card-body">
                    <h5 class="card-title">Audi R8 V10</h5>
                    <p class="text-muted small">Sport | 2023</p>
                    <h5 class="text-danger fw-bold">$180,000</h5>
                </div>
                <div class="card-footer bg-white border-0 text-center pb-3">
                    <a href="detail.jsp" class="btn btn-outline-dark w-100">Xem chi tiết</a>
                </div>
            </div>
        </div>
         <div class="col-md-4 mb-4">
            <div class="card h-100 border-0 shadow-sm hover-shadow">
                <img src="IMG/Mec300.webp" class="card-img-top" style="height:200px; object-fit:cover">
                <div class="card-body">
                    <h5 class="card-title">Mercedes C300</h5>
                    <p class="text-muted small">Sedan | 2025</p>
                    <h5 class="text-danger fw-bold">$65,000</h5>
                </div>
                <div class="card-footer bg-white border-0 text-center pb-3">
                    <a href="detail.jsp" class="btn btn-outline-dark w-100">Xem chi tiết</a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp"></jsp:include>