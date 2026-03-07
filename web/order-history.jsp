<%-- 
    Document   : order-history
    Created on : Mar 3, 2026, 6:37:36 PM
    Author     : AngDeng
--%>

<%-- File: web/order-history.jsp --%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="includes/header.jsp"></jsp:include>

<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,600;1,700&family=Montserrat:wght@300;400;600&display=swap" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>
    body { background-color: #0a0a0a; color: #e0e0e0; font-family: 'Montserrat', sans-serif; }
    
    .luxury-title { font-family: 'Playfair Display', serif; color: #D4AF37; text-transform: uppercase; letter-spacing: 2px; text-shadow: 0 2px 10px rgba(212, 175, 55, 0.4); }
    .text-gold { color: #D4AF37 !important; }
    .text-light-grey { color: #cccccc !important; }

    .luxury-container {
        background: linear-gradient(145deg, #1a1a1a, #121212); border: 1px solid rgba(212, 175, 55, 0.3);
        border-radius: 15px; box-shadow: 0 10px 30px rgba(0, 0, 0, 0.8), 0 0 15px rgba(212, 175, 55, 0.05); padding: 30px;
    }

    .table-luxury { --bs-table-bg: transparent; border-color: rgba(212, 175, 55, 0.2); }
    .table-luxury th, .table-luxury td, .table-luxury tr, .table-luxury tbody, .table-luxury thead {
        background-color: transparent !important; background: none !important; color: #ffffff !important; 
    }
    .table-luxury thead th {
        background-color: rgba(0, 0, 0, 0.6) !important; border-bottom: 2px solid #D4AF37 !important;
        color: #D4AF37 !important; font-family: 'Playfair Display', serif; letter-spacing: 1px; text-transform: uppercase; padding: 15px;
    }
    .table-luxury tbody tr { transition: 0.3s; }
    .table-luxury tbody tr:hover td { background-color: rgba(212, 175, 55, 0.1) !important; }
    .table-luxury td { border-bottom: 1px solid rgba(212, 175, 55, 0.1); vertical-align: middle; padding: 15px; }

    .btn-outline-luxury { color: #D4AF37; border: 1px solid #D4AF37; border-radius: 50px; font-weight: 600; transition: 0.4s; background: transparent; }
    .btn-outline-luxury:hover { background: #D4AF37; color: #000; box-shadow: 0 0 15px rgba(212, 175, 55, 0.5); }
    
    .btn-outline-danger-lux { color: #ff4d4d; border: 1px solid #ff4d4d; border-radius: 50px; font-weight: 600; transition: 0.4s; background: transparent; }
    .btn-outline-danger-lux:hover { background: #ff4d4d; color: #fff; box-shadow: 0 0 15px rgba(255, 77, 77, 0.5); }

    .badge-luxury { background: rgba(212, 175, 55, 0.1) !important; border: 1px solid #D4AF37; color: #D4AF37 !important; padding: 8px 12px; border-radius: 50px; font-weight: 600; letter-spacing: 1px; }

    /* HUD Cảnh Báo Công Nghệ Cao */
    .tech-popup { background: linear-gradient(145deg, #111111, #080808) !important; border: 1px solid rgba(212, 175, 55, 0.4) !important; box-shadow: 0 0 50px rgba(0, 0, 0, 0.9), inset 0 0 20px rgba(212, 175, 55, 0.05) !important; border-radius: 12px !important; overflow: hidden; position: relative; }
    .tech-popup::before { content: ""; position: absolute; top: 0; left: 0; right: 0; height: 2px; background: rgba(212, 175, 55, 0.8); box-shadow: 0 0 15px #D4AF37, 0 0 5px #fff; animation: scanline 2.5s linear infinite; z-index: 10; pointer-events: none; }
    @keyframes scanline { 0% { top: -5%; opacity: 0; } 10% { opacity: 1; } 90% { opacity: 1; } 100% { top: 105%; opacity: 0; } }
    .tech-btn-confirm { background: transparent !important; color: #ff4d4d !important; border: 1px solid #ff4d4d !important; box-shadow: 0 0 10px rgba(255, 77, 77, 0.1) !important; border-radius: 4px !important; text-transform: uppercase; letter-spacing: 1px; font-family: 'Montserrat', sans-serif; font-weight: 600 !important; transition: 0.3s all !important; }
    .tech-btn-confirm:hover { background: #ff4d4d !important; color: #000 !important; box-shadow: 0 0 25px rgba(255, 77, 77, 0.8) !important; transform: scale(1.05); }
    .tech-btn-cancel { background: transparent !important; color: #aaa !important; border: 1px solid #555 !important; border-radius: 4px !important; text-transform: uppercase; letter-spacing: 1px; font-family: 'Montserrat', sans-serif; transition: 0.3s all !important; }
    .tech-btn-cancel:hover { border-color: #D4AF37 !important; color: #D4AF37 !important; box-shadow: 0 0 15px rgba(212, 175, 55, 0.3) !important; }
</style>

<script>
    function xoaDonHang(event, url, orderId) {
        event.preventDefault();
        Swal.fire({
            title: '<div style="font-family: \'Playfair Display\', serif; color: #D4AF37; letter-spacing: 4px; border-bottom: 1px solid rgba(212,175,55,0.3); padding-bottom: 15px; margin-bottom: 10px; font-size: 1.6rem; text-shadow: 0 0 10px rgba(212,175,55,0.3);">CẢNH BÁO HỆ THỐNG</div>',
            html: '<p style="color: #e0e0e0; font-family: \'Montserrat\', sans-serif; font-size: 1.1rem; margin-top: 20px;">Yêu cầu hủy hợp đồng mã <b style="color: #ff4d4d; text-shadow: 0 0 8px rgba(255,77,77,0.8); font-size: 1.3rem;">#' + orderId + '</b>.</p><p style="color: #888; font-size: 0.9rem; font-style: italic; margin-top: 15px;"><i class="fa-solid fa-shield-halved text-warning me-1"></i> Dữ liệu sẽ bị xóa vĩnh viễn khỏi máy chủ và không thể khôi phục.</p>',
            icon: 'warning', iconColor: '#ff4d4d', background: 'transparent',
            backdrop: `rgba(0, 0, 0, 0.85) backdrop-filter: blur(8px)`,
            showCancelButton: true,
            confirmButtonText: '<i class="fa-solid fa-fingerprint me-2"></i> XÁC NHẬN HỦY',
            cancelButtonText: '<i class="fa-solid fa-rotate-left me-2"></i> QUAY LẠI',
            customClass: { popup: 'tech-popup', confirmButton: 'tech-btn-confirm px-4 py-2 mx-2', cancelButton: 'tech-btn-cancel px-4 py-2 mx-2' },
            buttonsStyling: false
        }).then((result) => {
            if (result.isConfirmed) {
                Swal.fire({
                    title: '<span style="color: #D4AF37; font-family: Playfair Display; letter-spacing: 2px;">ĐANG THỰC THI...</span>',
                    html: '<span style="color: #aaa; font-family: Montserrat;">Hệ thống đang vô hiệu hóa hợp đồng #' + orderId + '</span>',
                    allowOutsideClick: false, background: '#0a0a0a', backdrop: `rgba(0,0,0,0.9)`,
                    didOpen: () => { Swal.showLoading(); setTimeout(() => { window.location.href = url; }, 800); }
                });
            }
        })
    }
</script>

<div class="container my-5">
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="home.jsp" class="text-gold text-decoration-none">Trang chủ</a></li>
            <li class="breadcrumb-item active text-light-grey" aria-current="page">Hồ sơ giao dịch</li>
        </ol>
    </nav>
    
    <div class="d-flex justify-content-between align-items-end mb-4 border-bottom border-warning pb-2">
        <h2 class="luxury-title mb-0">Hồ Sơ Giao Dịch</h2>
    </div>

    <c:if test="${not empty msg}">
        <script>Swal.fire({ title: 'Thông báo', text: '${msg}', icon: 'success', background: '#121212', color: '#D4AF37', confirmButtonColor: '#D4AF37' });</script>
    </c:if>

    <div class="luxury-container p-0 overflow-hidden">
        <div class="table-responsive">
            <table class="table table-luxury mb-0 text-center align-middle">
                <thead>
                    <tr>
                        <th class="ps-4 text-start">Mã Hợp Đồng</th> <th>Ngày Lập</th> <th class="text-start">Địa Chỉ Giao Xe</th> <th>Tổng Giá Trị</th> <th>Trạng Thái</th> <th>Thao Tác</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty listOrders}">
                            <tr>
                                <td colspan="6" class="text-center py-5">
                                    <i class="fa-solid fa-file-contract mb-3" style="font-size: 4rem; color: #333;"></i><br>
                                    <span class="fs-5 fw-bold text-light-grey">Bạn chưa có hồ sơ giao dịch nào.</span>
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="order" items="${listOrders}">
                                <tr>
                                    <td class="fw-bold text-gold text-start ps-4 fs-5">#${order.orderID}</td>
                                    <td class="text-light-grey"><fmt:formatDate value="${order.orderDate}" pattern="dd/MM/yyyy HH:mm" /></td>
                                    <td class="text-start text-light-grey" style="max-width: 250px;">${order.shippingAddress}</td>
                                    <td class="fw-bold text-white fs-5"><fmt:formatNumber value="${order.totalAmount}" type="number" pattern="#,###"/> VNĐ</td>
                                    <td><span class="badge badge-luxury"><i class="fa-solid fa-clock me-1"></i> ${order.status}</span></td>
                                    <td>
                                        <div class="d-flex justify-content-center gap-2">
                                            <a href="OrderController?action=detail&id=${order.orderID}" class="btn btn-sm btn-outline-luxury px-3">
                                                <i class="fa-solid fa-eye"></i> Xem
                                            </a>
                                            <a href="OrderController?action=delete&id=${order.orderID}" class="btn btn-sm btn-outline-danger-lux px-3" onclick="xoaDonHang(event, this.href, '${order.orderID}')">
                                                <i class="fa-solid fa-trash"></i> Hủy
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
    <div class="mt-4 text-start">
        <a href="home.jsp" class="btn btn-outline-luxury"><i class="fa-solid fa-arrow-left me-2"></i> Trở về Showroom</a>
    </div>
</div>

<jsp:include page="includes/footer.jsp"></jsp:include>