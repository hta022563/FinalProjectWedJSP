<%-- 
    Document   : order-detail
    Created on : Mar 4, 2026, 7:04:38 PM
    Author     : AngDeng
--%>
<%-- File: web/order-detail.jsp --%>
<%-- File: web/order-detail.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="includes/header.jsp"></jsp:include>

<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,600;1,700&family=Montserrat:wght@300;400;600&display=swap" rel="stylesheet">

<style>
    body { background-color: #0a0a0a; color: #e0e0e0; font-family: 'Montserrat', sans-serif; }
    .luxury-title { font-family: 'Playfair Display', serif; color: #D4AF37; text-transform: uppercase; letter-spacing: 2px; text-shadow: 0 2px 10px rgba(212, 175, 55, 0.4); }
    .text-gold { color: #D4AF37 !important; }
    .text-light-grey { color: #cccccc !important; }
    .luxury-container { background: linear-gradient(145deg, #1a1a1a, #121212); border: 1px solid rgba(212, 175, 55, 0.3); border-radius: 15px; box-shadow: 0 10px 30px rgba(0, 0, 0, 0.8), 0 0 15px rgba(212, 175, 55, 0.05); padding: 30px; }
    .table-luxury { --bs-table-bg: transparent; border-color: rgba(212, 175, 55, 0.2); }
    .table-luxury th, .table-luxury td, .table-luxury tr, .table-luxury tbody, .table-luxury thead { background-color: transparent !important; background: none !important; color: #ffffff !important; }
    .table-luxury thead th { background-color: rgba(0, 0, 0, 0.6) !important; border-bottom: 2px solid #D4AF37 !important; color: #D4AF37 !important; font-family: 'Playfair Display', serif; letter-spacing: 1px; text-transform: uppercase; padding: 15px; }
    .table-luxury tbody tr { transition: 0.3s; }
    .table-luxury tbody tr:hover td { background-color: rgba(212, 175, 55, 0.1) !important; }
    .table-luxury td { border-bottom: 1px solid rgba(212, 175, 55, 0.1); vertical-align: middle; padding: 20px 15px; }
    .btn-outline-luxury { color: #D4AF37; border: 1px solid #D4AF37; border-radius: 50px; font-weight: 600; transition: 0.4s; background: transparent; }
    .btn-outline-luxury:hover { background: #D4AF37; color: #000; box-shadow: 0 0 15px rgba(212, 175, 55, 0.5); }
</style>

<div class="container my-5">
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="home.jsp" class="text-gold text-decoration-none">Trang chủ</a></li>
            <li class="breadcrumb-item"><a href="MainController?target=Order&action=history" class="text-gold text-decoration-none">Hồ sơ giao dịch</a></li>
            <li class="breadcrumb-item active text-light-grey" aria-current="page">Chi tiết #${orderId}</li>
        </ol>
    </nav>

    <div class="d-flex justify-content-between align-items-end mb-4 border-bottom border-warning pb-2">
        <h2 class="luxury-title mb-0">CHI TIẾT HỢP ĐỒNG <span class="text-white">#${orderId}</span></h2>
        <a href="MainController?target=Order&action=history" class="btn btn-outline-luxury btn-sm px-3 py-2">
            <i class="fa-solid fa-arrow-left me-2"></i> Quay lại hồ sơ
        </a>
    </div>

    <div class="luxury-container p-0 overflow-hidden">
        <div class="table-responsive">
            <table class="table table-luxury mb-0 text-center align-middle">
                <thead>
                    <tr>
                        <th>Mã SP</th> <th class="text-start">Tên Siêu Phẩm</th> <th>Đơn Giá</th> <th>Số Lượng</th> <th>Thành Tiền</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${listDetails}">
                        <tr>
                            <td class="fw-bold text-light-grey">SP00${item.productID}</td>
                            <td class="text-start fw-bold text-gold fs-5" style="letter-spacing: 0.5px;">${productNames[item.productID]}</td>
                            <td class="text-white"><fmt:formatNumber value="${item.unitPrice}" type="number" pattern="#,###"/> VNĐ</td>
                            <td class="fw-bold text-white fs-5">${item.quantity}</td>
                            <td class="fw-bold text-gold fs-5"><fmt:formatNumber value="${item.unitPrice * item.quantity}" type="number" pattern="#,###"/> VNĐ</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp"></jsp:include>